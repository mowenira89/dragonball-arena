class_name Message extends ColorRect

@onready var label: Label = $Label
@onready var timer: Timer = $Timer



func create(s:String):
	label.text=s
	timer.start(10)


func _on_timer_timeout() -> void:
	queue_free()
