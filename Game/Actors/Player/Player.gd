extends KinematicBody

export var moveSpeed = 3.0

var direction = Vector2()
var previousDirection = "Down"

# Called when the node enters the scene tree for the first time.
func _ready():
	GM.currentPlayer = self
	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed("ui_accept"):
		$Attack.strike()

func _physics_process(delta):
	 
	direction = get_input()
	if (direction.length() > 0):
		$Attack.rotation.y = atan2(direction.x,direction.y)
	move_and_collide(Vector3(direction.x,0,direction.y) * moveSpeed * delta)
	if direction.length()>0:
		$AnimatedSprite3D.playing = true
	else :
		$AnimatedSprite3D.playing = false
	if direction.y > 0.7 :
		$AnimatedSprite3D.animation = "walkDown"
		previousDirection = "Down"
	elif direction.y < -0.7 :
		$AnimatedSprite3D.animation = "walkUp"
		previousDirection = "Up"
	elif direction.x > 0.7 :
		$AnimatedSprite3D.animation = "walkRight"
		previousDirection = "Right"
	elif direction.x < -0.7:
		$AnimatedSprite3D.animation = "walkLeft"
		previousDirection = "Left"
	else:
		$AnimatedSprite3D.animation = "idle" + previousDirection
	pass

func get_input():
	var dir = Vector2()
	dir.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	dir.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	dir = dir.normalized()
	
	return dir
	pass
