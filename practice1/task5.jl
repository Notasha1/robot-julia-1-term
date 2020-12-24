function mark_corner(r::Robot)
    countSteps = []

    while (!isborder(r, Sud) || !isborder(r, Ost)) 
        push!(countSteps, moves!(r, Ost))
        push!(countSteps, moves!(r, Sud))
    end

    side = Nord
    for _ in 1:4
        putmarker!(r)
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