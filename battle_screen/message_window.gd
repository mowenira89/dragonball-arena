class_name MessageWindow extends HBoxContainer
@onready var tag: VBoxContainer = $Tag
const MESSAGE = preload("res://battle_screen/message.tscn")
var messages = []


func _ready():
	BattleManager.send_message.connect(get_message)
	
func get_message(s:String):
	messages.append(s)
	display_messages()
	
func display_messages():
	var new_message = MESSAGE.instantiate()
	tag.add_child(new_message)
	new_message.create(messages[0])
	messages.pop_at(0)
