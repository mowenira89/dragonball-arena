extends Node

enum ENERGY {GREEN,YELLOW,BLUE,PURPLE,BLACK}

var energies = {}
var current_costs=[]
var needed=0

func _ready():
	BattleManager.start_turn.connect(_start_turn)
	energies = {
	ENERGY.GREEN:0,
	ENERGY.YELLOW:0,
	ENERGY.PURPLE:0,
	ENERGY.BLUE:0}

func _start_turn():
	for x in TargettingManager.friendlies:
		if x.current_hp>0:
			energies[randi_range(0,3)]+=1
		
func check(move:Move)->bool:
	var r = true
	var cost_amts = [0,0,0,0,0]
	for x in move.cost:
		if x == 5:
			pass
		else:
			cost_amts[x]+=move.cost[x]
	for x in 4:
		if energies[x]<cost_amts[x]:
			r=false
	if r==true:	
		current_costs=cost_amts
	return r
	
func deduct_energy():
	for x in 5:
		if x==4:
			needed+=current_costs[x]
		else:
			energies[x]-=current_costs[x]
	current_costs.clear()
	
