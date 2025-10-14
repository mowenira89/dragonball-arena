class_name CharacterSelector extends TextureButton

var character:Character

signal char_selected

func create_selector(char:Character):
	character=char
	texture_normal=char.pic


func _on_pressed() -> void:
	char_selected.emit(character)
