class_name ExchangeWindow extends Control
@onready var green: TextureButton = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer/Green
@onready var yellow: TextureButton = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer/Yellow
@onready var blue: TextureButton = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer/Blue
@onready var purple: TextureButton = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer/Purple

@onready var green_have: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer2/GreenHave
@onready var green_used: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer2/GreenUsed

@onready var yellow_have: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer3/YellowHave
@onready var yellow_used: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer3/YellowUsed

@onready var blue_have: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer4/BlueHave
@onready var blue_used: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer4/BlueUsed

@onready var purple_have: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer5/PurpleHave
@onready var purple_used: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer5/PurpleUsed

var button_group:ButtonGroup

var energy_selects=[]
var haves = []
var usedes = []

var active:bool

func _ready():
	haves = [green_have,yellow_have,blue_have,purple_have]
	usedes = [green_used, yellow_used,blue_used,purple_used]
	button_group=ButtonGroup.new()
	green.button_group=button_group
	yellow.button_group=button_group
	blue.button_group=button_group
	purple.button_group=button_group
	
func populate_energy():
	for x in haves:
		x.text=str(EnergyManager.energies[haves.find(x)])
	for x in usedes:
		x.text=str(0)

func _on_cancel_pressed() -> void:
	visible=false


func _on_visibility_changed() -> void:
	if visible:
		populate_energy()
	active=true

func _on_green_take_pressed() -> void:
	if int(green_used.text)>0:
		green_have.text = str(int(green_have.text)+1)
		green_used.text = str(int(green_used.text)-1)

func _on_green_give_pressed() -> void:
	if int(green_have.text)>0 and check_amount()<3:
		green_used.text = str(int(green_used.text)+1)
		green_have.text = str(int(green_have.text)-1)



func _on_yellow_take_pressed() -> void:
	if int(yellow_used.text)>0:
		yellow_have.text = str(int(yellow_have.text)+1)
		yellow_used.text = str(int(yellow_used.text)-1)


func _on_yellow_give_pressed() -> void:
	if int(yellow_have.text)>0 and check_amount()<3:
		yellow_used.text = str(int(yellow_used.text)+1)
		yellow_have.text = str(int(yellow_have.text)-1)

func _on_blue_take_pressed() -> void:
	if int(blue_used.text)>0:
		blue_have.text = str(int(blue_have.text)+1)
		blue_used.text = str(int(blue_used.text)-1)


func _on_blue_give_pressed() -> void:
	if int(blue_have.text)>0 and check_amount()<3:
		blue_used.text = str(int(blue_used.text)+1)
		blue_have.text = str(int(blue_have.text)-1)

func _on_purple_take_pressed() -> void:
	if int(purple_used.text)>0:
		purple_have.text = str(int(purple_have.text)+1)
		purple_used.text = str(int(purple_used.text)-1)

func _on_purple_give_pressed() -> void:
	if int(purple_have.text)>0 and check_amount()<3:
		purple_used.text = str(int(purple_used.text)+1)
		purple_have.text = str(int(purple_have.text)-1)
		
func check_amount()->int:
	var total=0
	for x in [green_used,blue_used,yellow_used,purple_used]:
		total+=int(x.text)
	return total

func confirm()->bool:
	if check_amount()==3 and button_group.get_pressed_button()!=null:
		for x in usedes:
			EnergyManager.energies[usedes.find(x)]-=int(x.text)
		var selects = [green,yellow,blue,purple]
		EnergyManager.energies[selects.find(button_group.get_pressed_button())]+=1
		return true
	return false
			
			

func _on_confirm_pressed() -> void:
	if confirm():
		visible=false
	
