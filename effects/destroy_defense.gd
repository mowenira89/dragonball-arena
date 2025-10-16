class_name DestroyDefense extends Effect

func apply(standee:AttackStandee,t:Character):
	
	for i in range(t.buffs.size()-1,-1,-1):
		if t.buffs[i] is Shield:
			t.buffs[i].remove()
