## Comparing multiple vectors (intersect, setdiff, union)

vec1 <- c(1, 2, 3)
vec2 <- c(3, 5, 6)
vec3 <- c(4, 2, 3)

## Intersection :
intersect(vec1, vec2)
## Difference :
setdiff(vec1, vec2)
## Union :
union(vec1, vec2)

## Multiple vectors
Reduce(intersect, list(vec1, vec2, vec3))
Reduce(union, list(vec1, vec2, vec3))