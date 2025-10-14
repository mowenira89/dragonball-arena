class_name DamagePerTurn extends TimedBuff

@export var amount:int
@export var damage_type:Move.CLASSES

func on_start_turn():
	_owner.take_damage(amount,damage_type,move)
	
func get_message():
	var dmg_type=DamageEffect.DAMAGES.keys()[damage_type]
	return "Receiving {1} {0} damage per turn for {2} turns.".format([amount,dmg_type,turns])	

func stack():
	amount+=10
