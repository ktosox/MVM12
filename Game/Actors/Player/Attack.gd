extends Spatial


export var attackPower = 2

export var attackType = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func strike():
	var hits = $AttackBox.get_overlapping_bodies()

	if hits.size() > 0 :
		for n in hits :
			if n.has_method("damage") :
				n.damage(attackPower,attackType)
			pass
		pass
	pass
