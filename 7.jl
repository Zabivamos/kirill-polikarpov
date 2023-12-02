using HorizonSideRobots
include("func.jl")
r=Robot("untitled.sit",animate=true)
function snake(r)
    n=1
    side=West
    while isborder(r,Nord)
        along!(r,side,n)::Nothing
        n+=1
        side=inverse(side)
    end
end
snake(r)