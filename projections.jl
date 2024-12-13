#
# Feasible sets and projections
#

## Set 01

function proj1(x)
    n = length(x)
    c = fill(1, n) 
    δ = 10
    cx = norm(c-x)
    if cx <= δ
        return x
    else
        return c - (δ*(c-x)/cx)
    end
end

## Set 02

function proj2(x)
    n = length(x)
    c = fill(10, n) 
    δ = 15
    cx = norm(c-x)
    if cx <= δ
        return x
    else
        return c - (δ*(c-x)/cx)
    end
end

## Set 03

function proj3(x)
    return min.(5, x)
end

## Set 04

function proj4(x)
    return min.(0.5, x)
end

## Set 05

function proj5(x)
    n = length(x)
    a = fill(-5, n)
    b = fill(10, n)
    for j in 1:n   
        if x[j] < a[j]
           x[j] = a[j]
        elseif a[j] <= x[j] <= b[j]
           x[j] = x[j]
        elseif x[j] > b[j]
           x[j] = b[j] 
        end
    end
    return x
end

## Set 06

function proj6(x)
    n = length(x)
    a = fill(2, n)
    b = fill(10, n)
    for j in 1:n   
        if x[j] < a[j]
           x[j] = a[j]
        elseif a[j] <= x[j] <= b[j]
           x[j] = x[j]
        elseif x[j] > b[j]
           x[j] = b[j] 
        end
    end
    return x
end

## Set 07

function proj7(x)
    n = length(x)
    a = fill(1, n)
    b = n
    return x + ((b - dot(a, x))/norm(a)^2)*a
end

## Set 08

function proj8(x)
    n = length(x)
    a = fill(10, n)
    b = 10
    return x + ((b - dot(a, x))/norm(a)^2)*a
end

## Set 09

function proj9(x)
    n = length(x)
    a = fill(1, n)
    b = 100
    return x + ((min(0, b - dot(a, x)))/norm(a)^2)*a
end

## Set 10

function proj10(x)
    n = length(x)
    a = fill(10, n)
    b = 1
    return x + ((min(0, b - dot(a, x)))/norm(a)^2)*a
end

## Set 11

function matrix1(rank, n)
    rng = MersenneTwister(3214)
    matrix_0 = rand(rng, rank, n)  
    U, Σ, V = svd(matrix_0)
    Σ[rank + 1:end] .= 0      
    A = U[:, 1:rank] * Diagonal(Σ[1:rank]) * V[:, 1:rank]'
    b = A * fill(1, n) 
    return (A, b)
end

function proj11(x)
    return x - A' * inv(A * A') * (A * x - b)
end

## Set 12

function matrix2(rank, n)
    rng = MersenneTwister(3214)
    matrix_0 = rand(rng, rank, n)  
    U, Σ, V = svd(matrix_0)
    Σ[rank + 1:end] .= 0      
    A = U[:, 1:rank] * Diagonal(Σ[1:rank]) * V[:, 1:rank]'
    b = fill(1, size(A, 1)) 
    return (A, b)
end

function proj12(x)
    return x - A' * inv(A * A') * (A * x - b)
end

