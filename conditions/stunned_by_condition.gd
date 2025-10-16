class_name StunnedByCondition extends Condition

@export var move_name:String

func check(standee:AttackStandee):
	if standee.target.buffs.any(func(b): b is Stun and b.move.move_name==move_name):
		return true
	return false
