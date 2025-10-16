class_name DamagePerTurn extends TimedBuff

@export var amount:int
@export var damage_type:Move.CLASSES

func on_start_turn():
	if user.check_stun(move.classes) and Move.CLASSES.Instant not in move.classes:
		return
	_owner.take_damage(amount,damage_type,move)
	
func get_message():
	var dmg_type=DamageEffect.DAMAGES.keys()[damage_type]
	return "Receiving {1} {0} damage per turn for {2} turns.".format([amount,dmg_type,turns])	

func stack():
	amount+=10
