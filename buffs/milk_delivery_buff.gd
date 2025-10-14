class_name MilkDeliveryBuff extends TimedBuff

func attacked(s:AttackStandee):
	remove()
	
func on_end_turn():
	if !permanent:
		turns-=1
		if turns+1==0:
			var new_move = load('res://moves/master_roshi/turtle_hermit_kamehameha.tres')
			BattleManager.swap_skills.emit(_owner,new_move)
			remove()
