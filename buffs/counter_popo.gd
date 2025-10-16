class_name CounterPopo extends Counter



func attacked(standee:AttackStandee):
	var new_buff = AlterOutgoingDamageBuff.new()
	new_buff.amount=BattleManager.get_damage(standee)
	new_buff.turns=1	
	user.add_buff(new_buff,standee.move,standee.user)
	TargettingManager.attach_active_buff.emit(standee.user,self)
	remove()
	return false
