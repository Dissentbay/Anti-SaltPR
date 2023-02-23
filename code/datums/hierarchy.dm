/decl/hierarchy
	var/name = "Hierarchy"
	var/hierarchy_type
	var/decl/hierarchy/parent
	var/list/decl/hierarchy/children

/decl/hierarchy/New(var/full_init = TRUE)
	children = list()
	if(!full_init)
		return

	var/list/all_subtypes = list()
	all_subtypes[type] = src
	for(var/subtype in subtypesof(type))
		all_subtypes[subtype] = new subtype(FALSE)

	for(var/subtype in (all_subtypes - type))
		var/decl/hierarchy/subtype_instance = all_subtypes[subtype]
		var/decl/hierarchy/subtype_parent = all_subtypes[subtype_instance.parent_type]
		subtype_instance.parent = subtype_parent
		dd_insertObjectList(subtype_parent.children, subtype_instance)

/decl/hierarchy/proc/is_category()
	return hierarchy_type == type || children.len

/decl/hierarchy/proc/is_hidden_category()
	return hierarchy_type == type

/decl/hierarchy/proc/get_descendents()
	if(!children)
		return
	. = children.Copy()
	for(var/decl/hierarchy/child in children)
		if(child.children)
			. += child.get_descendents()

/decl/hierarchy/dd_SortValue()
	return name

//bay singletons! totally different from decl, trust me
/singleton/hierarchy
	var/name = "Hierarchy"
	var/hierarchy_type
	var/singleton/hierarchy/parent
	var/list/singleton/hierarchy/children

/singleton/hierarchy/Initialize()
	children = list()
	for(var/subtype in subtypesof(type))
		var/singleton/hierarchy/child = GET_SINGLETON(subtype) // Might be a grandchild, which has already been handled.
		if(child.parent_type == type)
			dd_insertObjectList(children, child)
			child.parent = src
	return ..()

/singleton/hierarchy/proc/is_category()
	return hierarchy_type == type || length(children)

/singleton/hierarchy/proc/is_hidden_category()
	return hierarchy_type == type

/singleton/hierarchy/proc/get_descendents()
	if(!children)
		return
	. = children.Copy()
	for(var/singleton/hierarchy/child in children)
		if(child.children)
			. += child.get_descendents()

/singleton/hierarchy/dd_SortValue()
	return name
