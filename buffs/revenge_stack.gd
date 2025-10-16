class_name RevengeStack extends MoveStack

@export var reset:bool

func apply_stack(amt:int):
	var stack_amount=_stack
	if reset: _stack=0
	if !permanent:
		remove()
	return amt+(amount*stack_amount)
	

func on_ally_death(c:Character):
	_stack+=1
