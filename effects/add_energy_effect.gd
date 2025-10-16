class_name AddEnergyEffect extends Effect

@export var specific:Dictionary[Move.ENERGIES,int]
@export var random:int

func apply(standee,t:Character):
	if !specific.is_empty():
		for x in specific:
			EnergyManager.energies[x]+=specific[x]
	if random>0:
		for x in random:
			var r = randi_range(0,3)
			EnergyManager.energies[r]+=1
