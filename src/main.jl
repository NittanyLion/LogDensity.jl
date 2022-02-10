



const τ = 1.7724538509055159




function derivatives1!( β, Xh, xh, h, z, zr, g, dg )
    for t ∈ eachindex( xh )
        v = Xh .- xh[t]
        u = v[ -z[t] .≤ v .≤ zr[t] ]
        left = right = zero( eltype( β ) ) 
        for i ∈ eachindex( u )
            left += dg( u[i], 1, z[t], zr[t] ) 
            right += g( u[i], 1, z[t], zr[t] ) 
        end
        β[t,1] = - left / ( right * h )
    end
    return nothing
end

function derivativesmulti!( β, S, Xh, xh, h, z, zr, g, dg )
    mult = [ h^(s-1) / factorial(s-1) for s ∈ 1:S ]
    for t ∈ eachindex( xh )
        v = Xh .- xh[t]
        u = v[ -z[t] .≤ v .≤ zr[t] ]
        Tp = eltype( β )
        left = zeros( Tp, S ); right = zeros( Tp, S, S )
        for j ∈ 1:S
            for i ∈ eachindex( u )
                left[j] += dg( u[i], j, z[t], zr[t] )
                Rij = g( u[i], j, z[t], zr[t] ) 
                for s ∈ 1:S
                    right[j,s] += Rij * u[i]^(s-1) * mult[s]
                end
            end                 
        end
        β[t,:] = - ( right \ left ) / h
    end
    return nothing
end



function common( X, x, S, h, minx, maxx, anal )
    sanity_checks_basic( X, x, S, h, minx, maxx )
    Xh = ( X .- minx ) / h;  xh = ( x .- minx ) / h;  maxxh = (maxx - minx ) / h
    Tp = eltype( X )
    z = min.(xh, one( Tp ) );  zr = min.(maxxh .- xh, one( Tp ) )
    anal && sanity_checks_g( g, S, z, zl, zr )
    β = Array{Tp}(undef, length(x), S)
    return ( β, Xh, xh, z, zr, S )
end

"""
    β = logdensityderivatives( X, x, h; various optional arguments )

    Computes estimates of the derivatives of the log density of the data 
    in the vector X evaluated at the elements in the vector x, using the 
    bandwidth h. Returns a matrix β with rows corresponding to the 
    evaluation points and columns to the derivatives.  This is a matrix
    even if S = 1.

# Mandatory arguments
- `X::Vector{T}`: vector of data 
- `x::Vector{T}`: vector of evaluation points
- `h::T`: bandwidth

T is the floating point type

# Optional arguments
- `g::Function=g`: the function g to be used (see Pinkse and Schurter)
- `dg::Function=dg`: its derivative
- `S::Int=1`: the number of derivatives to be computed
- `minx::T=0.0`: the left hand side of the support
- `maxx::T=Inf`: the right hand side of the support
- `anal::Bool=true`: whether to run many sanity checks
"""
function logdensityderivatives(
    X::Vector{Tp},                    # data
    x::Vector{Tp},                    # evaluation points
    h::Tp;                            # bandwidth
    g = g,                            # g-function in paper
    dg = dg,                          # its derivative                                        
    S = 1,                            # degree 
    minx = 0.0,                       # bottom of support
    maxx = Inf,                       # top of support
    anal = true                       # whether to be fussy about checking arguments
    ) where {Tp<:Real}


    ( β, Xh, xh, z, zr, S ) = common( X, x, S, h, minx, maxx, anal )
    if S == 1
        derivatives1!( β, Xh, xh, h, z, zr, g, dg )
    else
        derivativesmulti!( β, S, Xh, xh, h, z, zr, g, dg )
    end
    return β
end

