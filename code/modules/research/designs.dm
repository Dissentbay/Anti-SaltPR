/***************************************************************
**						Design Datums						  **
**	All the data for building stuff and tracking reliability. **
***************************************************************/
/*
For the materials datum, it assumes you need reagents unless specified otherwise. To designate a material that isn't a reagent,
you use one of the material IDs below. These are NOT ids in the usual sense (they aren't defined in the object or part of a datum),
they are simply references used as part of a "has materials?" type proc. They all start with a to denote that they aren't reagents.
The currently supporting non-reagent materials:

Don't add new keyword/IDs if they are made from an existing one (such as rods which are made from metal). Only add raw materials.

Design Guidlines
- When adding new designs, check rdreadme.dm to see what kind of things have already been made and where new stuff is needed.

- A single sheet of anything is 1 unit of material. Materials besides metal/glass require help from other jobs (mining for
other types of metals and chemistry for reagents).

- When making something have a cost, it !adds! onto the materials it needs to print
(But when resycaled in an autolathen you do not get them back)

*/


/datum/design/research     //Datum for object designs, used in construction
	starts_unlocked = FALSE

/datum/design/research/item
	build_type = AUTOLATHE | PROTOLATHE
	category = "Misc" //No more unsorted things

/datum/design/research/item/mechfab
	build_type = MECHFAB

/datum/design/research/item/clothing
	category = CAT_CLOTHING

/datum/design/research/item/tool
	category = CAT_TOOLS

/datum/design/research/item/part
	build_type = AUTOLATHE | PROTOLATHE
	category = CAT_STOCKPARTS

/datum/design/research/item/part/AssembleDesignDesc()
	if(!desc)
		desc = "A stock part used in the construction of various devices."

//start of bay stuff, so atmos machines can be "reliable"

/***************************************************************
**						Design Datums						  **
**	All the data for building stuff and tracking reliability. **
***************************************************************/
/*
For the materials datum, it assumes you need reagents unless specified otherwise. To designate a material that isn't a reagent,
you use one of the material IDs below. These are NOT ids in the usual sense (they aren't defined in the object or part of a datum),
they are simply references used as part of a "has materials?" type proc. They all start with a  to denote that they aren't reagents.
The currently supporting non-reagent materials:

Don't add new keyword/IDs if they are made from an existing one (such as rods which are made from metal). Only add raw materials.

Design Guidlines
- When adding new designs, check rdreadme.dm to see what kind of things have already been made and where new stuff is needed.
- A single sheet of anything is 2000 units of material. Materials besides metal/glass require help from other jobs (mining for
other types of metals and chemistry for reagents).

*/
//Note: More then one of these can be added to a design.

/datum/design						//Datum for object designs, used in construction
	var/name = null					//Name of the created object. If null it will be 'guessed' from build_path if possible.
	var/desc = null					//Description of the created object. If null it will use group_desc and name where applicable.
	var/item_name = null			//An item name before it is modified by various name-modifying procs
	var/id = "id"					//ID of the created object for easy refernece. Alphanumeric, lower-case, no symbols.
	var/list/req_tech = list()		//IDs of that techs the object originated from and the minimum level requirements.
	var/build_type = null			//Flag as to what kind machine the design is built in. See defines.
	var/list/materials = list()		//List of materials. Format: "id" = amount.
	var/list/chemicals = list()		//List of chemicals.
	var/build_path = null			//The path of the object that gets created.
	var/time = 10					//How many ticks it requires to build
	var/category = null 			//Primarily used for Mech Fabricators, but can be used for anything.
	var/sort_string = "ZZZZZ"		//Sorting order

/datum/design/New()
	..()
	item_name = name
	AssembleDesignInfo()
/* we are not ready for all of that, duplicated procs on the autolathe code for some reason
//These procs are used in subtypes for assigning names and descriptions dynamically
/datum/design/proc/AssembleDesignInfo()
	AssembleDesignName()
	AssembleDesignDesc()
	return

/datum/design/proc/AssembleDesignName()
	if(!name && build_path)					//Get name from build path if posible
		var/atom/movable/A = build_path
		name = initial(A.name)
		item_name = name
	return

/datum/design/proc/AssembleDesignDesc()
	if(!desc)								//Try to make up a nice description if we don't have one
		desc = "Allows for the construction of \a [item_name]."
	return

//Returns a new instance of the item for this design
//This is to allow additional initialization to be performed, including possibly additional contructor arguments.
/datum/design/proc/Fabricate(newloc, fabricator)
	return new build_path(newloc)
*/
/datum/design/item
	build_type = PROTOLATHE

// Testing helper
GLOBAL_LIST_INIT(build_path_to_design_datum_path, populate_design_datum_index())

/proc/populate_design_datum_index()
	. = list()
	for(var/path in typesof(/datum/design))
		var/datum/design/fake_design = path
		if(initial(fake_design.build_path))
			.[initial(fake_design.build_path)] = path
