function data()

return {
	updateFn = function(captureParams, params)
        -- side
        local sideSuffix = (params.side == 1) and "_left" or "_right"

        -- base
        local offset = params.offset*-1
        local mainBase = "hv_base_right.mdl"
        local preBase = "hv_presignal_base_right.mdl"
        if params.side == 1 then
            mainBase = "hv_base_left.mdl"
            preBase = "hv_presignal_base_left.mdl"
        end
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
			type = "PATH_SIGNAL",
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
                    transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 }
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
                    transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 }
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
