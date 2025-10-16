class_name CounterFang extends Counter

func attacked(standee:AttackStandee):
	var move = load("res://moves/spike/sucker_punch.tres")
	standee.user.take_damage(15,0,move)
	TargettingManager.attach_active_buff.emit(standee.user,self)
	remove()
	return false
