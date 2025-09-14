/atom/MouseEntered(location, control, params)
	SSmouse_entered.hovers[usr.client] = src
	if(!no_over_text)
		INVOKE_ASYNC(src, PROC_REF(create_over_text), usr, params2list(params))

/// Fired whenever this atom is the most recent to be hovered over in the tick.
/// Preferred over MouseEntered if you do not need information such as the position of the mouse.
/// Especially because this is deferred over a tick, do not trust that `client` is not null.
/atom/proc/on_mouse_enter(client/client)
	SHOULD_NOT_SLEEP(TRUE)

	var/mob/user = client?.mob
	if(!user)
		return

	SEND_SIGNAL(client, COMSIG_CLIENT_HOVER_NEW, src)
	SEND_SIGNAL(src, COMSIG_ATOM_MOUSE_ENTERED, user)
	SEND_SIGNAL(user, COMSIG_USER_MOUSE_ENTERED, src)

	if(isturf(src))
		SEND_SIGNAL(user, COMSIG_MOUSE_ENTERED, src)

/atom/MouseExited(params)
	if(no_over_text)
		return
	var/datum/hud/user_hud = usr?.hud_used
	if(!user_hud?.mouse_over_text)
		return
	user_hud.mouse_over_text.screen_loc = null

<<<<<<< HEAD
/atom/proc/handle_mouseover(location, control, params)
	var/mob/p = usr
	if(p.client)
		if(!p.client.mouseovertext)
			p.client.genmouseobj()
			return FALSE
		if(p.client.pixel_x || p.client.pixel_y)
			return FALSE
		if(!p.x || !p.y)
			return FALSE
		var/offset_x = 8 - (p.x - x)
		var/offset_y = 8 - (p.y - y)
		var/list/PM = list("screen-loc" = "[offset_x]:0,[offset_y]:0")
		if(!isturf(loc))
			PM = params2list(params)
			p.client.mouseovertext.movethis(PM, TRUE)
		else
			p.client.mouseovertext.movethis(PM)
		p.client.mouseovertext.maptext_height = 32
		p.client.mouseovertext.maptext_width = 96
		p.client.mouseovertext.maptext = MAPTEXT_CENTER("<span style='color:[hover_color]'>[name]</span>")
		p.client.screen |= p.client.mouseovertext
	return TRUE
=======
#define HOVER_TEXT_WIDTH 128
>>>>>>> vanderlin/main

/// Create a maptext over a hovered atom, at the hovered atom's position
/atom/proc/create_over_text(mob/user, list/modifiers)
	if(!user)
		return
	var/used_content = get_over_text_content(user)
	if(!length(used_content))
		return
	var/atom/movable/mouse_over = user.hud_used?.mouse_over_text
	if(!mouse_over)
		return
	if(ismovable(src))
		var/atom/movable/AM = src
		if(AM.screen_loc)
			mouse_over.screen_loc = AM.screen_loc
	if(!mouse_over.screen_loc)
		var/list/screen_loc_params = splittext(LAZYACCESS(modifiers, SCREEN_LOC), ",")
		var/world_x = LAZYACCESS(splittext(screen_loc_params[1], ":"), 1)
		var/world_y = LAZYACCESS(splittext(screen_loc_params[2], ":"), 1)
		mouse_over.screen_loc = "[world_x]:0,[world_y]:0"
	mouse_over.maptext = MAPTEXT_CENTER("<span style='color:[hover_color]'>[used_content]</span>")
	mouse_over.maptext_y = maptext_height
	mouse_over.maptext_x = (HOVER_TEXT_WIDTH - world.icon_size) * -0.5 - base_pixel_x
	WXH_TO_HEIGHT(user.client.MeasureText(used_content, null, HOVER_TEXT_WIDTH), mouse_over.maptext_height)
	mouse_over.maptext_width = HOVER_TEXT_WIDTH

<<<<<<< HEAD
/obj/structure/handle_mouseover(location, control, params)
	var/mob/p = usr
	if(p.client)
		if(!p.client.mouseovertext)
			p.client.genmouseobj()
			return FALSE
		if(p.client.pixel_x || p.client.pixel_y)
			return FALSE
		if(!p.x || !p.y)
			return FALSE
		var/offset_x = 8 - (p.x - x)
		var/offset_y = 8 - (p.y - y)
		var/list/PM = list("screen-loc" = "[offset_x]:0,[offset_y]:0")
		if(!isturf(loc))
			PM = params2list(params)
			p.client.mouseovertext.movethis(PM, TRUE)
		else
			p.client.mouseovertext.movethis(PM)
		if((((rotation_structure && rotation_network) || istype(src, /obj/structure/water_pipe)) || accepts_water_input) && HAS_TRAIT(p, TRAIT_ENGINEERING_GOGGLES))
			var/rotation_chat = return_rotation_chat(p.client.mouseovertext)
			p.client.mouseovertext.maptext_width = 96
			p.client.mouseovertext.maptext = MAPTEXT_CENTER("<span style='color:#e6b120'>[rotation_chat]</span>")
		else
			p.client.mouseovertext.maptext_height = 32
			p.client.mouseovertext.maptext_width = 96
			p.client.mouseovertext.maptext = MAPTEXT_CENTER("<span style='color:[hover_color]'>[name]</span>")
		p.client.screen |= p.client.mouseovertext
	return TRUE
