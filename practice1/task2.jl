function mark_frame_perimetr(r::Robot)
    num_sud = moves!(r, Sud)
    num_ost = moves!(r, Ost)

    for side in (HorizonSide(i) for i = 0:3)
        putmarkers!(r, side)
    end

    moves!(r, Nord, num_sud)
    moves!(r, West, num_ost)
end

function putmarkers!(r::Robot, side::HorizonSide)
    while (!isborder(r, side))
        move!(r, side)
        putmarker!(r)
    end
end

function moves!(r::Robot, side::HorizonSide)
    num_steps = 0

    while (!isborder(r, side))
        move!(r, side)
        num_steps += 1
    end

    return num_steps
end

function moves!(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move!(r, side)
    end
end