extends KinematicBody

export var moveSpeed = 3.0

var direction = Vector2()
var previousDirection = "Down"
var attacking = false
var currentItem = ""


func loadState(oldState):
	if oldState == null:
		return
	var playerState = oldState.get("playerState")
	if playerState == null:
		return
	self.translation = playerState ["pos"]
	previousDirection= playerState ["dir"]
	EM.eventState = oldState.duplicate()

# Called when the node enters the scene tree for the first time.
func _ready():
	GM.currentPlayer = self
	var oldState = EM.eventState
	loadState(oldState)
	pass # Replace with function body.

func updateState():
	var playerState = {
		pos = self.translation,
		dir = previousDirection
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
		get_tree().change_scene("res://Menus/MainMenu.tscn")
	if event.is_action_pressed("ui_home"):
		loadState(EM.otherEventState)
	if event.is_action_pressed("ui_end"):
		updateState()
		EM.otherEventState = EM.eventState.duplicate()

func _physics_process(delta):
	 
	direction = get_input()
	if (direction.length() > 0):
		$Attack.rotation.y = atan2(direction.x,direction.y)
	move_and_collide(Vector3(direction.x,0,direction.y) * moveSpeed * delta)
	var animatedAction = "walk"
	var animateDirection = ""
	if (attacking):
		animatedAction = "attack"
	#if direction.length()>0:
	#	$AnimatedSprite3D.playing = true
	#else :
	#	$AnimatedSprite3D.playing = false
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
