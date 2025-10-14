class_name BattleScreen extends Control

@onready var skill_panel: SkillPanel = $TextureRect/MarginContainer/VBoxContainer/MarginContainer/PlayerCharacters/SkillPanel
@onready var skill_panel_2: SkillPanel = $TextureRect/MarginContainer/VBoxContainer/MarginContainer/PlayerCharacters/SkillPanel2
@onready var skill_panel_3: SkillPanel = $TextureRect/MarginContainer/VBoxContainer/MarginContainer/PlayerCharacters/SkillPanel3
@onready var opponent: Opponent = $TextureRect/MarginContainer/VBoxContainer/MarginContainer/Opponents/Opponent
@onready var opponent_2: Opponent = $TextureRect/MarginContainer/VBoxContainer/MarginContainer/Opponents/Opponent2
@onready var opponent_3: Opponent = $TextureRect/MarginContainer/VBoxContainer/MarginContainer/Opponents/Opponent3
@onready var green_amt: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Energies/HBoxContainer/GreenAmt
@onready var yellow_amt: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Energies/HBoxContainer/YellowAmt
@onready var blue_amt: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Energies/HBoxContainer/BlueAmt
@onready var purple_amt: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/Energies/HBoxContainer/PurpleAmt

@onready var exchange_window: ExchangeWindow = $ExchangeWindow
@onready var end_turn_box: EndTurnScreen = $EndTurnBox

var friendlies = [skill_panel,skill_panel_2,skill_panel_3]
var opponents = [opponent,opponent_2,opponent_3]
var combatants = friendlies+opponents

var energy_active:bool=false

func _ready():
	TargettingManager.start_targetting.connect(start_targetting)
	TargettingManager.untarget.connect(stop_targetting)
	friendlies = [skill_panel,skill_panel_2,skill_panel_3]
	opponents = [opponent,opponent_2,opponent_3]
	combatants = friendlies+opponents
	set_characters()
	set_opponents()		
	BattleManager.start_turn.connect(start_turn)
	BattleManager.end_battle.connect(end_battle)
	BattleManager.start_turn.emit()
		
func _process(delta: float) -> void:
	if energy_active:
		update_energy()
	
func update_energy():
	green_amt.text=str(EnergyManager.energies[0])
	yellow_amt.text=str(EnergyManager.energies[1])
	blue_amt.text=str(EnergyManager.energies[2])
	purple_amt.text=str(EnergyManager.energies[3])

func set_characters():
	skill_panel.create_panel(TargettingManager.friendlies[0])
	skill_panel_2.create_panel(TargettingManager.friendlies[1])
	skill_panel_3.create_panel(TargettingManager.friendlies[2])
	
func set_opponents():
	opponent.set_opponent(TargettingManager.opponents[0])
	opponent_2.set_opponent(TargettingManager.opponents[1])
	opponent_3.set_opponent(TargettingManager.opponents[2])
	
	

func start_targetting():
	var marked_targets=check_marked()
	var potential_targets=[]
	match TargettingManager.current_move.target:
		Move.TARGETS.Self:
			for x in friendlies:
				if x.character==TargettingManager.currently_targetting:
					potential_targets.append(x)
		Move.TARGETS.Opponent:
			potential_targets=opponents
		Move.TARGETS.AllOpponents:
			for x in opponents:
				x.target()
			return

	if TargettingManager.current_move.needs_mark:
		for x in potential_targets:
			if x in marked_targets:
				x.flash_pic()
	else:
		for x in potential_targets:
			x.flash_pic()
			
					
	
func check_marked():
	var targets=[]
	if !TargettingManager.current_move.needs_mark:
		return []
	else:
		for x in combatants:
			for y in x.character.buffs:
				if y is Mark and y.marked_move.move_name==TargettingManager.current_move.move_name:
					targets.append(x)
		return targets
					
func stop_targetting():
	for x in combatants:
		x.untarget()
	TargettingManager.current_move=null
	
func start_turn():
	energy_active=true


func _on_exchange_energy_button_pressed() -> void:
	exchange_window.visible = !exchange_window.visible

func end_battle():
	EnergyManager.energies = {
	EnergyManager.ENERGY.GREEN:0,
	EnergyManager.ENERGY.YELLOW:0,
	EnergyManager.ENERGY.PURPLE:0,
	EnergyManager.ENERGY.BLUE:0}
	BattleManager.queue.clear()
	TargettingManager.attack_queue.clear()
	queue_free()

func _on_surrender_pressed() -> void:
	BattleManager.gameover.emit("Lose")
	


func _on_end_turn_button_2_pressed() -> void:
	end_turn_box.visible=true
