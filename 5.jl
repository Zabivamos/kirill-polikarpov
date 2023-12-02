using HorizonSideRobots
include("func.jl")
r=Robot("untitled.sit",animate=true)
function snake!(r)
    direct = Ost
    while !isborder(r, Nord)
        while !isborder(r, direct)
            move!(r,direct)
            if isborder(r,Nord)
                break
            end
        end
        if !isborder(r, Nord)
            move!(r, Nord)
        end
        direct = inverse(direct)
    end
end
function num_steps_along!(robot,direct)::Int
    num_steps = 0
    while !isborder(robot,direct)
        move!(r,direct)
        num_steps +=1
    end
    return num_steps
end
function per(r)
    mark_along!(r,Ost)
    mark_along!(r,Nord)
    mark_along!(r,West)
    mark_along!(r,Sud)
end
function kras(r,direct,direct2)
    for x in 1:2
        if isborder(r,direct)
            putmarker!(r)
            while isborder(r,direct)
                move!(r,direct2)
                putmarker!(r)
            end
        end 
        move!(r,direct)
        putmarker!(r)
        while isborder(r,inverse(direct2))
            move!(r,direct)
            putmarker!(r)
        end
        direct2=inverse(direct2)
        move!(r,direct2)
        putmarker!(r)
        direct=inverse(direct)
    end
end
b=num_steps_along!(r,West)
d=num_steps_along!(r,Sud)
num_steps_along!(r,West)
# num_steps_along!(r,Sud)
per(r)
snake!(r)
kras(r,Nord,Ost)
along!(r,West)
along!(r,Sud)
# b=num_steps_along!(r,West)
# d=num_steps_along!(r,Sud)
along!(r,Nord,d)
along!(r,Ost,b)

