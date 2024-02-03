local balloon
local lockZ = false

local T = Translation.Langs[Config.Lang]

local balloonPrompts = UipromptGroup:new("Balloon")

local nsPrompt = Uiprompt:new({ `INPUT_VEH_MOVE_UP_ONLY`, `INPUT_VEH_MOVE_DOWN_ONLY` }, T.Prompts.NorthSouth, balloonPrompts)
local wePrompt = Uiprompt:new({ `INPUT_VEH_MOVE_LEFT_ONLY`, `INPUT_VEH_MOVE_RIGHT_ONLY` }, T.Prompts.WestEast, balloonPrompts)

local brakePrompt = Uiprompt:new(`INPUT_VEH_BRAKE`, T.Prompts.DownBalloon, balloonPrompts)
local lockZPrompt = Uiprompt:new(`INPUT_VEH_SHUFFLE`, T.Prompts.LockInAltitude, balloonPrompts)
local throttlePrompt = Uiprompt:new(`INPUT_VEH_FLY_THROTTLE_UP`, T.Prompts.UpBalloon, balloonPrompts)
local deleteBalloonPrompt = Uiprompt:new(`INPUT_VEH_HORN`, T.Prompts.RemoveBalloon, balloonPrompts)

Citizen.CreateThread(function()
	while true do
		local vehicle = GetVehiclePedIsUsing(PlayerPedId())
		local isBalloon = GetEntityModel(vehicle) == `hotairballoon01`

		if not balloon and isBalloon then
			balloon = vehicle
		elseif balloon and not isBalloon then
			balloon = nil
		end

		Citizen.Wait(500)
	end
end)

Citizen.CreateThread(function()
	local bv

	while true do
		if balloon then
			balloonPrompts:handleEvents()

			local speed

			if IsControlPressed(0, `INPUT_VEH_TRAVERSAL`) then
				speed = 0.15
			else
				speed = 0.05
			end

			local v1 = GetEntityVelocity(balloon)
			local v2 = v1

			if IsControlPressed(0, `INPUT_VEH_MOVE_UP_ONLY`) then
				v2 = v2 + vector3(0, speed, 0)
			end

			if IsControlPressed(0, `INPUT_VEH_MOVE_DOWN_ONLY`) then
				v2 = v2 - vector3(0, speed, 0)
			end

			if IsControlPressed(0, `INPUT_VEH_MOVE_LEFT_ONLY`) then
				v2 = v2 - vector3(speed, 0, 0)
			end

			if IsControlPressed(0, `INPUT_VEH_MOVE_RIGHT_ONLY`) then
				v2 = v2 + vector3(speed, 0, 0)
			end

			if IsControlPressed(0, `INPUT_VEH_BRAKE`) then
				if bv then
					local x = bv.x > 0 and bv.x - speed or bv.x + speed
					local y = bv.y > 0 and bv.y - speed or bv.y + speed
					v2 = vector3(x, y, v2.z)
				end
				bv = v2.xy
			else
				if bv then
					bv = nil
				end
			end

			if IsControlJustPressed(0, `INPUT_VEH_SHUFFLE`) then
				lockZ = not lockZ

				if lockZ then
					lockZPrompt:setText(T.Prompts.UnlockInAltitude)
				else
					lockZPrompt:setText(T.Prompts.LockInAltitude)
				end
			end

			if lockZ and not IsControlPressed(0, `INPUT_VEH_FLY_THROTTLE_UP`) then
				SetEntityVelocity(balloon, vector3(v2.x, v2.y, 0.0))
			elseif v2 ~= v1 then
				SetEntityVelocity(balloon, v2)
			end

			if IsControlJustPressed(0, `INPUT_VEH_HORN`) then
				if DoesEntityExist(balloon) then
					DeleteEntity(balloon)
					balloon = nil
				end
			end

			Citizen.Wait(0)
		else
			Citizen.Wait(500)
		end
	end
end)
