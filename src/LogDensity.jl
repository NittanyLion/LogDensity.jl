module LogDensity

using QuadGK, SpecialFunctions, LinearAlgebra

export logdensityderivatives, logdensity

include( "util.jl" )
include( "sanity.jl" )
include( "kernels.jl" )
include( "g.jl" )
include( "main.jl" )


end
