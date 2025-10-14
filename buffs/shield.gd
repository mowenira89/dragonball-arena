class_name Shield extends TimedBuff

@export var shield_amount:int


func alter_incoming_damage(amount:int,m:Move,t):
	if move.classes.has(DamageEffect.DAMAGES.Affliction):
		return amount
	var current_shield=shield_amount
	shield_amount-=amount
	if shield_amount<=0:
		remove()
	return amount-current_shield
	
func get_message():
	return "{} points of destructible shield".format([shield_amount])
