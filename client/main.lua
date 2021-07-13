local disabledFromClient

mainThread = function()
	while disabledFromClient do
            InvalidateIdleCam()
            InvalidateVehicleIdleCam()
	    Wait(5000)
	end
end

Citizen.CreateThread(function() 
    disabledFromClient = DisabledByDefault
    mainThread()
end)

RegisterCommand("idlecam", function() 
    disabledFromClient = not disabledFromClient

    local textForNotification
    if disabledFromClient then 
        textForNotification = "~r~"..Lang["Disabled"].."~w~"
    else 
        textForNotification = "~g~"..Lang["Enabled"].."~w~"
    end

    NotificationText(Lang["IdleCam"]..": "..textForNotification)
    mainThread()
end)

function NotificationText(text)
    SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName(text)
	DrawNotification(false, true)
end
