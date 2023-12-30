-- Lua script for qs-vehiclekeysapp

function doorToggle(door)
    if GetVehicleDoorAngleRatio(cache.vehicle, door) > 0.0 then
        SetVehicleDoorShut(cache.vehicle, door, false, false)
    else
        SetVehicleDoorOpen(cache.vehicle, door, false, false)
    end
end

function changeSeat(seat)
    if (IsVehicleSeatFree(cache.vehicle, seat)) then
        SetPedIntoVehicle(cache.ped, cache.vehicle, seat)
    end
end

local windows = { true, true, true, true }

function windowToggle(window, door)
    if GetIsDoorValid(cache.vehicle, door) and windows[window + 1] then
        RollDownWindow(cache.vehicle, window)
        windows[window + 1] = false
    else
        RollUpWindow(cache.vehicle, window)
        windows[window + 1] = true
    end
end

RegisterNUICallback('doorToggle', function(data, cb)
    local doorType = data.door
    doorToggle(doorType)
    cb('Callback received successfully!')
end)

RegisterNUICallback('windowToggle', function(data, cb)
    local windowType = data.window
    local doorType = data.door
    windowToggle(windowType, doorType)
    cb('Callback received successfully!')
end)

RegisterNUICallback('changeSeat', function(data, cb)
    local seatType = data.seat
    changeSeat(seatType)
    cb('Callback received successfully!')
end)
