# GradProjRosen

## GPA1.jl
This file contains the implementation of the Projected Gradient Method equipped with Armijo's linesearch along feasible directions.

### Function GPA1 - Monotone Armijo linesearch along feasible directions

#### Arguments

- **$\boldsymbol{x}$ (Vector):** Point where the linear search will applied
- **$f$ (Function):** The objective function
- **$\nabla f$ (Function):** The gradient of the objective function
- **$\sigma$ (FLoat64):** The parameter of Armijo linesearch
- **min_step (FLoat64):** The minimum stepsize parameter acceptable
- **$\gamma$ _start (FLoat64):** Initial stepsize
- **$zk$ (Vector):** $P_C(x_k - \beta_k\nabla f(x_k))$

#### Outputs

- **$\boldsymbol{\gamma}$ (Float64):** The stepsize parameter in iterarion k
- **ierror (Int64):** The error of linesearch (0 - no error, 1 - step length too small)
- **evalf (Int64):** Number of function evaluations in the current iteration

### Function method1 - Gradient Projected Method with monotone Armijo linesearch along feasible directions

#### Arguments

- **$\boldsymbol{x}$ (Vector):** Initial point
- **$f$ (Function):** The objective function
- **$\nabla f$ (Function):** The gradient of the objective function
- **$\varepsilon$ (FLoat64):** The convergence tolerance parameter
- **max_iter (Int64):** Maximum number of iterations allowed 
- **PG1 (Function):** The linesearch function
- **projection (Function):** The projection function

#### Outputs

- **$\boldsymbol{x}$ (Vector):** Minimizer point
- **$\boldsymbol{f(x)}$ (Float64):** Objective function evaluated in the minimizer
- **info (DataFrame):** Data frame with information about the minimization process
- **et (Float64):** Time spent solving the problem
- **ierror (Int64):** Error returned (0 - no error, 1 - step length too small, 2 - Maximum of iterations was achieved)
- **seqx (Matrix{Vector{Float64}}):** Matrix with the terms of the sequence $\{x_k\}$
- **sum(evalf_\gamma) (Int64):** Total number of function evaluations

## GPA2.jl
This file contains the implementation of the Projected Gradient Method equipped with Armijo linesearch along the projection arc.

### Function GPA2 - Armijo linesearch along the projection arc

#### Arguments

- **$\boldsymbol{x}$ (Vector):** Point where the linear search will be carried out
- **$f$ (Function):** The objective function
- **$\nabla f$ (Function):** The gradient of the objective function
- **$\sigma$ (FLoat64):** The parameter of Armijo linesearch
- **min_step (FLoat64):** The minimum stepsize parameter acceptable
- **$\beta$ _start (FLoat64):** Initial stepsize

#### Outputs

- **$\boldsymbol{\beta}$ (Float64):** The stepsize parameter in iterarion k
- **zkj (Vector):** $P_C(x_k - \beta_k\nabla f(x_k))$
- **ierror (Int64):** The error of linesearch (0 - no error, 1 - step length too small)
- **evalf (Int64):** Number of function evaluations

### Function method4 - Gradient Projected Method with Armijo linesearch along the projection arc

#### Arguments

- **$\boldsymbol{x}$ (Vector):** Initial point
- **$f$ (Function):** The objective function
- **$\nabla f$ (Function):** The gradient of the objective function
- **$\varepsilon$ (FLoat64):** The convergence tolerance parameter
- **max_iter (Int64):** Maximum number of iterations allowed 
- **GPA2 (Function):** The linesearch function
- **projection (Function):** The projection function

#### Outputs

- **$\boldsymbol{x}$ (Vector):** Minimizer point
- **$\boldsymbol{f(x)}$ (Float64):** Objective function evaluated in the minimizer
- **info (DataFrame):** Data frame with information about the minimization process
- **et (Float64):** Time spent solving the problem
- **ierror (Int64):** Error returned (0 - no error, 1 - step length too small, 2 - Maximum of iterations was achieved)
- **seqx )Matrix{Vector{Float64}}):** Matrix with the terms of the sequence $\{x_k\}$
- **sum(evalf_\gamma) (Int64):** Total number of function evaluations

### Function – Spectral Projected Gradient Method (SPG.jl)

#### Arguments

- **$\boldsymbol{x_0}$ (Vector):** The starting point where the method will be initiated.
- **$f$ (Function):** The objective function to be minimized.
- **$\nabla f$ (Function):** The gradient of the objective function.
- **$proj$ (Function):** The projection function that ensures the feasibility of the solutions.
- **$\varepsilon$ (Float64):** Convergence tolerance. The algorithm stops when the norm of the gradient is smaller than this value.
- **max_iter (Int64):** Maximum allowed number of iterations.
- **$\lambda_{\text{min}}$ (Float64):** Lower bound for the $\lambda$ parameter.
- **$\lambda_{\text{max}}$ (Float64):** Upper bound for the $\lambda$ parameter.
- **$M$ (Int64):** The number of iterations used to compute the maximum function value from the last iterations.
- **$\sigma_1, \sigma_2$ (Float64):** Parameters that control step size adaptation.
- **$\eta$ (Float64):** Parameter controlling the Armijo condition (used in line search).
- **linesearch (Function):** The function responsible for performing the line search, updating the point $\boldsymbol{x}$ and recalculating the gradient.

