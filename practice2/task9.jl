function looking_for_marker(r::Robot)
    step = 1
    side = Nord
    while (!ismarker(r))
        if (!ismarker(r))
            moves(r, side, step)
        end
        side = HorizonSide(mod(Int(side)+1, 4))
        if (!ismarker(r))
            moves(r, side, step)
        end
        side = HorizonSide(mod(Int(side)+1, 4))
        step += 1
        if (!ismarker(r))
            moves(r, side, step)
        end
        side = HorizonSide(mod(Int(side)+1, 4))
        if (!ismarker(r))
            moves(r, side, step)
        end
        side = HorizonSide(mod(Int(side)+1, 4))
        step += 1
    end
end

function moves(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        if (!ismarker(r))
            move!(r, side)
        end
    end
end