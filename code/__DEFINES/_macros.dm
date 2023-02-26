
//-----------------Objects

#define sequential_id(key) uniqueness_repository.Generate(/datum/uniqueness_generator/id_sequential, key)

#define random_id(key,min_id,max_id) uniqueness_repository.Generate(/datum/uniqueness_generator/id_random, key, min_id, max_id)


//---------------------------------------------------

#define attack_animation(A) if(istype(A)) A.do_attack_animation(src)

// Helper macros to aid in optimizing lazy instantiation of lists.
// All of these are null-safe, you can use them without knowing if the list var is initialized yet

// Insert I into L at position X, initalizing L if necessary
#define LAZYINSERT(L, I, X) if(!L) { L = list(); } L.Insert(X, I);
// Adds I to L, initalizing L if necessary, if I is not already in L
#define LAZYDISTINCTADD(L, I) if(!L) { L = list(); } L |= I;

//#define to_chat(target, message)                            target << message
#define open_link(target, url)             					target << link(url)
#define from_file(file_entry, target_var)                   file_entry >> target_var

#define any2ref(x) "\ref[x]"

#define MAP_IMAGE_PATH "nano/images/[GLOB.maps_data.path]/"

#define map_image_file_name(z_level) "[GLOB.maps_data.path]-[z_level].png"

#define QDEL_NULL_LIST(x) if(x) { for(var/y in x) { qdel(y) } ; x = null }

// Spawns multiple objects of the same type
#define cast_new(type, num, args...) if((num) == 1) { new type(args) } else { for(var/i=0;i<(num),i++) { new type(args) } }

//Makes span tags easier
#define span(class, text) ("<span class='[class]'>[text]</span>")

#define JOINTEXT(X) jointext(X, null)

#define isopenturf(target) istype(target, /turf/simulated/open)

/// Test any bits of MASK are set in FIELD
#define GET_FLAGS(FIELD, MASK) ((FIELD) & (MASK))

/// Test all bits of MASK are set in FIELD
#define HAS_FLAGS(FIELD, MASK) (((FIELD) & (MASK)) == (MASK))

//bay stuff

/// Increase the size of L by 1 at the end. Is the old last entry index.
#define LIST_INC(L) ((L).len++)

/// Increase the size of L by 1 at the end. Is the new last entry index.
#define LIST_PRE_INC(L) (++(L).len)

/// Decrease the size of L by 1 from the end. Is the old last entry index.
#define LIST_DEC(L) ((L).len--)

/// Decrease the size of L by 1 from the end. Is the new last entry index.
#define LIST_PRE_DEC(L) (--(L).len)

/// Explicitly set the length of L to NEWLEN, adding nulls or dropping entries. Is the same value as NEWLEN.
#define LIST_RESIZE(L, NEWLEN) ((L).len = (NEWLEN))

// Spawns multiple objects of the same type
//#define cast_new(type, num, args...) if((num) == 1) { new type(args) } else { for(var/i=0;i<(num),i++) { new type(args) } }

//#define JOINTEXT(X) jointext(X, null)

#define SPAN_CLASS(class, X) "<span class='[class]'>[X]</span>"

#define SPAN_STYLE(style, X) "<span style=\"[style]\">[X]</span>"

#define SPAN_ITALIC(X) SPAN_CLASS("italic", "[X]")

#define SPAN_BOLD(X) SPAN_CLASS("bold", "[X]")

#define SPAN_NOTICE(X) SPAN_CLASS("notice", "[X]")

#define SPAN_WARNING(X) SPAN_CLASS("warning", "[X]")

#define SPAN_GOOD(X) SPAN_CLASS("good", "[X]")

#define SPAN_BAD(X) SPAN_CLASS("bad", "[X]")

#define SPAN_DANGER(X) SPAN_CLASS("danger", "[X]")

#define SPAN_OCCULT(X) SPAN_CLASS("cult", "[X]")

#define SPAN_MFAUNA(X) SPAN_CLASS("mfauna", "[X]")

