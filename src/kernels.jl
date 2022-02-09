# some kernels
epanechnikov(x::Float64) =  (abs(x) <= 1.0) ? 0.75 * (1.0-x*x) : 0.0
gaussian(x::Float64) = exp( -0.5 * x * x) * 0.3989422804014327
triweight(x::Float64) = (abs(x)<=1.0) ? 1.09375 * (1.0-x*x)^3  : 0.0
uniform(x::Float64) = (abs(x)<=1.0) ? 0.5 : 0.0
cosinus(x::Float64) = (abs(x)<=1.0) ?   0.7853981633974483    * cos( 1.5707963267948966 * x ) : 0.0
quartic(x::Float64) = (abs(x)<=1.0) ? (0.9375 * (1.0 - x*x)^2) : 0.0
