function sanity_checks_basic( X, x, S, h, minx, maxx )
    jassert( 1 ≤ S ≤ length( X ), "polynomial order $S must be at least one and no greater than the sample size")
    jassert( 0.0 < h < Inf, "bad bandwidth $h")
    jassert( minx ≤ minimum( X ), "data points less than $minx" )
    jassert( maxx ≥ maximum( X ), "data points greater than $maxx" )
    jassert( minx ≤ minimum( x ), "evaluation points less than $minx" )
    jassert( maxx ≥ maximum( x ), "evaluation points greater than $maxx" )
    return nothing
end

function sanity_checks_g( g, S, z, zl, zr )
    for t ∈ eachindex( z ), j ∈ 1:S
        jassert( g( -z[t], j, z[t], zr[t] ) == 0.0, "function g used is not zero at lower boundary" )
        jassert( g( zr[t], j, z[t], zr[t] ) == 0.0, "function g used is not zero at upper boundary" )
    end
    return nothing
end
