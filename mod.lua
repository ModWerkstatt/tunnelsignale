function data()
return {
	info = {
		minorVersion = 1,
		severityAdd = "NONE",
		severityRemove = "WARNING",
		name = _("mod_name"),
		description = _("mod_desc"),
		params = {
			{
				key = "tunnel_ks",
				name = _("Ks-Tunnelsignalsystem"),
				uiType = "CHECKBOX",
				values = { _("No"), _("Yes"), },				
				defaultIndex = 1,
			},
			{
				key = "tunnel_hv",
				name = _("Hv-Tunnelsignalsystem"),
				uiType = "CHECKBOX",
				values = { _("No"), _("Yes"), },				
				defaultIndex = 1,
			},
			{
				key = "tunnel_zs3Zs3v",
				name = _("Zs3/Zs3v"),
				uiType = "CHECKBOX",
				values = { _("No"), _("Yes"), },				
				defaultIndex = 1,
			},
			{
				key = "tunnel_zs2Zs2v",
				name = _("Zs2/Zs2v"),
				uiType = "CHECKBOX",
				values = { _("No"), _("Yes"), },				
				defaultIndex = 1,
			},
			{
				key = "tunnel_zs6Zp9",
				name = _("Zs6/Zp9"),
				uiType = "CHECKBOX",
				values = { _("No"), _("Yes"), },				
				defaultIndex = 1,
			},
			{
				key = "tunnel_waypoint",
				name = _("Wegpunkte"),
				uiType = "CHECKBOX",
				values = { _("No"), _("Yes"), },				
				defaultIndex = 1,
			},
		},
		modid = "modwerkstatt_tunnelsignale_1",
		authors = {
			{
				name = "ModWerkstatt",
				role = "CREATOR",
				text = "Modell, Mapping and Textures",
			},
		},
		url = "",
		steamId = 0,
		tags = { "Signal", "Tunnel", "Basis", },
		dependencies = { "modwerkstatt_signalkomponenten_1" },
	},
	runFn = function (settings, modParams)
		
		local function zs3Zs3vFilter(fileName, data)		
			if data.metadata.signal and data.metadata.tunnelsignal and data.metadata.tunnelsignal.zs3Zs3v == true then			
				data.metadata.availability.yearFrom = 1
				data.metadata.availability.yearTo = 2
				--return false
			end	
			--return true
			return data
		end 
		
		local function zs2Zs2vFilter(fileName, data)		
			if data.metadata.signal and data.metadata.tunnelsignal and data.metadata.tunnelsignal.zs2Zs2v == true then	
				data.metadata.availability.yearFrom = 1
				data.metadata.availability.yearTo = 2				
			end				
			return data
		end 
		
		local function zs6Zp9Filter(fileName, data)		
			if data.metadata.signal and data.metadata.tunnelsignal and data.metadata.tunnelsignal.zs6Zp9 == true then	
				data.metadata.availability.yearFrom = 1
				data.metadata.availability.yearTo = 2				
			end				
			return data
		end 
		
		local function waypointFilter(fileName, data)		
			if data.metadata.signal and data.metadata.tunnelsignal and data.metadata.signal.type == "WAYPOINT" then	
				data.metadata.availability.yearFrom = 1
				data.metadata.availability.yearTo = 2				
			end				
			return data
		end  
		
		local function ksFilter(fileName, data)		
			if data.metadata.signal and data.metadata.tunnelsignal and data.metadata.tunnelsignal.ks == true then	
				data.metadata.availability.yearFrom = 1
				data.metadata.availability.yearTo = 2				
			end				
			return data
		end  
		
		local function hvFilter(fileName, data)		
			if data.metadata.signal and data.metadata.tunnelsignal and data.metadata.tunnelsignal.hv == true then	
				data.metadata.availability.yearFrom = 1
				data.metadata.availability.yearTo = 2				
			end				
			return data
		end 
		
		if modParams[getCurrentModId()] ~= nil then
			local params = modParams[getCurrentModId()]					
			if params["tunnel_zs3Zs3v"] == 0 then				
				--addFileFilter("model/signal", zs3Zs3vFilter)	
				addModifier("loadModel", zs3Zs3vFilter)
			end
			if params["tunnel_zs2Zs2v"] == 0 then				
				addModifier("loadModel", zs2Zs2vFilter)
			end
			if params["tunnel_zs6Zp9"] == 0 then				
				addModifier("loadModel", zs6Zp9Filter)
			end
			if params["tunnel_waypoint"] == 0 then				
				addModifier("loadModel", waypointFilter)
			end
			if params["tunnel_ks"] == 0 then				
				addModifier("loadModel", ksFilter)
			end
			if params["tunnel_hv"] == 0 then				
				addModifier("loadModel", hvFilter)
			end
			
		else
			--addFileFilter("model/signal", zs3Zs3vFilter)			
			addModifier("loadModel", zs2Zs2vFilter)
			addModifier("loadModel", zs6Zp9Filter)
			addModifier("loadModel", waypointFilter)
			addModifier("loadModel", ksFilter)
			addModifier("loadModel", hvFilter)
		end	
	end
}
end