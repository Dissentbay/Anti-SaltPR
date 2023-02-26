/obj/item/circuitboard
	name = "circuit board"
	icon = 'icons/obj/module.dmi'
	icon_state = "id_mod"
	item_state = "electronic"
	origin_tech = list(TECH_DATA = 2)
	matter = list(MATERIAL_PLASTIC = 2, MATERIAL_STEEL = 2)
	matter_reagents = list("silicon" = 10)
	density = 0
	anchored = 0
	w_class = ITEM_SIZE_SMALL
	flags = CONDUCT
	force = WEAPON_FORCE_HARMLESS
	throwforce = WEAPON_FORCE_HARMLESS
	throw_speed = 3
	throw_range = 15

	price_tag = 50		// Inepxensive to produce

	var/build_name = null
	var/build_path = null
	var/frame_type = FRAME_DEFAULT
	var/board_type = "computer"
	var/list/req_components = list(  		//all vars below this one belong to bay
		/obj/item/stock_parts/console_screen = 1,
		/obj/item/stock_parts/keyboard = 1
	)  // Components needed to build the machine.
	var/list/spawn_components // If set, will be used as a replacement for req_components when setting components at round start.
	var/list/additional_spawn_components = list(
		/obj/item/stock_parts/power/apc/buildable = 1
	) // unlike the above, this is added to req_components instead of replacing them.
	var/buildtype_select = FALSE

/obj/item/circuitboard/New() //Using this to automate names on each board.
	..()
	if(build_name && build_name != null) //This check here is only because not all boards use automated names, apparently.
		name = "[build_name] board"

//Called when the circuitboard is used to contruct a new machine.
/obj/item/circuitboard/proc/construct(var/obj/machinery/M)
	if (istype(M, build_path))
		return TRUE
	return FALSE

//Called when a computer is deconstructed to produce a circuitboard.
//Only used by computers, as other machines store their circuitboard instance.
/obj/item/circuitboard/proc/deconstruct(var/obj/machinery/M)
	if (istype(M, build_path))
		return TRUE
	return FALSE

/obj/item/circuitboard/examine(user, distance)
	. = ..()
	// gets the required components and displays it in a list to the user when examined.
	if(length(req_components))
		var/list/listed_components = list()
		for(var/requirement in req_components)
			var/atom/placeholder = requirement
			if(!ispath(placeholder))
				continue
			listed_components += list("[req_components[placeholder]] [initial(placeholder.name)]")
		to_chat(user, SPAN_NOTICE("Required components: [english_list(listed_components)]."))

/obj/item/circuitboard/get_item_cost(export)
	. = ..()
	for(var/atom/movable/i in req_components)
		if(ispath(i))
			. += SStrade.get_new_cost(i) * log(10, price_tag / 2)
