using LogDensity
using Documenter

DocMeta.setdocmeta!(LogDensity, :DocTestSetup, :(using LogDensity); recursive=true)

makedocs(;
    modules=[LogDensity],
    authors="Joris Pinkse <joris@psu.edu> and Karl Schurter",
    repo="https://github.com/NittanyLion/LogDensity.jl/blob/{commit}{path}#{line}",
    sitename="LogDensity.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://NittanyLion.github.io/LogDensity.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo = "github.com/NittanyLion/LogDensity.jl.git",
    target = "build"
    # devbranch="main",
)
