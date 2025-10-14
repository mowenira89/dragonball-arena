class_name Stun extends TimedBuff

@export var classes:Array[Move.CLASSES]

func get_message():
	return "STUNNED for {0} turns!".format([turns+1])

func apply(c:Character,m:Move):
	super(c,m)
	BattleManager.stun.emit(c,self)
	
func remove():
	BattleManager.unstun.emit(_owner,self)
	super()
