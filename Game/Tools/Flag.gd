extends CheckButton


signal switch(flag,state)


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.




func _on_Flag_toggled(button_pressed):
	emit_signal("switch",text,button_pressed)

	pass # Replace with function body.
