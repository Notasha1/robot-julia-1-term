stepsOst = 0
stepsSud = 0
wallNord = 0
wallWest = 0

function mark_sides(r::Robot)
    countSteps = []
    global stepsOst, stepsSud

    while (!isborder(r, Sud) || !isborder(r, Ost)) 
        a = moves_to_start(r, Ost)
        b = moves_to_start(r, Sud)
        stepsOst += a
        stepsSud += b
        push!(countSteps, a)
        push!(countSteps, b)
    end

    side = Nord
    for _ in 1:4
        moves!(r, side)
        side = HorizonSide(mod(Int(side)+1, 4))
    end

    for (i, n) in enumerate(reverse!(countSteps))
        if (i % 2 == 0)
            side = West
        else
            side = Nord
        end
        moves_back(r, side, n)
    end
end

function moves!(r::Robot, side::HorizonSide)
    num_steps = 0
    global wallNord, wallWest

    while (!isborder(r, side))
        if (side == Nord)
            wallNord += 1
        end
        if (side == West)
            wallWest += 1
        end
        if (side == Nord && num_steps == stepsSud)
            putmarker!(r)
        elseif (side == West && num_steps == stepsOst)
            putmarker!(r)
        elseif (side == Ost && num_steps == (wallWest - stepsOst))
            putmarker!(r)
        elseif (side == Sud && num_steps == (wallNord - stepsSud))
            putmarker!(r)
        end
        move!(r, side)
        num_steps += 1
    end

    return num_steps
end

function moves_to_start(r::Robot, side::HorizonSide)
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