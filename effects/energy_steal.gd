class_name EnergySteal extends Effect

@export var amount:int
@export var color:Move.ENERGIES

func apply(standee,t:Character):
	var i = randi_range(0,3)
	EnergyManager.energies[i]+=1
