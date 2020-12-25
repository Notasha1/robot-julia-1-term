function looking_for_frames(r::Robot)
    countSteps = []
    answer = 0

    while (!isborder(r, Sud) || !isborder(r, Ost)) 
        push!(countSteps, moves!(r, Ost))
        push!(countSteps, moves!(r, Sud))
    end

    side = Nord
    while (!isborder(r, West))
        answer += putmarkers!(r, side)
        if (!isborder(r, West))
            move!(r, West)
        end
        side = inverse(side)
    end

    moves!(r, Ost)
    moves!(r, Sud)
    for (i, n) in enumerate(reverse!(countSteps))
        if (i % 2 == 0)
            side = West
        else
            side = Nord
        end
        moves_back(r, side, n)
    end

    return answer
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

function putmarkers!(r::Robot, side::HorizonSide)
    side2 = HorizonSide(mod(Int(side)+1, 4))
    flag = true
    countFrames = 0

    while (flag)
        if (!isborder(r, side))
            move!(r, side)
        else
            if (!isborder(r, Ost))
                move!(r, Ost)
                if (ismarker(r))
                    move!(r, West)
                    making_possible(r, side, side2)
                    if (!isborder(r, side))
                        move!(r, side)
                    end
                else
                    move!(r, West)
                    putmarker!(r)
                    flag = making_possible(r, side, side2)
                    putmarker!(r)
                    if (flag)
                        countFrames += 1
                    end
                end
            else 
                flag = false
            end
        end
    end
    return countFrames
end

function making_possible(r::Robot, side::HorizonSide, side2::HorizonSide)
    steps = moves(r, side, side2)
    if (!isborder(r, side))
        move!(r, side)
        for _ in 1:steps
            move!(r, inverse(side2))
        end
        putmarker!(r)
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