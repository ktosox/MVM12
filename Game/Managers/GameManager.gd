extends Node

var playerScene = preload("res://Actors/Player/Player.tscn")


var currentLevel:Spatial

var currentCheckpoint:Spatial

var currentPlayer:Spatial

# Role : Manage loading scenes on a global level


func _ready():
	pass # Replace with function body.

func update_checkpoint(checkpoint):
	currentCheckpoint = checkpoint
	pass

func player_died():
	if ! is_instance_valid(currentPlayer):
		print("player node was not desginated")
	else :
		reload_current_level()
	pass

func spawn_new_player():
	if ! is_instance_valid(currentCheckpoint):
		print("cant respawn player as checkpoint does not exist")
		return
	if is_instance_valid(currentPlayer) :
		currentPlayer.queue_free()
	var newPlayer = playerScene.instance()
	newPlayer.translation = currentCheckpoint.translation
	currentLevel.add_child(newPlayer)
	
		
	pass

func reload_current_level():
	#once levels are a thing here should go a
	spawn_new_player()
	pass
