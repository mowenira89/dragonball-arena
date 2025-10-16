class_name BattleSkillButton extends TextureButton

const SKILL_WINDOW = preload("res://battle_screen/skill_view_panel.tscn")
@onready var in_use: TextureRect = $InUse
@onready var cooldown: ColorRect = $Cooldown
@onready var cooldown_label: Label = $Cooldown/CooldownLabel
@onready var stunned: TextureRect = $Stunned

var move:Move
var character:Character

var active:bool=true

signal unselect
signal send_move_data
signal destroy_skill_view

var skill_view_holder:SkillViewPanel

func _ready():
	BattleManager.start_cooldown.connect(start_cooldown)

func create_button(m:Move,c:Character):
	move=m.duplicate()
	if move.random_energy>0:
		move.randomize_cost()
	move.character=c
	character=c
	character.battle_moves.append(move)
	texture_normal=m.pic
	
	
func start_cooldown(m:Move):
	if move==m:
		cooldown.visible=true
		cooldown_label.text=str(m.cooldown)
		
func stunned_move():
	stunned.visible=true
	
func unstun():
	stunned.visible=false
	
func change_cooldown(amt:int):
	if cooldown.visible==true:
		var cooldown_amt = int(cooldown_label.text)
		var new_amt = cooldown_amt-amt
		if new_amt==0:
			cooldown_label.visible=false
		else: 
			cooldown_label.text=str(new_amt)
		


func _on_mouse_entered() -> void:
	send_move_data.emit(move)

func _on_mouse_exited() -> void:
	destroy_skill_view.emit()

func _on_pressed() -> void:
	if active and EnergyManager.check(move):
		TargettingManager.current_move=move
		TargettingManager.currently_targetting=character
		TargettingManager.target(move)
		#TargettingManager.start_targetting.emit(character,move)
		TargettingManager.character_moved.emit()
		


func _on_in_use_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("Right Click"):
		in_use.visible=false
		unselect.emit(character)
		for x in move.cost:
			if x==4:
				EnergyManager.needed-=move.cost[x]
			else:
				EnergyManager.energies[x]+=move.cost[x]
		TargettingManager.remove_from_attack_queue(move)
		TargettingManager.remove_active_moves.emit(move)

	
	


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("Right Click"):
		unselect.emit(character)
