class_name MoveIcon extends TextureButton

signal send_move

var move:Move

func create_icon(m:Move):
	move=m
	texture_normal=move.pic


func _on_pressed() -> void:
	send_move.emit(move)
