class_name CounterEighter extends Counter


func attacked(standee:AttackStandee):
	standee.user.take_damage(15,0,move)
	TargettingManager.attach_active_buff.emit(standee.user,self)
	remove()
	return false
