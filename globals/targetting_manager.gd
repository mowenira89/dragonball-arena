extends Node

signal start_targetting
signal untarget
signal target_selected
signal character_moved
signal attach_active_moves
signal remove_active_moves

signal attach_active_buff
signal remove_active_buff

signal reset_swappables
signal remove_in_use

var current_move:Move
var currently_targetting:Character

var friendlies:Array[Character]=[]
var opponents:Array[Character]=[]

var attack_queue:Array[AttackStandee]=[]

var first_index:int=-1
var temp:AttackStandee

const ACTIVE_MOVE = preload("res://battle_screen/active_move.tscn")


func swap(second_index:int):
	temp=attack_queue[first_index]
	attack_queue[first_index]=attack_queue[second_index]
	attack_queue[second_index]=temp
	
	
func set_first_index(i:int):
	first_index=i

func _ready():
	target_selected.connect(make_attack_standee)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Right Click"):
		untarget.emit()
		current_move=null
		currently_targetting=null
		

func make_attack_standee(target:Character):
	var standee = AttackStandee.new()
	standee.create_standee(current_move.character,target,current_move)
	attack_queue.append(standee)
	character_moved.emit()
	
	var attach_to = get_target(standee)
	if !standee.move.target==Move.TARGETS.Random:
		for x in attach_to:			
			var new_active_move = ACTIVE_MOVE.instantiate()
			attach_active_moves.emit(x,new_active_move)
			new_active_move.create()
	
func remove_from_attack_queue(move:Move):
	for x in attack_queue:
		if x.move==move:
			attack_queue.remove_at(attack_queue.find(x))
			
			
			
func target(move:Move):
	var potential_targets:Array[Character] = []
	var all:bool=false
	
	match move.target:
		Move.TARGETS.Self:
			potential_targets.append(move.character)
		Move.TARGETS.Opponent:
			if friendlies.has(move.character):
				potential_targets=opponents.duplicate()
			else:
				potential_targets=friendlies.duplicate()
		Move.TARGETS.AllOpponents:
			if friendlies.has(move.character):
				potential_targets=opponents.duplicate()
			else:
				potential_targets=friendlies.duplicate()
			all=true
		Move.TARGETS.Ally:
			if friendlies.has(move.character):
				potential_targets=friendlies.duplicate()
			else:
				potential_targets=opponents.duplicate()
			potential_targets.erase(move.character)
		Move.TARGETS.AllAllies:
			if friendlies.has(move.character):
				potential_targets=friendlies.duplicate()
			else:
				potential_targets=opponents.duplicate()
			potential_targets.erase(move.character)			
			all=true
		Move.TARGETS.Friendlies:
			if friendlies.has(move.character):
				potential_targets=friendlies.duplicate()
			else:
				potential_targets=opponents.duplicate()
			all=true
		Move.TARGETS.AnyAlly:
			if friendlies.has(move.character):
				potential_targets=friendlies.duplicate()
			else:
				potential_targets=opponents.duplicate()
		Move.TARGETS.Random:
			if friendlies.has(move.character):
				potential_targets=opponents
			else:
				potential_targets=friendlies
	start_targetting.emit(potential_targets,all)	
			
			

func get_target(standee:AttackStandee):

	if friendlies.has(standee.user):
		if standee.user.buffs.any(check_aoe) and standee.move.target==Move.TARGETS.Opponent:
			return opponents
		match standee.move.target:
			Move.TARGETS.Self:
				return [standee.target]
			Move.TARGETS.AllOpponents:
				return opponents
			Move.TARGETS.Ally:
				return [standee.target]
			Move.TARGETS.Friendlies:
				return friendlies
			Move.TARGETS.Opponent:
				return [standee.target]
			Move.TARGETS.AllAllies:
				var allies = friendlies
				for x in allies:
					if x==standee.user:
						allies.erase(x)
				return allies
			Move.TARGETS.Random:
				return [opponents.pick_random()]
			Move.TARGETS.AnyAlly:
				return friendlies
						
	elif opponents.has(standee.user):
		if standee.user.buffs.any(check_aoe) and standee.move.target==Move.TARGETS.Opponent:
			return friendlies
		match standee.move.target:
			Move.TARGETS.Self:
				return [standee.target]
			Move.TARGETS.AllOpponents:
				return friendlies
			Move.TARGETS.Ally:
				return [standee.target]
			Move.TARGETS.Friendlies:
				return opponents
			Move.TARGETS.Opponent:
				return [standee.target]
			Move.TARGETS.AllAllies:
				var allies = opponents
				for x in allies:
					if x==standee.user:
						allies.erase(x)
			Move.TARGETS.Random:
				return [friendlies.pick_random()]
			Move.TARGETS.AnyAlly:
				return opponents

func check_aoe(buff):
	if buff is AOE:
		return true
		
func buff_targetting(standee:AttackStandee,b:Buff):
	
	if friendlies.has(standee.user):
		if standee.user.buffs.any(check_aoe) and standee.move.target==Move.TARGETS.Opponent:
			return opponents
		match b.target:
			Move.TARGETS.Self:
				return [standee.user]
			Move.TARGETS.AllOpponents:
				return opponents
			Move.TARGETS.Ally:
				return [standee.target]
			Move.TARGETS.Friendlies:
				return friendlies
			Move.TARGETS.Opponent:
				return [standee.target]
			Move.TARGETS.AllAllies:
				var f = []
				f+=(friendlies)
				for x in f:
					if x==standee.user:
						f.erase(x)
				return f
			Move.TARGETS.AnyAlly:
				return friendlies
			Move.TARGETS.Random:
				return [opponents.pick_random()]
				
	elif opponents.has(standee.user):
		if standee.user.buffs.any(check_aoe) and standee.move.target==Move.TARGETS.Opponent:
			return friendlies
		match b.target:
			Move.TARGETS.Self:
				return [standee.user]
			Move.TARGETS.AllOpponents:
				return friendlies
			Move.TARGETS.Ally:
				return [standee.target]
			Move.TARGETS.Friendlies:
				return opponents
			Move.TARGETS.Opponent:
				return [standee.target]
			Move.TARGETS.AllAllies:
				var f = opponents
				for x in f:
					if x==standee.user:
						f.erase(x)
				return f
			Move.TARGETS.AnyAlly:
				return opponents
			Move.TARGETS.Random:
				return [friendlies.pick_random()]
				
func get_buff(stack_id:String,c:Character):
	for b in c.buffs:
		if stack_id==b.stack_id:
			return b

func get_initial_targets():
	pass
