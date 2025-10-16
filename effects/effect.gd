class_name Effect extends Resource

@export var friendly:bool
@export var harmful:bool

@export var conditions:Array[Condition]

func apply(standee:AttackStandee,t:Character):
	pass
	
func check_condition(standee:AttackStandee)->bool:
	var conditions_met = []
	for x in conditions:
		conditions_met.append(x.check(standee))
	for x in conditions_met:
		if x==false: return false
	return true
