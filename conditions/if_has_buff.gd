class_name HasBuffCondition extends Condition

@export var stack_id:String
@export var user:bool
@export var target:bool

func check(standee:AttackStandee):
	if user:
		return standee.user.buffs.any(func(b):b.stack_id==stack_id)
	elif target:
		return standee.target.buffs.any(func(b):b.stack_id==stack_id)
