extends Area



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func player_entered():
	GM.update_checkpoint(self)
	$CheckpointSprite.animation = "active"
	pass


func _on_Checkpoint_body_entered(body):
	player_entered()
	pass # Replace with function body.
