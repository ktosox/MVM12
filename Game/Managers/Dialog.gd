extends CanvasLayer


var letterTime = 0.07

var baseTime = 2.0

func _ready():
	EM.dialogScene = self

func display(text:String):
	$Window/Layout/TextBox.visible = true
	$Window/Layout/TextBox.bbcode_text = "[center]"+text+"[/center]"
	$VisibleTimer.start(baseTime + letterTime*text.length())
	pass


func _on_VisibleTimer_timeout():
	$Window/Layout/TextBox.visible = false
	pass # Replace with function body.
