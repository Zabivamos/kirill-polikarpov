using HorizonSideRobots
include("func.jl")
r = Robot("untitled.sit", animate=true)
o = num_steps_along!(r,Ost)
s = num_steps_along!(r, Sud)
function perimetr(r)
    for side in 0:3
        mark_along!(r, HorizonSide(side))
    end
end
perimetr(r)
along!(r, Nord, s)
along!(r, West, o)