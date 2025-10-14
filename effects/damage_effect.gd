class_name DamageEffect extends Effect

enum DAMAGES {Normal, Piercing, Affliction, HealthSteal}

@export var amount:int
@export var damage_type:DAMAGES

func apply(standee:AttackStandee):
	var amt
	amt=amount
	var used_damage_type=damage_type
	for x in standee.user.buffs:
		if x is AlterDamageType:
			used_damage_type = x.switch_to
	for x in standee.user.buffs:
		amt=x.alter_outgoing_damage(amt,standee.move,used_damage_type)
	standee.target.take_damage(amt,damage_type,standee.move)
	
	
