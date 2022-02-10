# LogDensity

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://NittanyLion.github.io/LogDensity/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://NittanyLion.github.io/LogDensity/dev)
[![Build Status](https://github.com/NittanyLion/LogDensity/workflows/CI/badge.svg)](https://github.com/NittanyLion/LogDensity/actions)

This package computes estimates of the log density function and its derivatives using the algorithm proposed in Pinkse and Schurter (Econometric Theory, 2022).

One of several advantages of estimating the logarithm of a density is that it is guaranteed to produce positive density estimates.

The code is reasonably fast and single-threaded, so it can be used inside an @threads for loop without additional overhead.

To use this package, just add LogDensity using the package manager (e.g. typing the ] character in the REPL and then typing *add LogDensity*). 

The package provides two functions: logdensity and logdensityderivatives. In the REPL type ? followed by (e.g.) logdensity to see the documentation of the command.
