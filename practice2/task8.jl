function looking_for_exit(r::Robot)
    step = 1
    side = Ost
    while (isborder(r, Nord))
        if (isborder(r, Nord))
            moves(r, side, step)
        end
        step += 1
        if (isborder(r, Nord))
            moves(r, inverse(side), step)
        end
        step += 1
    end
end

function moves(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        if (isborder(r, Nord))
            move!(r, side)
        end
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4)) 