using HorizonSideRobots
include("func.jl")
r=Robot("untitled.sit",animate=true)
o = num_steps_along!(r,Ost)
s = num_steps_along!(r, Sud)
function all(r,side)
    while !isborder(r,Nord)
        putmarker!(r)
        mark_along!(r,side)
        move!(r,Nord)
        side=inverse(side)
    end
    putmarker!(r)
    mark_along!(r,side)
    putmarker!(r)
end
all(r,West)
num_steps_along!(r,Ost)
num_steps_along!(r, Sud)
along!(r,Nord,s)
along!(r,West,o)
    