class_name AfterimageBuff extends TimedBuff

func apply(o,m):
	super(o,m)
	for x in _owner.moves:
		if x.move_name=="Chun Knee":
			x.cooldown+=1
func remove():
	for x in _owner.moves:
		if x.move_name=="Chun Knee":
			x.cooldown-=1
	super()

func alter_outgoing_damage(amt:int,m:Move,t):
	return amt-5

func get_message():
	return "Targetting all"
