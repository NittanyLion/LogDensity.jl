using LogDensity
using Documenter

makedocs(;
    modules=[LogDensity],
    authors="Joris Pinkse <joris@psu.edu> and Karl Schurter",
    sitename="LogDensity.jl",
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo = "github.com/NittanyLion/LogDensity.jl",
    target = "build"
)
