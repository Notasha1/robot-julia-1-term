function average_temperature(r::Robot)
    countMarkers = 0
    sumTemperature = 0

    countMarkers, sumTemperature = looking_for_markers(r)

    return sumTemperature / countMarkers
end

function looking_for_markers(r::Robot)
    sum = 0
    count = 0
    side = Nord

    while (!isborder(r, Ost))
        countNow, sumNow = moving(r, side)
        sum += sumNow
        count += countNow

        if (!isborder(r, Ost))
            move!(r, Ost)
        end

        side = inverse(side)
    end

    countNow, sumNow = moving(r, side)
    sum += sumNow
    count += countNow

    return count, sum
end

function moving(r::Robot, side::HorizonSide)
    count = 0
    sum = 0

    while (!isborder(r, side))
        if (ismarker(r))
            count += 1
            sum += temperature(r)
        end
        move!(r, side)
    end

    if (ismarker(r))
        count += 1
        sum += temperature(r)
    end

    return count, sum
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4)) 