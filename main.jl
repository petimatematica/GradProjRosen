## Main Code ##

include("projections.jl")
include("PG1.jl")
include("PG2.jl")
include("SPG.jl")

using LinearAlgebra, DataFrames, Random

# Problem - Rosenbrock Function 

function f(x::Vector)
   n = length(x)
   f = 0.0
   for i in 1:(n-1)
       f += 100.0 * (x[i+1] - x[i]^2)^2 + (1.0 - x[i])^2
   end
   return f
end

function ∇f(x::Vector{Float64})
   n = length(x)
   g = zeros(Float64, n)
   for i in 1:n
       if i == 1
           g[i] = -400.0 * x[i] * (x[i+1] - x[i]^2) + 2.0 * (x[i] - 1.0)
       elseif i == n
           g[i] = 200.0 * (x[i] - x[i-1]^2)
       else
           g[i] = 200.0 * (x[i] - x[i-1]^2) - 400.0 * x[i] * (x[i+1] - x[i]^2) + 2.0 * (x[i] - 1.0)
       end
   end
   return g
end

## Parameters 

η = 1.e-4                                   # Linesearch parameter
ε = 1.e-5                                   # Convergence tolerance parameter
β_start = 1.0                               # Initial step length parameter
β1 = 0.1                                    # Lower limit of the range of step length parameters calculated by quadratic interpolation
β2 = 0.9                                    # Upper limit of the range of step length parameters calculated by quadratic interpolation
γ_start = 1.0                               # Initial step length parameter for PG2
min_step = 1.e-5                            # Tolerance for minimum step length in the PG1 and PG2
max_iter = 50000                            # Maximum number of iterations allowed
lambda_min = 1.e-30                         # Safeguard parameters for SPG1 and SPG2
lambda_max = 1.e+30                         # Safeguard parameters for SPG1 and SPG2
M = 10                                      # Non-monotonicity parameter for SPG1 and SPG2
sigma1 = 0.1                                # Parameters for interval in step length calculation on SPG1 and SPG2
sigma2 = 0.9                                # Parameters for interval in step length calculation on SPG1 and SPG2
guess = MersenneTwister(12345)              # Seed to define initial guess
dimension = 50                               # Dimension
x_rand = 20 * rand(guess, dimension) .-10   # Define the guess in interval [-10, 10] in each variable
method = "SPG2"                             # Select the optimization method (Options: SPG1, SPG2, PG1 and PG2)
proj = proj6                                # Select the projection operator (Options: projection1, projection2, projection3, projection4, projection5 and projection6)

if proj == proj11 
    (A, b) = matrix1(3, n) 
elseif proj == proj12
    (A, b) = matrix2(3, n)
end

x0 = proj(x_rand)                           # Projects the initial guess into the set

if method == "SPG1"
    (xbest, info, et, ierror, seqx, evalsf, evalsproj) = spg(x0, f, ∇f, proj, ε, max_iter, lambda_min, lambda_max, M, sigma1, sigma2, η, spg1)
elseif method == "SPG2"                 
    (xbest, info, et, ierror, seqx, evalsf, evalsproj) = spg(x0, f, ∇f, proj, ε, max_iter, lambda_min, lambda_max, M, sigma1, sigma2, η, spg2)
elseif method == "PG1"
    (xbest, info, et, ierror, seqx, evalsf, evalsproj) = method1(x0, f, ∇f, ε, max_iter, PG1, proj)
elseif method == "PG2"
    (xbest, info, et, ierror, seqx, evalsf, evalsproj) = method2(x0, f, ∇f, ε, max_iter, PG2, proj)
end

# Show the result #

ENV["LINES"] = 10000
println(info)
println("Minimum value of f: ", f(xbest))
println("Minimizador = ", xbest)
println("Total time spent: ", et)
println("Function evaluations = ", evalsf)
println("Ierror = ", ierror)