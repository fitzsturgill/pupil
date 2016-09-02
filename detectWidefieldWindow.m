function [center, radius] = detectWidefieldWindow(im, makePlots)
% received from Matt Kaufman 2016
% [center, radius] = detectWidefieldWindow(im [, makePlots])
% 
% Take a widefield image (such as the median or mean image of a movie) and
% automatically detect the window center and circular boundary.
% 
% To do so, first assume the center of the image is the center of the
% window. Find the falloff of brightness with distance from the center. If
% we have the correct center, the falloff of the curve should be abrupt.
% So, try each of the 4 cardinal directions relative to the center and test
% the falloff slopes there too. Use whichever point has the steepest
% falloff, and repeat until we've found the centerpoint with the steepest
% falloff.
% 
% In practice, to improve performance we start with a step size of 20 until
% convergence, then 10, then 5. Slope is assessed as the distance between
% 10% and 50% of the way from the minimum value to the maximum value. The
% radius is at 30% from the minimum value to the maximum value.
% 
% center is [y x]. radius is in pixels. makePlots determines whether the
% falloff and image are shown, default true.
% 
% On the image plots, the window estimate is shown as a red circle, the
% initial center value (center of the image) as a blue cross, and the final
% estimate of the center as a red cross.


%% Parameters 

nBins = 50;
centerRes = [20 10 5];


if ~exist('makePlots', 'var')
  makePlots = 1;
end


%% Set up image

% For some bizarre reason, if we don't manually convert im to double
% something gets screwed up in the accumulation step of computing mean
% brightness per bin.
im = double(im);
siz = size(im);
im = im(:);

[X, Y] = meshgrid(1:siz(2), 1:siz(1));
locs = [Y(:), X(:)];


%% Find center

origCenter = siz / 2 + 0.5;
center = origCenter;
nIters = 0;

% Current value will be last element for each of the below
slopes = zeros(1, 5);
radii = zeros(1, 5);

% Get us started with the exact center value
[means, edges] = computeMeans(im, locs, center, nBins);
[radii(5), slopes(5)] = computeSlope(means, edges(2) - edges(1));

% Loop through resolutions
for res = centerRes
  % Try the four cardinal directions
  while 1
    nIters = nIters + 1;
    
    % Find falloff and compute slope
    % Note: could make this 1/4 more efficient by not recomputing the
    % direction we came from, but I thought it wasn't worth the code
    % complexity.
    c = bsxfun(@plus, center, res * [-1 0; 0 1; 1 0; 0 -1]);
    for news = 1:4  % North East South West
      [means, edges] = computeMeans(im, locs, c(news, :), nBins);
      [radii(news), slopes(news)] = computeSlope(means, edges(2) - edges(1));
    end
    
    % Find best center
    [~, bestDir] = max(slopes);
    
    % Check if we're already at the best spot
    if bestDir == 5
      break;
    end
    
    % Otherwise, initialize the next run with the best center
    center = c(bestDir, :);
    slopes(5) = slopes(bestDir);
    radii(5) = radii(bestDir);
  end
end

radius = radii(5);
fprintf('Identifying the best center took %d iterations\n', nIters);


%% Recompute falloff for best center

[means, edges] = computeMeans(im, locs, center, nBins);


if makePlots
  %% Plot falloff
  
  figure;
  barStacked(edges, means', {'k'});
  hold on;
  plot(radius * [1 1], [0 max(means)], 'r-');
  set(gca, 'TickDir', 'out', 'Box', 'off');
  
  xlabel('Distance from center');
  ylabel('Brightness');
  
  
  %% Plot image with circle and center
  
  figure;
  imagesc(reshape(im, siz));
  colormap(gray);
  hold on;
  plot(origCenter(2), origCenter(1), 'b+');
  plot(center(2), center(1), 'r+');
  rectangle('Position', [center(2)-radius, center(1)-radius, 2*radius, 2*radius], ...
    'Curvature', [1 1], 'EdgeColor', 'r');
  axis equal;
  set(gca, 'TickDir', 'out', 'Box', 'off');
end



function [means, edges] = computeMeans(im, locs, c, nBins)

% Get distance of each pixel to center
rads = sqrt(sum(bsxfun(@minus, locs, [c(1) c(2)]) .^ 2, 2));

% Find bin for each pixel
maxRad = max(rads);
edges = linspace(0, maxRad + 1e-10, nBins + 1);
[counts, binInds] = histc(rads, edges);

% Compute mean brightness per bin
means = zeros(1, nBins);
for u = 1:length(im)
  means(binInds(u)) = means(binInds(u)) + im(u);
end
% -1 is for extra bin produced by histc
means = means ./ counts(1:end-1)';



function [radius, slope] = computeSlope(means, binWidth)
% Compute the slope from the 50th percentile to the 10th. Make it positive.
% Also get the radius at the 30th percentile.

% The first two elements of quants are to get the falloff slope. These
% should be higher value first, then lower value. The last element is the
% radius threshold. Each should be a fraction [0-1], and represent the
% fraction from the min value to the max value.
quants = [0.5 0.1 0.3];

mx = max(means);
mn = min(means);

ys = quants * (mx - mn) + mn;

pts = zeros(1, 3);
for i = 1:length(ys)
  pts(i) = find(means < ys(i), 1);
end

slope = binWidth * (ys(1) - ys(2)) / (pts(2) - pts(1));
radius = binWidth * pts(3);