denfunc( x, c ) = 0.75 * ((c == 0.0) ? x - x^3 / 3.0 : exp( c * x ) * ( c*c * (1.0-x*x) + 2.0 * c * x - 2.0 ) / c^3)
function denfunc(x, a, b ) 
    b==0.0 && return denfunc( x, a ) 
    if b > 0.0
        sqrtb = sqrt(b)
        γ = 0.5 * (a + 2.0*b*x) / sqrtb
        return 0.75 * (- 0.125 * exp(-0.25*a*a/b) * ( τ * (a*a - 2.0 * b * (2.0*b+1.0) ) * erfi(γ) -
            2 * sqrtb * exp(γ*γ) * (a-2.0*b * x) ) / sqrtb^5)
    end
    b = -b
    sqrtb = sqrt(b)
    0.75 * (exp( x * (a-b*x)) * ( a + 2.0 * b *x ) * 0.25 / (b*b) - τ  * ( a * a + 2.0 * (1.0 - 2.0 * b ) * b) * exp( a*a *0.25/b) * erf( ( b*x -0.5*a ) / sqrtb ) * 0.125 / sqrtb^5)
end


"""
    β = logdensity( X, x, h; various optional arguments )

    Computes estimates of the log density and its derivatives of the data 
    in the vector X evaluated at the elements in the vector x, using the 
    bandwidth h. Returns a tuple ( logf, β ) where logf is a vector whose
    elements correspond to the evaluation points and β a matrix with rows 
    corresponding to the evaluation points and columns to the derivatives;  
    this is a matrix even if S = 1.

# Mandatory arguments
- `X::Vector{T}`: vector of data 
- `x::Vector{T}`: vector of evaluation points
- `h::T`: bandwidth

T is the floating point type

# Optional arguments
- `g::Function=g`: the function g to be used (see Pinkse and Schurter)
- `dg::Function=dg`: its derivative
- `S::Int=1`: the number of derivatives to be computed
- `minx::T=0.0`: the left hand side of the support
- `maxx::T=Inf`: the right hand side of the support
- `logf::Bool=true`: whether the log density itself should be computed
- `mz::Function=epanechnikov`: the kernel to be used for the log density itself
- `anal::Bool=true`: whether to run many sanity checks
"""
function logdensity(
    X::Vector{Tp},                    # data
    x::Vector{Tp},                    # evaluation points
    h::Tp;                            # bandwidth
    g = g,                            # g-function in paper
    dg = dg,                          # its derivative                                        
    S = 1,                            # degree 
    minx = 0.0,                       # bottom of support
    maxx = Inf,                       # top of support
    logf = true,                      # whether to provide log density function estimates
    mz::Function = epanechnikov,      # kernel used to provide estimates of f
    anal = true                       # whether to be fussy about checking arguments
    ) where {Tp<:Real}

    

    ( β, Xh, xh, z, zr, S ) = common( X, x, S, h, minx, maxx, anal )
    if S == 1
        derivatives1!( β, Xh, xh, h, z, zr, g, dg )
    else
        derivativesmulti!( β, S, Xh, xh, h, z, zr, g, dg )
    end    

    logf || return ( nothing, β )

    N = length( X )
    num = zeros( Tp, length( xh ) )
    for t ∈ eachindex( xh )
        v = Xh .- xh[t]
        u = v[ -z[t] .≤ v .≤ zr[t] ]
        num[t] = sum( mz( u[i] ) for i ∈ eachindex( u ) ) / ( N * h )
    end

    if mz == epanechnikov && S ≤ 2
        if S == 1
            for t ∈ eachindex( x )
                num[t] /= ( denfunc( zr[t], β[t,1] * h ) - denfunc( -z[t], β[t,1] * h ) )
            end
        else
            for t ∈ eachindex( x )
                num[t] /= ( denfunc( zr[t],  β[t,1] * h, β[t,2] * h^2 * 0.5 ) - denfunc( -z[t], β[t,1] * h, β[t,2] * h^2 * 0.5 ) )
            end
        end
    else
        fac = [ factorial( s ) for s ∈ 1 : S ]
        for t ∈ eachindex( x )
            function numint( xx )
                mz(xx) * exp( sum( β[t,s] * (xx * h)^s / fac[s] for s = 1:S ) )
            end
            denom = try quadgk(numint, -z[t], zr[t], order = 15)[1]
                    catch e  
                        jassert( false. "integration failure in denominator" )
                    end
            num[t] /= denom
        end    
    end
    return ( log.( num ), β )
end


