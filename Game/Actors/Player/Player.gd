extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GM.currentPlayer = self
	pass # Replace with function body.

func _physics_process(delta):
	var direction = get_input()
	move_and_collide(direction * 2 * delta)
	
		
	pass

func get_input():
	var dir = Vector2()
	dir.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	dir.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	dir = dir.normalized()
	return Vector3(dir.x,0,dir.y)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
