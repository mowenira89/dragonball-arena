class_name EndTurnScreen extends Control

@onready var green_have: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer2/GreenHave
@onready var green_used: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer2/GreenUsed
@onready var yellow_have: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer3/YellowHave
@onready var yellow_used: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer3/YellowUsed
@onready var blue_have: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer4/BlueHave
@onready var blue_used: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer4/BlueUsed
@onready var purple_have: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer5/PurpleHave
@onready var purple_used: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer5/PurpleUsed
@onready var label: Label = $TextureRect/MarginContainer/VBoxContainer/Label
@onready var skill_order: HBoxContainer = $TextureRect/MarginContainer/SkillOrder

const SWAPPABLE = preload("res://battle_screen/swappable_skill.tscn")

var usedes = []
var haves = []

var paying = []

func _ready():
	haves = [green_have,yellow_have,blue_have,purple_have]
	usedes = [green_used, yellow_used,blue_used,purple_used]
	TargettingManager.reset_swappables.connect(set_swappables)

func set_screen():
	set_label()
	for x in 4:
		haves[x].text=str(EnergyManager.energies[x])
	for x in usedes:
		x.text="0"
	set_swappables()
	
func set_swappables():
	for x in skill_order.get_children():
		x.queue_free()
		TargettingManager.first_index=-1
	for x in TargettingManager.attack_queue:
		var new_swappable = SWAPPABLE.instantiate()
		skill_order.add_child(new_swappable)
		new_swappable.create(x.move,TargettingManager.attack_queue.find(x))
		
		
func set_label():
	label.text = "Select {0} Energy to Use".format([str(EnergyManager.needed)])

func _on_visibility_changed() -> void:
	if visible:
		set_screen()


func _on_cancel_pressed() -> void:
	visible=false


func _on_confirm_pressed() -> void:
	if EnergyManager.needed==0:
		visible=false
		BattleManager.execute_turn()
		
	
	

func pay_energy(amt:int,e:EnergyManager.ENERGY):
		if amt==-1:
			if int(usedes[e].text)>0:
				haves[e].text=str(int(haves[e].text)+1)
				usedes[e].text=str(int(usedes[e].text)-1) 
				EnergyManager.needed+=1
				set_label()
				EnergyManager.energies[e]+=1
		elif amt==1:
			if EnergyManager.needed>0 and int(haves[e].text)>0:
				haves[e].text=str(int(haves[e].text)-1)
				usedes[e].text=str(int(usedes[e].text)+1) 
				EnergyManager.needed-=1
				set_label()
				EnergyManager.energies[e]-=1

func _on_green_give_pressed() -> void:
	pay_energy(-1,0)

func _on_green_take_pressed() -> void:
	pay_energy(1,0)
		
func _on_yellow_give_pressed() -> void:
	pay_energy(-1,1)

func _on_yellow_take_pressed() -> void:
	pay_energy(1,1)

func _on_blue_give_pressed() -> void:
	pay_energy(-1,2)
		
func _on_blue_take_pressed() -> void:
	pay_energy(1,2)

func _on_purple_give_pressed() -> void:
	pay_energy(-1,3)

func _on_purple_take_pressed() -> void:
	pay_energy(1,3)
