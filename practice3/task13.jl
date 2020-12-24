function mark_kross(r::Robot)
    for side in (HorizonSide(i) for i = 0:3)
        putmarkers!(r, side)
        move_by_marker(r, inverse(side))
    end
    putmarker!(r)
end

function putmarkers!(r::Robot, side::HorizonSide)
    side2 = HorizonSide(mod(Int(side)+1, 4))
    while (!isborder(r, side) && !isborder(r, side2))
        move!(r, side)
        move!(r, side2)
        putmarker!(r)
    end
end

function move_by_marker(r::Robot, side::HorizonSide)
    while (ismarker(r))
        move!(r, HorizonSide(mod(Int(side)+1, 4)))
        move!(r, side)
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4)) 