=======
#undef HOVER_TEXT_WIDTH
>>>>>>> vanderlin/main

/atom/proc/get_over_text_content(mob/user)
	return name

/obj/structure/get_over_text_content(mob/user)
	if(!user)
		return
	if(HAS_TRAIT(user, TRAIT_ENGINEERING_GOGGLES) && (((rotation_structure && rotation_network) || istype(src, /obj/structure/water_pipe)) || accepts_water_input))
		return "<span style='color:#e6b120'>[return_rotation_chat()]</span>"
	return ..()

/mob/living/carbon/human/get_over_text_content(mob/user)
	if(voice_color && name != "Unknown")
		return "<span style='color:#[voice_color]'>[name]</span>"
	return ..()

/atom/proc/return_rotation_chat()
	return

<<<<<<< HEAD
/atom/proc/handle_mouseexit(params)
	var/mob/p = usr
	if(p.client)
		if(!p.client.mouseovertext)
			p.client.genmouseobj()
			return FALSE
		p.client.mouseovertext.screen_loc = null
	return TRUE

/*
/turf/MouseEntered(location,control,params)
	. = ..()
	if(!density)
		return
	if(istype(usr, /mob) && !nomouseover)
		var/list/PM = params2list(params)
		var/mob/p = usr
		if(p.boxaim && p.client)
			p.client.mouseoverbox.movethis(PM)

/turf/MouseExited(params)
	. = ..()
	if(!density)
		return
	if(!nomouseover)
		var/mob/living/p = usr
		if(p.boxaim && p.client)
			p.client.mouseoverbox.screen_loc = null
*/

/turf/handle_mouseover(location,control,params)
	var/mob/p = usr
	if(p.client)
		if(!p.client.mouseovertext)
			p.client.genmouseobj()
			return FALSE
		if(p.client.pixel_x || p.client.pixel_y)
			return FALSE
		if(!p.x || !p.y)
			return FALSE
		var/offset_x = 8 - (p.x - x)
		var/offset_y = 8 - (p.y - y)
		if(offset_x < 1 || offset_x > 15 || offset_y < 1 || offset_x > 15)
			return FALSE
		var/list/PM = list("screen-loc" = "[offset_x]:0,[offset_y]:0")
		p.client.mouseovertext.maptext = MAPTEXT_CENTER("<span style='color:[hover_color]'>[name]</span>")
		p.client.mouseovertext.movethis(PM)
		p.client.screen |= p.client.mouseovertext
	return TRUE

/turf/open/handle_mouseover(location, control, params)
	var/mob/p = usr
	if(p.client)
		if(!p.client.mouseovertext)
			p.client.genmouseobj()
			return FALSE
		if(p.client.pixel_x || p.client.pixel_y)
			return FALSE
		if(!p.x || !p.y)
			return FALSE
		var/offset_x = 8 - (p.x - x)
		var/offset_y = 8 - (p.y - y)
		var/list/PM = list("screen-loc" = "[offset_x]:0,[offset_y]:0")
		p.client.mouseovertext.maptext = MAPTEXT_CENTER("<span style='color:[hover_color]'>[name]</span>")
		p.client.mouseovertext.movethis(PM)
		p.client.screen |= p.client.mouseovertext
	return TRUE

/mob/handle_mouseover(location,control,params)
	var/mob/p = usr
	if(p.client)
		if(!p.client.mouseovertext)
			p.client.genmouseobj()
			return FALSE
		if(isliving(p))
			var/mob/living/L = p
			if(!L.can_see_cone(src))
				return FALSE
		if(p.client.pixel_x || p.client.pixel_y)
			return FALSE
		if(alpha == 0)
			return FALSE
		if(!p.x || !p.y)
			return FALSE
		var/offset_x = 8 - (p.x - x)
		var/offset_y = 8 - (p.y - y)
		var/list/PM = list("screen-loc" = "[offset_x]:0,[offset_y]:0")
		var/mousecolor = "#c1aaaa"
		if(ishuman(src))
			var/mob/living/carbon/human/H = src
			if(H.voice_color)
				if(H.name != "Unknown")
					mousecolor = "#[H.voice_color]"
		p.client.mouseovertext.maptext = MAPTEXT_CENTER("<span style='color:[mousecolor]'>[name]</span>")
		p.client.mouseovertext.movethis(PM)
		p.client.screen |= p.client.mouseovertext
	return TRUE

=======
>>>>>>> vanderlin/main
/atom/movable/screen
	no_over_text = TRUE

/atom/movable/screen/movable/mouseover
	name = ""
	icon = 'icons/mouseover.dmi'
	icon_state = "mouseover"
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	plane = ABOVE_HUD_PLANE + 1

/atom/movable/screen/movable/mouseover/maptext
	name = ""
	icon = null
	icon_state = null
	animate_movement = NO_STEPS
	alpha = 190
