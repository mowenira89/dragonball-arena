extends Node

signal start_turn
signal start_cooldown
signal stun
signal unstun
signal death
signal gameover
signal end_battle
signal swap_skills

var player_turn:bool=true

var queue:Array[AttackStandee]=[]

func execute_turn():
	if player_turn:
		for x in TargettingManager.friendlies:
			for y in x.buffs:
				y.on_start_turn()
	queue=TargettingManager.attack_queue
	for x in queue:
		x.move.use_move(x)
		TargettingManager.remove_active_moves.emit(x.move)
		await get_tree().create_timer(.5).timeout
	queue.clear()
	if player_turn==false:
		for x in TargettingManager.opponents:
			for y in x.buffs:
				y.on_end_turn()
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
		
