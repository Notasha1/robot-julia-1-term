function mark_field(r::Robot)
    num_sud = moves!(r, Sud)
    num_ost = moves!(r, Ost)

    side = Nord
    while (!isborder(r, West))
        putmarkers!(r, side)
        if (!isborder(r, West))
            move!(r, West)
        end
        side = inverse(side)
    end

    if (!ismarker(r))
        putmarkers!(r, side)
    end

    moves!(r, Ost)
    moves!(r, Sud)
    moves_back(r, Nord, num_sud)
    moves_back(r, West, num_ost)
    
end

function putmarkers!(r::Robot, side::HorizonSide)
    while (!isborder(r, side))
        putmarker!(r)
        move!(r, side)
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