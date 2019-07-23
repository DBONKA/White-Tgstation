/obj/item/gun/ballistic/rifle/boltaction/ptr
	name = "AMATR M4ND4"
	desc = "��� ���� ���������������� ��������������� ����� M4ND4"
	icon = 'code/shitcode/hule/icons/obj/weapons.dmi'
	icon_state = "ptr"
	item_state = "ptr"
	lefthand_file = 'code/shitcode/hule/icons/onmob/guns96_l.dmi'
	righthand_file = 'code/shitcode/hule/icons/onmob/guns96_r.dmi'
	inhand_x_dimension = -32
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/intmagptr
	can_bayonet = FALSE


/obj/item/ammo_box/magazine/internal/boltaction/intmagptr
	max_ammo = 1
	ammo_type = /obj/item/ammo_casing/a15mm
	caliber = "15mm"

/obj/item/ammo_casing/a15mm
	name = "15mm bullet casing"
	desc = "A 15mm bullet casing."
	icon = 'code/shitcode/hule/icons/obj/weapons.dmi'
	icon_state = "15mm-casing"
	caliber = "15mm"
	projectile_type = /obj/item/projectile/bullet/a15mm

/obj/item/projectile/bullet/a15mm
	name = "15mm bullet"
	damage = 99
	speed = 0.5
	dismemberment = 70
	pass_flags = PASSTABLE | PASSGRILLE

/obj/item/projectile/bullet/a15mm/on_hit(atom/target)
	. = ..()
	if(istype(target, /obj/mecha))
		target.ex_act(EXPLODE_HEAVY)
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		if(def_zone == BODY_ZONE_HEAD)
			var/obj/item/bodypart/head/head = C.get_bodypart(BODY_ZONE_HEAD)
			head.drop_limb()
			playsound(src,'code/shitcode/hule/SFX/headshot.ogg', 100, 5, pressure_affected = FALSE)
		if(def_zone == BODY_ZONE_CHEST)
			if(prob(30))
				if(C.getorganslot(ORGAN_SLOT_HEART))
					C.getorganslot(ORGAN_SLOT_HEART).Remove(special = 1)

/obj/item/ammo_box/a15mm
	name = "ammo box (15mm)"
	w_class = WEIGHT_CLASS_SMALL
	icon_state = "10mmbox"
	ammo_type = /obj/item/ammo_casing/a15mm
	max_ammo = 10

/datum/outfit/ptrschoolshooter
	name = "Schoolshooter 2.0"

	glasses = /obj/item/clothing/glasses/sunglasses
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/armor/vest/leather
	shoes = /obj/item/clothing/shoes/combat
	head = /obj/item/clothing/head/soft/black
	suit_store = /obj/item/gun/ballistic/rifle/boltaction/ptr
	l_pocket = /obj/item/switchblade
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/ammo_box/a15mm = 3, /obj/item/grenade/syndieminibomb/concussion = 2, /obj/item/grenade/plastic/c4 = 1)

/datum/outfit/asshunter
	name = "Okhotnik Na Pedikov"

	glasses = /obj/item/clothing/glasses/sunglasses
	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/space/hostile_environment
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat/maggloves
	head = /obj/item/clothing/head/helmet/space/hostile_environment
	mask = /obj/item/clothing/mask/gas/anonist
	suit_store = /obj/item/tank/internals/emergency_oxygen/double
	r_hand = /obj/item/gun/ballistic/rifle/boltaction/ptr
	id = /obj/item/card/id/silver/reaper
	l_pocket = /obj/item/switchblade
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(	/obj/item/ammo_box/a15mm = 3,
								/obj/item/grenade/syndieminibomb/concussion = 2,
								/obj/item/grenade/plastic/c4 = 1,
								/obj/item/book/granter/spell/knock = 1,
								/obj/item/book/granter/spell/summonitem = 1,
								/obj/item/book/granter/martial/cqc = 1,
								/obj/item/tank/internals/emergency_oxygen/double = 1



								)