class_name MilkDeliveryBuff extends TimedBuff

@export var alter_cost_buff:AlterCostBuff

func attacked(s:AttackStandee):
	_owner.add_buff(alter_cost_buff,move,_owner)
	remove()
	
func on_end_turn():
	if !permanent:
		turns-=1
		if turns+1==0:
			var new_move = load('res://moves/master_roshi/turtle_hermit_kamehameha.tres').duplicate()
			BattleManager.swap_skills.emit(_owner,"Stone Throw",new_move)
			remove()
