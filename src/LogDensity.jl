module LogDensity

using QuadGK, SpecialFunctions, LinearAlgebra

export logdensityderivatives, logdensity
# export epanechnikov, gaussian, triweight, uniform, cosinus, quartic


function __init__()
    println("\n\n")
    printstyled( " Thank you for using the LogDensity package\n"; bold = true, color=:green )
    println( "This package implements the Pinkse-Schurter (Econometric Theory)")
    println( "estimator, which estimates the log density and its derivative,")
    println( "including at the boundaries.")
    println( "See https://github.com/NittanyLion/LogDensity for documentation")
    println( "In the REPL, you can also type ?logdensity and ?logdensityderivatives")
    println("\n: please direct all questions/suggestions/comments to Joris Pinkse at joris@psu.edu\n\n")
end

include( "util.jl" )
include( "sanity.jl" )
include( "kernels.jl" )
include( "g.jl" )
include( "main.jl" )


end
