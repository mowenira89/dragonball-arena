class_name Recoil extends Effect

@export var amount:int
@export var damage_type:DamageEffect.DAMAGES

func apply(standee:AttackStandee,t:Character):
	var amt
	amt=amount
	for x in standee.user.buffs:
		amt=x.alter_incoming_damage(amt,standee.move,damage_type)
	standee.user.take_damage(amt,damage_type,standee.move)
	
