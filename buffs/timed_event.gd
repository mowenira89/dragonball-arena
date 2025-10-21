class_name TimedEvent extends TimedBuff

@export var event:Effect
var standee:AttackStandee

func apply(c,m):
	super(c,m)
	standee = AttackStandee.new()
	standee.create_standee(user,_owner,move)
	
func on_end_turn():
	turns-=1
	if turns+1<=0:
		var target = TargettingManager.get_target(standee)
		for x in target:
			event.apply(standee,x)
		remove()
