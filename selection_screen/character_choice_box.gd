class_name CharacterChoiceBox extends TextureButton

var character:Character
signal send_box

func set_box(char:Character):
	if char==null:
		return
	character=char
	texture_normal=char.pic
	modulate="#FFFFFFFF"
	
func reset_box():
	character=null
	modulate="#FFFFFF00"
	

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action("Click"):
		send_box.emit(self)
	elif event.is_action("Right Click"):
		reset_box()
