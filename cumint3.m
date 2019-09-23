function z = cumint3(x,y)
%
%   z = cumint3(x,y)
%
% This returns a vector z the same size as x and y
% which is the cumulative integral of y with respect
% to x, with the lower integration limit set to x(1) and
% the upper limit ranging from x(1) to x(n). The
% successive intervals in x need not be of equal lengths, 
% though none should be of zero length. A third order
% approximation is made so that for up to cubic polynomials
% the values will be exact except for rounding. 
% x and y must be column vectors of the same length
% and have at least four elements. Note that with only 
% z = b.*g below, this would be computing matlab's
% 'cumtrapz' trapezoidal integration, the rest of the
% expression in z serving to carry out the additional
% third order approximation.  RAS - 03/11/08
% Test arguments
[n,m] = size(x);
if any([n,m]~=size(y)) | m~=1
 error('x and y must be column vectors of equal length.')
end
if n<4
 error('There must be at least four points.')
end
% Compute third order integral
xe = [x(4);x;x(n-3)]; ye = [y(4);y;y(n-3)]; % Provide for endpoints
x0 = xe(1:n-1); x1 = xe(2:n); x2 = xe(3:n+1); x3 = xe(4:n+2);
y0 = ye(1:n-1); y1 = ye(2:n); y2 = ye(3:n+1); y3 = ye(4:n+2);
a = x1-x0; b = x2-x1; c = x3-x2;
d = y1-y0; e = y2-y1; f = y3-y2;
g = (y1+y2)/2;
% Each z value will be the integral from x1 to x2 of a cubic
% polynomial running through (x0,y0),(x1,y1),(x2,y2),(x3,y3).
z = b.*g+1/12*b.^2.*(+c.*b.*(2*c+b).*(c+b).*d ...
    -a.*c.*(c-a).*(2*c+2*a+3*b).*e-a.*b.*(2*a+b).*(a+b).*f) ...
    ./(a.*c.*(a+b).*(c+b).*(c+a+b));
	
% Obtain cumulative integral values
z = [0;cumsum(z)];
return