#### Outputs

- **$\boldsymbol{x}$ (Vector):** The point that minimizes the objective function after the iterations.
- **$\boldsymbol{f(x)}$ (Float64):** The objective function value at the minimizer.
- **info (DataFrame):** A DataFrame containing information about the minimization process (e.g., gradient norms, function values in each iteration).
- **et (Float64):** Total time spent running the algorithm.
- **error (Int64):** Error indicator (0 - Convergence, 1 - Maximum iterations reached).
- **seqx (Matrix{Vector{Float64}}):** Matrix containing the terms of the sequence $\{x_k\}$ generated during the iterations.
- **evalf_k (Int64):** Total number of function evaluations.
- **evalproj_k (Int64):** Total number of projection evaluations.

### spg1 Function – Backtracking Routine for SPG

#### Arguments

- **$k$ (Int64):** The index of the current iteration.
- **$\lambda_k$ (Float64):** The regularization parameter in iteration $k$.
- **$\boldsymbol{x_k}$ (Vector):** Current point at iteration $k$.
- **$\nabla f(\boldsymbol{x_k})$ (Vector):** Gradient of the objective function at $\boldsymbol{x_k}$.
- **$f_{\text{hist}}$ (Array{Float64}):** History of objective function evaluations.
- **$M$ (Int64):** The number of iterations used to compute the maximum function value.
- **$\sigma_1, \sigma_2$ (Float64):** Parameters controlling step size adaptation.
- **$\eta$ (Float64):** Parameter for the Armijo condition.
- **$proj$ (Function):** The projection function.

#### Outputs

- **$\boldsymbol{x_{k+1}}$ (Vector):** The new point after iteration.
- **$\nabla f(\boldsymbol{x_{k+1}})$ (Vector):** New gradient of the objective function.
- **$s_k$ (Vector):** The descent direction at iteration $k$.
- **$y_k$ (Vector):** The difference in gradients between iterations $k$ and $k+1$.
- **$f_{\text{hist}}$ (Array{Float64}):** History of function evaluations.
- **$\alpha$ (Float64):** The computed step size.
- **et (Float64):** Time spent in this iteration.
- **evalf (Int64):** Number of function evaluations during this iteration.
- **evalproj (Int64):** Number of projection evaluations.

### spg2 Function – Backtracking Routine for SPG

#### Arguments

- **$k$ (Int64):** The index of the iteration.
- **$\lambda_k$ (Float64):** The regularization parameter.
- **$\boldsymbol{x_k}$ (Vector):** The current point.
- **$\nabla f(\boldsymbol{x_k})$ (Vector):** The gradient of the objective function.
- **$f_{\text{hist}}$ (Array{Float64}):** History of function evaluations.
- **$M$ (Int64):** The number of iterations to compute the maximum value.
- **$\sigma_1, \sigma_2$ (Float64):** Step size control parameters.
- **$\eta$ (Float64):** Armijo condition control parameter.
- **$proj$ (Function):** The projection function.

#### Outputs

- **$\boldsymbol{x_{k+1}}$ (Vector):** The new point after iteration.
- **$\nabla f(\boldsymbol{x_{k+1}})$ (Vector):** New gradient of the objective function.
- **$s_k$ (Vector):** The descent direction.
- **$y_k$ (Vector):** The difference in gradients.
- **$f_{\text{hist}}$ (Array{Float64}):** History of function evaluations.
- **$\alpha$ (Float64):** The computed step size.
- **et (Float64):** Total time spent.
- **evalf (Int64):** Number of function evaluations.
- **evalproj (Int64):** Number of projection evaluations.

## projections.jl
This file contains projection functions for 6 different feasible sets, whose parameters can be easily modified.

### Examples of projection functions for diferent feasible sets
- **projection1:** $\Omega_1 =$$`\left\{x \in \mathbb{R}^n; |x-c| \le 10 \right\}`$, onde $c = (1,1,\ldots,1)$.
- **projection2:** $\Omega_2 =$$`\left\{x \in \mathbb{R}^n; x_j \in (-\infty,5], \ j=1,2,\ldots,n \right\}`$.
- **projection3:** $\Omega_3 =$$`\left\{x \in \mathbb{R}^n; x_j \in [-5,10], \ j=1,2,\ldots,n \right\}`$.
- **projection4:** $\Omega_4 =$$`\left\{x \in \mathbb{R}^n ; \langle a, x \rangle = 10\right\}`$, onde $a = (1,1,\ldots,1)$.
- **projection5:** $\Omega_5 =$$`\left\{x \in \mathbb{R}^n ; \langle a, x \rangle \le 10\right\}`$, onde $a = (10,10,\cdots,10)$.
- **projection6:** $\Omega_6 =$$`\left\{x \in \mathbb{R}^n ; Ax = (1,1,1)\right\}`$, onde $A \in \mathbb{R}(3,n)$ tem posto $3$.
