using HorizonSideRobots

HSR = HorizonSideRobots

"""
along!(robot, direct)::Nothing
-- перемещает робота до упора в заданном направлении
"""

function along!(robot,direct)::Nothing
    while !isborder(robot,direct)
        move!(robot,direct)
    end
end

"""
num_steps_along!(robot, direct)::Int
-- перемещает робота в заданном направлении до упора и 
возвращает число фактически сделанных им шагов
"""

function num_steps_along!(robot,direct)::Int
    num_steps = 0
    while !isborder(robot,direct)
        move!(robot, direct)
        num_steps += 1
    end
    return num_steps
end
"""
along!(robot, direct, num_steps)::Nothing
-- перемещает робота в заданном направлении на заданное 
число шагов (предполагается, что это возможно)
"""

function along!(robot,direct,num_steps)::Nothing
    for _ in 1:num_steps
        move!(robot,direct)
    end
end

"""
try_move!(robot, direct)::Bool
-- делает попытку одного шага в заданном направлении и 
27
возвращает true, в случае, если это возможно, и false - в 
противном случае (робот остается в исходном положении) 
"""


 function  try_move!(robot,direct)::Bool
    while isborder(robot,direct)
        return false
    end
    move!(robot,direct)
    return true
end




"""
numsteps_along!(robot, direct, max_num_steps)::Int
-- перемещает робота в заданном направлении до упора, если 
необходимое для этого число шагов не превосходит 
max_num_steps, или на max_num_steps шагов, и возвращает 
число фактически сделанных им шагов
"""
function numsteps_along!(robot, direct, max_num_steps)::Int
    num_steps = 0
    while num_steps<max_num_steps && try_move!(robot,direct) 
        num_steps +=1
    end
    return num_steps
end

using HorizonSideRobots
"""
inverse(side::HorizonSide)::HorizonSide
-- возвращает направление, противоположное заданному 
"""
inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))


"""
right(side::HorizonSide)::HorizonSide
32
-- возвращает направление, следующее по часовой стрелке по 
отношению к заданному
"""
#enum HorizonSide Nord=0, West=1, Sud=2, Ost=3
right(side::HorizonSide)::HorizonSide = 
HorizonSide(mod(Int(side)+1, 4))
"""
left(side::HorizonSide)::HorizonSide
-- возвращает направление, следующее против часовой стрелки 
по отношению к заданному
"""
#enum HorizonSide Nord=0, West=1, Sud=2, Ost=3
left(side::HorizonSide)::HorizonSide = 
HorizonSide(mod(Int(side)-1, 4))
"""
nummarkers!(robot)
-- возвращает число клеток поля, в которых стоят маркеры 
В начале и в конце робот находится в юго-западном углу поля
""" 
function num_markers!(robot)
    side = Ost # - начальное направление при перемещениях "змейкой"
    num_markers = num_markers!(robot, side)
        while !isborder(robot,Nord)
            move!(robot,Nord)
            side = inverse(side)
            num_markers += num_markers!(robot, side)
        end
    #УТВ: робот - где-то у северной границы поля
    along!(robot, Sud) # возвращаемое функцией значение в данном случае игнорируется
    along!(robot, West)
    return num_markers
end


    

"""
numsteps_mark_along!(robot, direct)::Int
-- перемещает робота в заданном направлении до упора, после 
каждого шага ставя маркер, и возвращает число фактически 
сделанных им шагов
"""
function numsteps_mark_along!(robot,direct)::Int
    num_steps = 0
    while !isborder(robot,direct)
        move!(r,direct)
        putmarker!(robot)
        num_steps +=1
    end
    return num_steps
end
""

function goback!(robot::Robot,side::HorizonSide)
    while ismarker(r)
        move!(r,side)
    end
end

"""
mark_along!(robot, direct)
-- перемещает робота в заданном направлении до упора, после 
каждого шага ставя маркер
"""
function mark_along!(robot,direct)
    while !isborder(robot,direct)
        move!(robot,direct)
        putmarker!(robot)
    end
end


HSR.isborder(robot, side::NTuple{2, HorizonSide}) = isborder(robot, side[1]) || isborder(robot, side[2])

HSR.move!(robot, side::NTuple{2, HorizonSide})::Nothing = for s in side move!(robot, s) end

inverse(directions::NTuple{2, HorizonSide}) = inverse.(directions)