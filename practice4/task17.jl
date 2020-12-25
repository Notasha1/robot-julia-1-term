function mark_field(r::Robot)
    countSteps = []

    while (!isborder(r, Sud) || !isborder(r, Ost)) 
        push!(countSteps, moves!(r, Ost))
        push!(countSteps, moves!(r, Sud))
    end

    side = Nord
    steps = 0
    while (!isborder(r, West))
        putmarkers!(r, side, steps)
        steps += 1
        moving_to_start(r, inverse(side))
        if (!isborder(r, West))
            move!(r, West)
        end
    end

    putmarkers!(r, side, steps)
    putmarker!(r)
    moving_to_start(r, inverse(side))
    
    moves!(r, Ost)
    for (i, n) in enumerate(reverse!(countSteps))
        if (i % 2 == 0)
            side = West
        else
            side = Nord
        end
        moves_back(r, side, n)
    end
    
end

function putmarkers!(r::Robot, side::HorizonSide, steps::Int)
    side2 = HorizonSide(mod(Int(side)+1, 4))
    steps1 = steps
    i = 0

    while (i < steps)
        if (!isborder(r, side))
            putmarker!(r)
            move!(r, side)
            i += 1
        else
            putmarker!(r)
            flag, stepsNord = making_possible(r, side, side2)
            i += stepsNord
        end
    end
    if (i == steps)
        putmarker!(r)
    end
end

function moving_to_start(r::Robot, side::HorizonSide)
    side2 = HorizonSide(mod(Int(side)+1, 4))
    flag = true
    while (flag)
        if (!isborder(r, side))
            move!(r, side)
        else
            flag, a = making_possible(r, side, side2)
        end
    end
end

function making_possible(r::Robot, side::HorizonSide, side2::HorizonSide)
    steps = moves(r, side, side2)
    countSteps = 0
    
    if (!isborder(r, side))
        move!(r, side)
        countSteps += 1
        countSteps += moves(r, inverse(side2), side)
        for _ in 1:steps
            move!(r, inverse(side2))
        end
        return true, countSteps
    else 
        for _ in 1:steps
            move!(r, inverse(side2))
        end
        return false, 0
    end
end

function moves(r::Robot, side::HorizonSide, side2::HorizonSide)
    count = 0
    while (isborder(r, side) && !isborder(r, side2))
        move!(r, side2)
        count += 1
    end

    return count
end

function moves!(r::Robot, side::HorizonSide)
    num_steps = 0

    while (!isborder(r, side))
        move!(r, side)
        num_steps += 1
    end

    return num_steps
end

function moves_back(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r, side)
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4)) 