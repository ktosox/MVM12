extends Area



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func player_enetered():
	print("player enetered checkpoint ",self)
	#this should activate the relevant method in the singleton that tracks current active checkpoint
	pass


func _on_Checkpoint_body_entered(body):
	player_enetered()
	pass # Replace with function body.
