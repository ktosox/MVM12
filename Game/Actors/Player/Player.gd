extends KinematicBody

export var moveSpeed = 3.0

var direction = Vector2()
var previousDirection = "Down"
var attacking = false
var currentItem = ""

var damageMultipliers = {}
var healthPoints= 1
var damagePower = 1
var damageType  = 0

signal leavingLevel

func loadState(oldState):
	if oldState == null:
		return
	var playerState = oldState.get("playerState")
	if playerState == null:
		return
	self.translation = playerState ["pos"]
	previousDirection= playerState ["dir"]
	currentItem = playerState ["item"]
	EM.reset_game(oldState)

# Called when the node enters the scene tree for the first time.
func _ready():
	GM.currentPlayer = self
	var oldState = EM.eventState
	loadState(oldState)
	pass # Replace with function body.

func calculateDamage (amount, type):
	var multiplier = damageMultipliers.get(type)
	if multiplier == null:
		return amount
	return ceil (amount * multiplier)

func damage(power,type=0):
	print(name, " got hit with an attack, power: ",power," and type: ",type)
	healthPoints -= calculateDamage(power, type)
	if healthPoints < 0:
		GM.player_died()

func updateState():
	var playerState = {
		pos = self.translation,
		dir = previousDirection,
		item = currentItem
	}
	EM.eventState ["playerState"] = playerState
	return playerState

func _input(event):
	if event.is_action_pressed("ui_accept"):
		attacking = true
		$Attack.strike()
		$AnimationTimer.start()
	if event.is_action_pressed("ui_cancel"):
		updateState()
		emit_signal("leavingLevel")
		get_tree().change_scene("res://Menus/MainMenu.tscn")
	if event.is_action_pressed("ui_home"):
		loadState(EM.otherEventState)
	if event.is_action_pressed("ui_end"):
		updateState()
		EM.otherEventState = EM.eventState.duplicate(true)

func _physics_process(delta):
	 
	direction = get_input()
	if (direction.length() > 0):
		$Attack.rotation.y = atan2(direction.x,direction.y)
	move_and_collide(Vector3(direction.x,0,direction.y) * moveSpeed * delta)
	var animatedAction = "walk"
	var animateDirection = ""
	if (attacking):
		animatedAction = "attack"
	if direction.y > 0.7 :
		animateDirection = "Down"
	elif direction.y < -0.7 :
		animateDirection = "Up"
	elif direction.x > 0.7 :
		animateDirection = "Right"
	elif direction.x < -0.7:
		animateDirection = "Left"
	elif animatedAction == "attack":
		animateDirection = previousDirection
	else:
		animatedAction = "idle"
	if (animateDirection!=""):
		previousDirection = animateDirection
	else:
		animateDirection = previousDirection
	$AnimatedSprite3D.animation = animatedAction + animateDirection + currentItem
	pass

func get_input():
	var dir = Vector2()
	dir.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	dir.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	dir = dir.normalized()
	
	return dir
	pass


func _on_Timer_timeout():
	# Used to switch out of animations with a length
	attacking = false
