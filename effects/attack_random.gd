class_name AttackRandom extends Effect

@export var num_of_targets:int

func apply(standee:AttackStandee,t:Character):
	var target
	if standee.user in TargettingManager.opponents:
		target = TargettingManager.friendlies.pick_random()
	else:
		target = TargettingManager.opponenets.pick_random()

	for x in standee.move.effects:
		if x is not AttackRandom:
			x.apply(standee,target)
