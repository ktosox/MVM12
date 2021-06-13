extends KinematicBody


onready var restLocation = translation

var target

export var moveSpeed = 2.0

var direction = Vector3(0,0,0)

var currentState = "idle"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	direction = Vector3(0,0,0)
	match currentState :
		"idle" :
			pass
		"return" :
			direction =  restLocation - translation
			if direction.length() < 1 :
				currentState = "idle"
				$AnimatedSprite3D.animation = "idle"
			pass
		"attack" :
			direction =  target.translation - translation
			pass
	direction = direction.normalized()
	move_and_collide(direction * moveSpeed * delta)
	
	pass


func damage(power,type=0):
	print("crabby got hit with an attack, power: ",power," and type: ",type)
	pass


func _on_DetectionRange_body_entered(body):
	target = body
	currentState = "attack"
	$AnimatedSprite3D.animation = "attack"
	pass # Replace with function body.


func _on_DetectionRange_body_exited(body):
	currentState = "return"
	$AnimatedSprite3D.animation = "walk"
	print(restLocation)
	pass # Replace with function body.
