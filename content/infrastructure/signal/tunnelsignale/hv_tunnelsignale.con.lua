function data()
return {
		availability = {
			yearFrom = 1978,
			yearTo = 1998,
		},
		description = {
			attributes = {
				cost = { 20000, -1, },
				maintenanceCost = { 5000, -1, },
				noise = { 0, -1, },
				pollution = { 0, -1, },
			},
			description = _("Hv_Tunnelsignale_desc"),
			icon = "icons/tunnelsignale_icon_small.tga",
			name = _("Hv_Tunnelsignale_menu"),
			previewIcon = "icons/tunnelsignale_preview.tga",
		},
		menuCategory = {
			categories = {
				{
					category = "rail_tools",
					filterCategories = { },
					order = 3001,
				},
			},
		},
		soundConfig = {
			builderAudioRes = "::/gui/construction/sound/buildoze_construction_small.builder_audio",
			soundSet = {
				name = "",
			},
		},
		updateScript = {
			fileName = "hv_tunnelsignale.script@updateFn",
			params = {
			}
		},
		configureHudIconsScript = {
			fileName = "::/gui/construction/construction_desc_hud_icons.script@configureDepotHudIconsFn",
			params = {
				depotType = "RAIL",
			}
		},
		edgeObject = {
			snapToTrack = true,
		},
		params = {
            {
				key = "mw_main",
				name = _("Main_signal"),
				values = { _("Hp0"), _("Hp1"), _("Hp2"), },
				defaultIndex = 2,
                displayMode = "Horizontal",
                postConstructionModifiable = true,
			},
            {
				key = "mw_pre",
				name = _("Pre_signal"),
				values = { _("without"), _("Vr0"), _("Vr1"), _("Vr2"), },
				defaultIndex = 1,
                displayMode = "Horizontal",
                postConstructionModifiable = true,
			},
			{
				key = "mw_side",
				name = _("TrackPos"),
				values = { _("left"), _("right") },
				defaultIndex = 2,
                displayMode = "Horizontal",
                postConstructionModifiable = true,
                group = "generalParams",
			},
			{
				key = "mw_waypoint",
				name = _("Waypoint"),
				values = { _("Yes"), _("No") },
				defaultIndex = 2,
                displayMode = "Horizontal",
                postConstructionModifiable = true,
                group = "generalParams",
			},
			{
				key = "mw_oneway",
				name = _("One-Way"),
				values = { _("Yes"), _("No") },
				defaultIndex = 2,
                displayMode = "Horizontal",
                checkEnabledScript = {
                    fileName = "mw_signalkomponenten::/infrastructure/signal/mw_signalkomponenten/script/oneway_construction.script@checkEnabledFn",
                    params = {
                          key = "mw_waypoint",
                          threshold = 1,
                    },
                },
                group = "generalParams",
			},
            {
				key = "mw_offset",
				name = _("Offset"),
				uiType = "Slider",
                values = { _("0m"), _("1m"), _("2m"), _("3m"), _("4m"), _("5m"), _("6m"), _("7m"), _("8m"), _("9m"), _("10m"), _("11m"), _("12m"), _("13m"), _("14m"), _("15m"), _("16m"), _("17m"), _("18m"), _("19m"), _("20m"), },
				defaultIndex = 9,
                postConstructionModifiable = true,
                group = "generalParams",
			},
		},
	}
end
