function mark_kross(r::Robot)
    for side in (HorizonSide(i) for i = 0:3)
        putmarkers!(r, side)
        move_by_marker(r, inverse(side))
    end
    putmarker!(r)
end

function putmarkers!(r::Robot, side::HorizonSide)
    side2 = HorizonSide(mod(Int(side)+1, 4))
    flag = true
    while (flag)
        if (!isborder(r, side))
            move!(r, side)
            putmarker!(r)
        else
            flag = making_possible(r, side, side2)
            if (flag)
                putmarker!(r)
            end
        end
    end
end

function move_by_marker(r::Robot, side::HorizonSide)
    side2 = HorizonSide(mod(Int(side)+3, 4))
    while (ismarker(r))
        if (!isborder(r, side))
            move!(r, side)
        else
            making_possible(r, side, side2)
        end
    end
end

function making_possible(r::Robot, side::HorizonSide, side2::HorizonSide)
    steps = moves(r, side, side2)
    if (!isborder(r, side))
        move!(r, side)
        moves(r, inverse(side2), side)
        for _ in 1:steps
            move!(r, inverse(side2))
        end
        return true
    else 
        for _ in 1:steps
            move!(r, inverse(side2))
        end
        return false
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

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4)) 