class_name Invulnerable extends TimedBuff

func get_message():
	if permanent:
		return "Invulnerable"
	else:
		return "Invulnerable for {0}".format([turns])
