function data()

return {
	updateFn = function(captureParams, params)
        -- side
        local isLeft = params.side == 1
        local sideSuffix = isLeft and "left" or "right"
        local sideDistance = 2.1
        local sideOffset = isLeft and sideDistance or -sideDistance

        -- base
        local offset = params.offset * -1
        local mainBase = "hv_base_" .. sideSuffix .. ".mdl"
        local preBase = "hv_presignal_base_" .. sideSuffix .. ".mdl"
        -- main signal
        local mainModels = {
            [1] = "hv_tunnel_hp0.mdl",
            [2] = "hv_tunnel_hp1.mdl",
            [3] = "hv_tunnel_hp2.mdl",
        }
        local mainLights = mainModels[params.main] or mainModels[2]

        -- pre signal
        local preModels = {
            [1] = "",
            [2] = "hv_tunnel_vr0.mdl",
            [3] = "hv_tunnel_vr1.mdl",
            [4] = "hv_tunnel_vr2.mdl",
        }
        local preLights = preModels[params.pre] or ""
        -- special case Hp0
        if params.main == 1 then
            preLights = ""
        end



        -- result
		local result = {}
		result.signal = {
			soundevent = "",
			type = "WAYPOINT",
		}

        local edgeModels = {
			{
                edgeOffset = offset,
                model = {
                    id = resolve(mainBase),
                    transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 }
                }
            },
			{
                edgeOffset = offset,
                model = {
                    id = resolve(mainLights),
                    transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, sideOffset, 0, 1 }
                }
            },
        }
        -- if presignal is requested
        if params.pre > 1 then
		    table.insert(edgeModels, {
                    edgeOffset = offset,
                    model = {
                        id = resolve(preBase),
                    transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 }
                    }
            })
        end
        -- if lights are set
        if preLights ~= "" then
            table.insert(edgeModels, {
                edgeOffset = offset,
                model = {
                    id = resolve(preLights),
                    transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, sideOffset, 0, 1 }
                }
            })
        end

		result.edgeModels = edgeModels
		result.cost = 20000
		result.maintenanceCost = 5000

		return result
	end
}

end
