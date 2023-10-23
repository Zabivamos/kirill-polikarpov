using HorizonSideRobots
include("func.jl")
r=Robot("untitled.sit", animate=true)
function goback!(robot::Robot,side::HorizonSide)
    while ismarker(r)
        move!(r,side)
    end
end
function numsteps_mark_along!(r,direct)::Int
    num_steps = 0
    while !isborder(r,direct)
        move!(r,direct)
        putmarker!(r)
        num_steps +=1
    end
    return num_steps
end
function mark_kross!(r)
    for side in (Nord,West,Sud,Ost)
        num_steps = numsteps_mark_along!(r,side)
        goback!(r,inverse(side))
    end
    putmarker!(r)
end
mark_kross!(r)



