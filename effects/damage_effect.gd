class_name DamageEffect extends Effect

enum DAMAGES {Normal, Piercing, Affliction, HealthSteal}

@export var amount:int
@export var damage_type:DAMAGES

func apply(standee:AttackStandee,t:Character):
	var amt
	amt=amount
	var used_damage_type=damage_type
	for x in standee.user.buffs:
		if x is AlterDamageType:
			used_damage_type = x.switch_to
	for x in standee.user.buffs:
		amt=x.alter_outgoing_damage(amt,standee.move,used_damage_type)
	if standee.move.stackable_boost:
		for x in standee.user.buffs:
			if x is MoveStack and x.affected_move.move_name==standee.move.move_name:
				amt=x.apply_stack(amt)
	var took_damage = t.take_damage(amt,damage_type,standee.move)
	if took_damage:
		BattleManager.send_message.emit(t.name+" took "+str(amt)+" damage from "+standee.move.move_name)
	
	
