class_name CounterSeeThrough extends Counter

func on_skill_use(standee:AttackStandee):
	if standee.move.attack:
		_owner.take_damage(damage,damage_type,move)
		remove()
		return false
	
func stack():
	damage+=10
	
func get_altered(effect:Effect):
	damage+=15	
