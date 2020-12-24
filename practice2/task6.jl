function mark_frame(r::Robot)
    num_sud1 = moves!(r, Sud)
    num_ost = moves!(r, Ost)
    num_sud2 = moves!(r, Sud)

    side = Nord
    while (!isborder(r, West))
        move_line(r, side)
        if (!isborder(r, West))
            move!(r, West)
        end
        move_line(r, inverse(side))
        if (!isborder(r, West))
            move!(r, West)
        end
    end

    move!(r, Nord)
    if (isborder(r, West))
        side = Nord
        for _ in 1:4
            putmarkers!(r, side, 1)
            side = HorizonSide(mod(Int(side)+1, 4))
            move!(r, side)
        end
    else
        move!(r, Sud)
        side = Sud
        for _ in 1:4
            putmarkers!(r, side, 3)
            side = HorizonSide(mod(Int(side)+3, 4))
            move!(r, side)
        end
    end

    moves!(r, Ost)
    moves!(r, Sud)
    moves_back(r, Nord, num_sud1)
    moves_back(r, West, num_ost)
    moves_back(r, Nord, num_sud2)
    
end

function move_line(r::Robot, side::HorizonSide) 
    while (!isborder(r, side) && !isborder(r, West))
        move!(r, side)
    end
end

function putmarkers!(r::Robot, side::HorizonSide, a::Int)
    while (isborder(r, HorizonSide(mod(Int(side)+a, 4))))
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