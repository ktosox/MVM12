extends Area


var playerIn = false

export(String) var EventName

# Called when the node enters the scene tree for the first time.
func _ready():
	if EventName.length() == 0 :
		print("error - event name cant be blank")
		self.queue_free()
	pass # Replace with function body.


func _input(event):
	if(playerIn):
		if(event.is_action_pressed("ui_accept")):
			EM.process_event(EventName,"action")
		pass

func _on_EventArea_body_entered(body):
	playerIn = true
	EM.process_event(EventName,"enter")
	pass # Replace with function body.


func _on_EventArea_body_exited(body):
	playerIn = false
	pass # Replace with function body.
