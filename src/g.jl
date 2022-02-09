# default choices for g and dg
g(u::T, j::Int64, zl = 0.0, zr = 1.0) where {T<:Real} =  - ( u + zl )^ j * (zr -u) 
dg(u::T, j::Int64, zl = 0.0, zr = 1.0) where {T<:Real} = ( u + zl )^(j-1) * ( (j+1) * u + zl - j * zr ) 

