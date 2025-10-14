class_name TimedBuff extends Buff

@export var turns:int

@export_category("Removal Time")

@export var permanent:bool

func on_end_turn():
	if !permanent:
		turns-=1
		if turns+1==0:
			remove()
