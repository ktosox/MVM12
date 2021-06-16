extends "res://Levels/Level.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	if GM.currentLevel == null:
		GM.currentLevel = self
		movableElements = {
			Phone = [$Furniture/Phone, DEFAULTSTATE_VISIBLE]
		}

