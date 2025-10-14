class_name WinLose extends Control

@onready var win_lose_label: Label = $TextureRect/MarginContainer/VBoxContainer/WinLoseLabel
@onready var exp_label: Label = $TextureRect/MarginContainer/VBoxContainer/ExpLabel
@onready var pic: TextureRect = $TextureRect/MarginContainer/VBoxContainer/Pic


func _ready():
	BattleManager.gameover.connect(gameover)
	visible=false
	
const LOSE_1 = "uid://dlab84s5mhtwp"
const LOSE_2 = "uid://cywswwu8os1nl"
const WIN_1 = "uid://dma4nvgd3vwdj"
const WIN_2 = "uid://drf3usvc5uf2d"
	
func gameover(c:String):
	visible=true
	var verb
	if c=="Win":
		pic.texture=load([WIN_1,WIN_2].pick_random())
		win_lose_label.text = "You've won!"
		verb="won"
	else:
		var p = [LOSE_1,LOSE_2].pick_random()
		pic.texture=load(p)
		win_lose_label.text = "You lose!"
		verb = "lost"
	win_lose_label.text="You've {0} x exp!\nYou've {0} your clan x exp!".format([verb])
	


func _on_return_button_pressed() -> void:
	BattleManager.end_battle.emit()
