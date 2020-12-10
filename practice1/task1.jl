function mark_kross(r::Robot)
    for side in (HorizonSide(i) for i = 0:3)
        putmarkers!(r, side)
        move_by_marker(r, inverse(side))
    end
    putmarker!(r)
end

function putmarkers!(r::Robot, side::HorizonSide)
    while (!isborder(r, side))
        move!(r, side)
        putmarker!(r)
    end
end

function move_by_marker(r::Robot, side::HorizonSide)
    while (ismarker(r))
        move!(r, side)
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4)) 