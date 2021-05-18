extends Camera


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var movement = Vector3()
	movement.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	movement.z = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	translation += movement * delta * 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
