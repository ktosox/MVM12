extends KinematicBody

signal enemyDies

onready var restLocation = translation

var target

export var moveSpeed = 2.0
export var turningSpeed = 30.0

var direction = Vector3(0,0,0)

var currentState = "idle"

var damageMultipliers = {}
var healthPoints= 1
var damagePower = 1
var damageType  = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func calculateDamage (amount, type):
	var multiplier = damageMultipliers.get(type)
	if multiplier == null:
		return amount
	return ceil (amount * multiplier)

func canAttack (body):
	if body == null: return false # Just in case
	if body.has_method ("damage"):
		return true
	return false

func _physics_process(delta):
	direction = Vector3(0,0,0)
	match currentState :
		"idle", "dead" :
			pass
		"return" :
			direction =  restLocation - translation
			if direction.length() < 1 :
				currentState = "idle"
				$AnimatedSprite3D.animation = "idle"
			pass
		"attack" :
			direction =  target.translation - translation
			var new_y_rotation = rad2deg (atan2(direction.x, direction.z))
			if new_y_rotation > rotation_degrees.y+turningSpeed*delta:
				rotation_degrees.y += turningSpeed*delta
			elif new_y_rotation < rotation_degrees.y-delta*turningSpeed:
				rotation_degrees.y -= turningSpeed*delta
			else:
				rotation_degrees.y = new_y_rotation
			
			for body in $AttackRange.get_overlapping_bodies():
				if canAttack (body):
					body.damage (damagePower, damageType)
	direction = direction.normalized()
	move_and_slide(direction * moveSpeed)
	
	pass


func damage(power,type=0):
	print(name, " got hit with an attack, power: ",power," and type: ",type)
	healthPoints -= calculateDamage(power, type)
	if healthPoints < 0:
		die ()


func die ():
	currentState = "dead"
	$AnimatedSprite3D.animation = "die"
	$DeathTimer.start ()
	emit_signal ("enemyDies")


func _on_DeathTimer_timeout():
	$AnimatedSprite3D.hide ()
	$CollisionShape.disabled = true
	$DetectionRange/CollisionShape.disabled = true


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
