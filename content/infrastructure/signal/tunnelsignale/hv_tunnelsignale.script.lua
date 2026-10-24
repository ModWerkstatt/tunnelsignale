function data()

return {
	updateFn = function(captureParams, params)
        -- side
        local isLeft = params.mw_tunnel_side == 1
        local sideSuffix = isLeft and "left" or "right"
        local sideDistance = 2.1
        local sideOffset = isLeft and sideDistance or -sideDistance
        local offset_x = (params and params.mw_tunnel_offset) and (params.mw_tunnel_offset * -1) or 0
        local isHv = params.mw_tunnel_type ~= 2
        local edgeModels = { }

        local signalType = params.mw_tunnel_waypoint == 1 and "WAYPOINT" or "PATH_SIGNAL"
        if params.mw_tunnel_waypoint == 2 and params.mw_tunnel_oneway == 1 then
            signalType = "ONE_WAY_PATH_SIGNAL"
        end

        if isHv then -- Hv type
            -- base
            
            local mainBase = "hv_base_" .. sideSuffix .. ".mdl"
            local preBase = "hv_presignal_base_" .. sideSuffix .. ".mdl"
            -- main signal
            local mainModels = {
                [1] = "hv_tunnel_hp0.mdl",
                [2] = "hv_tunnel_hp1.mdl",
                [3] = "hv_tunnel_hp2.mdl",
            }
            local mainLights = mainModels[params.mw_tunnel_hv_main] or mainModels[2]

            -- pre signal
            local preModels = {
                [1] = "",
                [2] = "hv_tunnel_vr0.mdl",
                [3] = "hv_tunnel_vr1.mdl",
                [4] = "hv_tunnel_vr2.mdl",
            }
            local preLights = preModels[params.mw_tunnel_hv_pre] or ""
            -- special case Hp0
            if params.mw_tunnel_hv_main == 1 then
                preLights = ""
            end

            edgeModels = {
			    {
                    edgeOffset = offset_x,
                    model = {
                        id = resolve(mainBase),
                        transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 }
                    }
                },
			    {
                    edgeOffset = offset_x,
                    model = {
                        id = resolve(mainLights),
                        transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, sideOffset, 0, 1 }
                    }
                },
            }
            -- if presignal is requested
            if not params.mw_tunnel_hv_pre or params.mw_tunnel_hv_pre > 1 then
		        table.insert(edgeModels, {
                    edgeOffset = offset_x,
                    model = {
                        id = resolve(preBase),
                        transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 }
                    }
                })
            end
            -- if lights are set
            if preLights ~= "" then
                table.insert(edgeModels, {
                    edgeOffset = offset_x,
                    model = {
                        id = resolve(preLights),
                        transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, sideOffset, 0, 1 }
                    }
                })
            end
        else -- Ks type
            local mainBase = "ks_base_" .. sideSuffix .. ".mdl"
            local statusSignal = params.mw_tunnel_ks_optik
            local statusLicht = params.mw_tunnel_ks_light
            local offset_y = isLeft and 2.85 or -2.15

            edgeModels = {}
            table.insert(edgeModels, {
                edgeOffset = offset_x,
                model = {
                    id = resolve(mainBase),
                    transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, sideOffset, 0, 1 }
                }
            })
            if statusSignal ~= 4 then
                table.insert(edgeModels, {
                    edgeOffset = offset_x,
                    model = {
                       id = resolve("mw_signalkomponenten::/infrastructure/signal/mw_signalkomponenten/ks_pzb_1000.mdl"),
                    	transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, -1.05, 0.02, 1 }
                    }
                })
            end
            if statusSignal == 1 or statusSignal == 2 then
                table.insert(edgeModels, {
                    edgeOffset = offset_x,
                    model = {
                       id = resolve("ks_schild_hsig.mdl"),
                    	transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, offset_y, 0.02, 1 }
                    }
                })
                if statusSignal == 2 then
                    table.insert(edgeModels, {
                        edgeOffset = offset_x,
                        model = {
                           id = resolve("ks_schild_msig.mdl"),
                        	transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, offset_y, 0.02, 1 }
                        }
                    })
                end
            elseif statusSignal == 3 then
                table.insert(edgeModels, {
                    edgeOffset = offset_x,
                    model = {
                       id = resolve("ks_schild_vsig.mdl"),
                    	transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, offset_y-0.2, 0.02, 1 }
                    }
                })
            end
            
            local lightGreen
            if statusLicht == 2 then
                lightGreen = "ks1"
            elseif statusLicht == 3 then
                lightGreen = "ks1b"
            elseif statusLicht == 4 then
                lightGreen = "ks2"
            end
            
            if isLeft then
                offset_y = offset_y-0.75
            else
                offset_y = offset_y+0.05
            end
            
            if statusLicht == 1 then
                table.insert(edgeModels, {
                    edgeOffset = offset_x,
                    model = {
                       id = resolve("ks_licht_hp0_hp0.mdl"),
                    	transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, offset_y, 0.01, 1 }
                    }
                })
            else
                table.insert(edgeModels, {
                    edgeOffset = offset_x,
                    model = {
                       id = resolve("ks_licht_hp0.mdl"),
                    	transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, offset_y, 0.01, 1 }
                    }
                })
                table.insert(edgeModels, {
                    edgeOffset = offset_x,
                    model = {
                       id = resolve("ks_licht_" .. lightGreen .. ".mdl"),
                    	transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, offset_y, 0, 1 }
                    }
                })
            end
            
            if statusSignal == 4 then
                table.insert(edgeModels, {
                    edgeOffset = offset_x,
                    model = {
                   	    id = resolve("ks_licht_unten.mdl"),
                        transf = { 0.8, 0, 0, 0, 0, 0.8, 0, 0, 0, 0, 0.8, 0, 0, offset_y, 3.275, 1 }
             		}
             	})
                signalType = "WAYPOINT"
            end
        end

        -- result
		local result = {}
		result.signal = {
			soundevent = "",
			type = signalType,
		}

		result.edgeModels = edgeModels
		result.cost = 20000
		result.maintenanceCost = 5000

		return result
	end
}

end
