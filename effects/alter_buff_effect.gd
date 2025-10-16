class_name AlterBuffEffect extends Effect

@export var stack_id:String
@export var damage:int

func apply(standee:AttackStandee,t:Character):
	var r = TargettingManager.get_buff(stack_id,t)
	if r:
		r.get_altered(self)
