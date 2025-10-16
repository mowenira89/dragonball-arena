class_name AlterCooldown extends TimedBuff

@export var move_to_alter:Move
@export var delta:int

func apply(c:Character,m:Move):
	super(c,m)
	if move_to_alter:
		var move = c.get_move(move_to_alter.move_name)
		move.coldown+=delta
	else:
		for x in c.moves:
			x.cooldown+=delta
		
func remove():
	if move_to_alter:
		var move = _owner.get_move(move_to_alter.move_name)
		move.coldown-=delta
	else:
		for x in _owner.moves:
			x.cooldown-=delta
	super()
