class_name Mark extends TimedBuff

@export var marked_move:Move

func get_message():
	return "Marked for {0} for {1} turns.".format([marked_move.move_name,str(turns+1)])
