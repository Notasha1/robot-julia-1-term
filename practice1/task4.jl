function mark_field(r::Robot)
    num_sud = moves!(r, Sud)
    num_ost = moves!(r, Ost)

    side = Nord
    steps = 0
    while (!isborder(r, West))
        putmarkers!(r, side, steps)
        move!(r, West)
        steps += 1
        while (!isborder(r, Sud))
            move!(r, Sud)
        end
    end

    steps += 1
    putmarkers!(r, side, steps)
    while (!isborder(r, Sud))
        move!(r, Sud)
    end
    
    moves!(r, Ost)
    moves_back(r, Nord, num_sud)
    moves_back(r, West, num_ost)
    
end

function putmarkers!(r::Robot, side::HorizonSide, steps::Int)
    for _ in 1:steps
        if (!isborder(r, Nord))
            putmarker!(r)
            move!(r, side)
        end
    end
    putmarker!(r)
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