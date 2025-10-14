class_name SkillViewPanel extends Control
@onready var skill_name: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer/SkillName
@onready var cost_box: HBoxContainer = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer/CostBox
@onready var description: RichTextLabel = $TextureRect/MarginContainer/VBoxContainer/Description
@onready var classes: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer2/Classes
@onready var cooldown: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer2/Cooldown

var buff:Buff

func create_panel(move:Move):
	skill_name.text=move.move_name
	for x in move.cost:
		for y in move.cost[x]:		
			var new_square = TextureRect.new()
			cost_box.add_child(new_square)
			var im = load("res://images/Energy/{0} energy.png".format([Move.ENERGIES.keys()[x].to_lower()]))
			new_square.texture=im
	
	var classes_string:String = "Classes: "
	for x in move.classes:
		classes_string+=Move.CLASSES.keys()[x]
		classes_string+=","
	classes_string=classes_string.left(classes_string.length()-1)
	classes.text = classes_string
	cooldown.text = "Cooldown: " + str(move.cooldown)
	description.text = move.description
