GLOBAL_VAR_INIT(prikol_mode, FALSE)

/mob/living
	var/datum/cs_killcounter/killcounter

//nasral na living.dm

/datum/cs_killcounter
	var/mob/living/owner
	var/killcount = 0
	var/killstreak = 0
	var/maxkillstreak = 0
	var/time4kill = 150
	var/timer = 0

/datum/cs_killcounter/New()
	. = ..()
	START_PROCESSING(SSobj, src)

/datum/cs_killcounter/Destroy()
	. = ..()
	maxkillstreak = killstreak
	STOP_PROCESSING(SSobj, src)

/datum/cs_killcounter/process()
	if(timer)
		timer--
	else
		maxkillstreak = killstreak
		killstreak = 0

/datum/cs_killcounter/proc/count_kill(var/headshot = FALSE)
	killcount++

	if(!GLOB.prikol_mode && owner.mind.antag_datums)
		var/count = FALSE
		for(var/datum/antagonist/A in owner.mind.antag_datums)
			if(istype(A, /datum/antagonist/traitor) && /datum/objective/hijack in A.objectives)
				count = TRUE
			else if (istype(A, /datum/antagonist/nukeop))
				count = TRUE

		if(!count)
			return

	killstreak++
	timer += time4kill

	if(headshot)
		addtimer(CALLBACK(src, .proc/killsound), 25)
	else
		killsound()



/datum/cs_killcounter/proc/killsound() // ya hz ebat' y menya kakayata huevaya liba zvukov iz cs
	var/turf/T = get_turf(owner)
	switch(killstreak)
		if(2)
			playsound(T,'code/shitcode/hule/SFX/csSFX/doublekill1_ultimate.wav', 150, 5, pressure_affected = FALSE)
		if(3)
			playsound(T,'code/shitcode/hule/SFX/csSFX/triplekill_ultimate.wav', 150, 5, pressure_affected = FALSE)
		if(4)
			playsound(T,'code/shitcode/hule/SFX/csSFX/killingspree.wav', 150, 5, pressure_affected = FALSE)
		if(5)
			playsound(T,'code/shitcode/hule/SFX/csSFX/godlike.wav', 150, 5, pressure_affected = FALSE)
		if(6)
			playsound(T,'code/shitcode/hule/SFX/csSFX/monsterkill.wav', 150, 5, pressure_affected = FALSE)
		if(7)
			playsound(T,'code/shitcode/hule/SFX/csSFX/multikill.wav', 150, 5, pressure_affected = FALSE)
		if(8)
			playsound(T,'code/shitcode/hule/SFX/csSFX/multikill.wav', 150, 5, pressure_affected = FALSE)
		if(9 to INFINITY)
			playsound(T,'code/shitcode/hule/SFX/csSFX/holyshit.wav', 150, 5, pressure_affected = FALSE)

/client/proc/toggle_prikol()
	set category = "Fun"
	set name = "Toggle P.R.I.K.O.L"

/*
	if(!(usr.ckey in GLOB.anonists))
		to_chat(usr, "<span class='userdanger'>�����, �� ��� ������, ��� ������.........</span>")
		return
*/
	if(!check_rights())
		return

	GLOB.prikol_mode = !GLOB.prikol_mode

	if(GLOB.prikol_mode)
		message_admins("[key] toggled P.R.I.K.O.L mode on.")
	else
		message_admins("[key] toggled P.R.I.K.O.L mode off.")

//nasral na death.dm

/proc/secure_kill(var/frabbername)
	for(var/mob/living/L in GLOB.player_list)
		if(L.real_name == frabbername)
			L.killcounter.count_kill()
