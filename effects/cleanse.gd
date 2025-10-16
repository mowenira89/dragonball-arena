class_name Cleanse extends Effect

func apply(standee,t:Character):
	for x in range(t.buffs.size()-1,-1,-1):
		if t.buffs[x].harmful:
			t.buffs[x].remove()
