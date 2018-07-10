

[x, y] = ind2sub(size(rawFrame), 1:numel(rawFrame));
eyeDomain = [x; y];
theEye = find(eyeMaskRaw);
eyePoints = eyeDomain(:, theEye);
% hullPoints = convhulln(eyePoints');
% eyePoints = 
% [x, y] = ind2sub([stats.BoundingBox(4) stats.BoundingBox(3)], theEye);
% eyePoints = [x y]';
[A, c] = MinVolEllipse(eyePoints, 1);
mysolution = (eyePoints - c) * A * (eyePoints - c)';

