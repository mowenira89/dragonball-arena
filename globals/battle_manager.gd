extends Node

signal start_turn
signal start_cooldown
signal stun
signal unstun
signal death
signal gameover
signal end_battle
signal swap_skills
signal send_message

var player_turn:bool=true

var queue:Array[AttackStandee]=[]

func execute_turn():
	print(TargettingManager.opponents)
	if player_turn:
		for x in TargettingManager.friendlies:
			for y in x.buffs:
				y.on_start_turn()
	queue=TargettingManager.attack_queue
	for x in queue:
		var strng = x.user.name+" is using "+x.move.move_name
		send_message.emit(strng)
		x.move.use_move(x)
		TargettingManager.remove_active_moves.emit(x.move)
		await get_tree().create_timer(.5).timeout
	queue.clear()
	if player_turn==false:
		for x in TargettingManager.opponents:
			for y in x.buffs:
				y.on_end_turn()
		player_turn=true
		start_turn.emit()
	else:
		for x in TargettingManager.friendlies:
			for y in x.buffs:
				y.on_end_turn()
		start_opponent_turn()
		

func start_opponent_turn():
	for x in TargettingManager.opponents:
		for y in x.buffs:
			y.on_start_turn()
	for x in TargettingManager.opponents:
		if x.current_hp>0:
			x.move_opponent()
	player_turn=false
	execute_turn()

func stun_check(c:Character):
	return c.buffs.any(func(b):return b is Stun)
	
func get_damage(s:AttackStandee):
	var r = 0
	for x in s.move.effects:
		if x is DamageEffect:
			if !x.conditions.is_empty():
				r+=x.amount
			else:
				if x.check_condition(s):
					r+=x.amount
			
	for y in s.user.buffs:
		if y is AlterOutgoingDamageBuff:
			r=y.alter_outgoing_damage(r,s.move,0)
	return r 
				
