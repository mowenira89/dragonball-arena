class_name ActiveBuffTooltip extends Control

@onready var skill_name: Label = $TextureRect/MarginContainer/VBoxContainer/HBoxContainer/SkillName
@onready var description: RichTextLabel = $TextureRect/MarginContainer/VBoxContainer/Description
@onready var time_left: Label = $TextureRect/MarginContainer/VBoxContainer/TimeLeft

var turns_remaining=0

func create_panel(move:Move,b:Buff):
	skill_name.text=move.move_name
	description.text = move.description
	time_left.text = b.get_message()
	
