class_name ChangeCost extends Effect

@export var amount:int=1
@export var change_type:EnergyManager.ENERGY
@export var randomize:bool
@export var own_move:bool
@export var other_move:Move


func apply(standee:AttackStandee,t:Character):
	var move:Move
	if own_move:
		move=standee.move
	else:
		for x in standee.user.moves:
			if x.move_name==other_move.move_name:
				move=x
	if randomize:
		var random = randi_range(0,3)
		if move.cost.has(random):
			move.cost[random]+=amount
		else:
			move.cost[random]=amount
	else:
		if move.cost.has(change_type):
			move.cost[change_type]+=amount
		else:
			move.cost[change_type]=amount
