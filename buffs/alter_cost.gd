class_name AlterCostBuff extends TimedBuff

@export var new_cost:Dictionary[Move.ENERGIES,int]
@export var random_cost:int
@export var _move:Move
@export var own_move:bool
var move_copy:Move

func apply(c:Character,m:Move):
	super(c,m)
	for x in _owner.battle_moves:
		if x.move_name==_move.move_name:
			move_copy=x
			if random_cost>0:
				x.random_energy=random_cost
				x.unrandom_energy=new_cost
				x.randomize_cost()
			else:
				x.cost=new_cost
				
func remove():
	move_copy.cost = _move.cost
	move_copy.unrandom_energy = _move.unrandom_energy
	move_copy.random_energy = _move.random_energy
	super()