#define SPAN_SUBTLE(X) SPAN_CLASS("subtle", "[X]")

#define SPAN_INFO(X) SPAN_CLASS("info", "[X]")

#define STYLE_SMALLFONTS(X, S, C1) SPAN_STYLE("font-family: 'Small Fonts'; color: [C1]; font-size: [S]px", "[X]")

#define STYLE_SMALLFONTS_OUTLINE(X, S, C1, C2) SPAN_STYLE("font-family: 'Small Fonts'; color: [C1]; -dm-text-outline: 1 [C2]; font-size: [S]px", "[X]")

#define SPAN_DEBUG(X) SPAN_CLASS("debug", "[X]")

#define SPAN_COLOR(color, text) SPAN_STYLE("color: [color]", "[text]")

#define SPAN_SIZE(size, text) SPAN_STYLE("font-size: [size]", "[text]")

#define FONT_SMALL(X) SPAN_SIZE("10px", "[X]")

#define FONT_NORMAL(X) SPAN_SIZE("13px", "[X]")

#define FONT_LARGE(X) SPAN_SIZE("16px", "[X]")

#define FONT_HUGE(X) SPAN_SIZE("18px", "[X]")

#define FONT_GIANT(X) SPAN_SIZE("24px", "[X]")

#define crash_with(X) crash_at(X, __FILE__, __LINE__)

/// General I/O helpers
#define to_target(target, payload)            target << (payload)
#define from_target(target, receiver)         target >> (receiver)

/// Common use
#define legacy_chat(target, message)          to_target(target, message)
#define to_world(message)                     to_chat(world, message)
#define to_world_log(message)                 to_target(world.log, message)
#define sound_to(target, sound)               to_target(target, sound)
//#define image_to(target, image)               to_target(target, image)
#define show_browser(target, content, title)  to_target(target, browse(content, title))
#define close_browser(target, title)          to_target(target, browse(null, title))
#define send_rsc(target, content, title)      to_target(target, browse_rsc(content, title))
#define send_link(target, url)                to_target(target, link(url))
#define send_output(target, msg, control)     to_target(target, output(msg, control))
#define to_file(handle, value)                to_target(handle, value)
#define to_save(handle, value)                to_target(handle, value) //semantics
#define from_save(handle, target_var)         from_target(handle, target_var)

/// Semantic define for a 0 int intended for use as a bitfield
#define EMPTY_BITFIELD 0


/// Right-shift of INT by BITS
#define SHIFTR(INT, BITS) ((INT) >> (BITS))


/// Left-shift of INT by BITS
#define SHIFTL(INT, BITS) ((INT) << (BITS))


/// Convenience define for nth-bit flags, 0-indexed
#define FLAG(BIT) SHIFTL(1, BIT)


/// Test bit at index BIT is set in FIELD
#define GET_BIT(FIELD, BIT) ((FIELD) & FLAG(BIT))


/// Test bit at index BIT is set in FIELD; semantic alias of GET_BIT
#define HAS_BIT(FIELD, BIT) GET_BIT(FIELD, BIT)


/// Set bit at index BIT in FIELD
#define SET_BIT(FIELD, BIT) ((FIELD) |= FLAG(BIT))


/// Unset bit at index BIT in FIELD
#define CLEAR_BIT(FIELD, BIT) ((FIELD) &= ~FLAG(BIT))


/// Flip bit at index BIT in FIELD
#define FLIP_BIT(FIELD, BIT) ((FIELD) ^= FLAG(BIT))

#define isstack(A) istype(A, /obj/item/stack)

// Insert an object A into a sorted list using cmp_proc (/code/_helpers/cmp.dm) for comparison.
#define ADD_SORTED(list, A, cmp_proc) if(!length(list)) {list.Add(A)} else {list.Insert(FindElementIndex(A, list, cmp_proc), A)}

#define ismachinerestricted(A) (issilicon(A) && A.machine_restriction)
