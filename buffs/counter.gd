class_name Counter extends TimedBuff

@export var damage:int
@export var damage_type:DamageEffect.DAMAGES


func attacked(standee:AttackStandee):
	standee.user.take_damage(damage,damage_type,move)
	TargettingManager.attach_active_buff.emit(standee.user,self)
	remove()

func get_message():
	return "Countered by "+user.name+"!"
