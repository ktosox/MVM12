extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayButton_pressed():
	EM.reset_game()
	get_tree().change_scene("res://Levels/Introduction/Introduction.tscn")


func _on_LanguageButton_pressed(): # Change to the actual scene once it exists
	get_tree().change_scene("res://Menus/LanguageMenu.tscn")
