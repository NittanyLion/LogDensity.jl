using LogDensity
using Test

@testset "LogDensity.jl" begin
    r = [ parse(Float64, fl) for fl in readlines("boundestdata.csv") ]
    ( logf, β ) = logdensity(r, collect(0.0:0.1:0.2), 0.5; anal=false )
    @test β ≈ [ -0.409345755364715,-0.321324897846474,-0.401367070582909 ]
    @test logf ≈ [ -0.739190491046256,-0.78965235304968,-0.818590378954698 ]
    β2 = logdensityderivatives(r, collect(0.0:0.1:0.2), 0.5; anal=false )
    @test β ≈ β2

    ( logf, β ) = logdensity(r, collect(0.0:0.1:0.2), 0.5; S=2, anal=false )
    @test β ≈ [0.19052091185219694 -2.434548533489367; -0.3401926625357224 0.09748925928955005; -0.2893470695141677 -0.7973089783812821]
    @test logf ≈ [-0.7904810573794027, -0.7890805128340765, -0.8132211046368243]
    β2 = logdensityderivatives(r, collect(0.0:0.1:0.2), 0.5; S=2, anal=false )
    @test β ≈ β2

    ( logf, β ) = logdensity(r, collect(0.0:0.1:0.2), 0.5; S=3, mz=quartic,anal=false )
    @test β ≈ [-1.572088272730215 15.39013993699334 -71.87012956581209; -0.18776905560267698 -2.786004255503017 14.675398492375955; -0.28141402629073176 -0.10470410790118856 -4.789506265957136]
    @test logf ≈ [-0.7185403492935303, -0.7818410094136379, -0.8190838536404783]
    β2 = logdensityderivatives(r, collect(0.0:0.1:0.2), 0.5; S=3, mz=quartic, anal=false )
    @test β ≈ β2

end
