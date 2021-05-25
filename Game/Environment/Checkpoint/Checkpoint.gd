extends Area



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func player_enetered():
	GM.update_checkpoint(self)
	pass


func _on_Checkpoint_body_entered(body):
	player_enetered()
	pass # Replace with function body.
