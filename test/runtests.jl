using LogDensity
using Test

@testset "LogDensity.jl" begin
    r = [ parse(Float64, fl) for fl in readlines("boundestdata.csv") ]
    ( logf, β ) = logdensity(r, collect(0.0:0.1:0.2), 0.5; anal=false )
    @test β ≈ [ -0.409345755364715,-0.321324897846474,-0.401367070582909 ]
    @test logf ≈ [ -0.739190491046256,-0.78965235304968,-0.818590378954698 ]
    β2 = logdensityderivatives(r, collect(0.0:0.1:0.2), 0.5; anal=false )
    @test β ≈ β2
end
