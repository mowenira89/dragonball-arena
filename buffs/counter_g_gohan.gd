class_name CounterGGohan extends Counter

func on_skill_use(standee:AttackStandee):
	_owner.take_damage(15,0,move)
	remove()
	return false
