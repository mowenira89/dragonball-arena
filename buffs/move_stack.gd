class_name MoveStack extends Buff

var _stack:int
@export var affected_move:Move
@export var amount:int
@export var permanent:bool

func apply_stack(amt:int):
	if !permanent:
		remove()
	return amt+(amount*_stack)

func stack():
	_stack+=1

func message():
	return "Stack size: {0}".format([_stack])
