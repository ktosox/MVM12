extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func damage(power,type=0):
	print("dummy got hit with an attack, power: ",power," and type: ",type)
	pass
