extends Node

	# FLAGS #

var playerHasPhone = false

var introductionComplete = false

var pathJSON = "res://Resources/Events/Events.json"

var dialogScene # this is what displays text to the player

var file = File.new()

func _ready():
#	process_event("TableWithPhone","action")
	pass


func process_event(name,type):
	# a protective part that prevents missing events
#	if not file.file_exists(pathJSON):
#		print("no file to load events")
#		return


	file.open(pathJSON,file.READ)

	var text = file.get_as_text()
	
	var result = (parse_json(text))

	if !result.has(name):
		print("event ",name," was not defined in the event list")
	else:
		var source = result[name] 
		for n in source:
			if (source[n].get("type") == type ) :
				for z in source[n].get("conditions"):

					if get(z.keys()[0]) == bool(int(z.values()[0])):
						for k in source[n].get("reactions") :
							process_reaction(k)

	#not yet implemented
#	match type:
#		"enter":
#			print("player eneterd area ",name)
#		"action":
#			print("player made action in area ",name)
	file.close()
	pass
	


func process_reaction(reactions):
	for k in reactions :
		if k == "text" :
			print_dialog(tr(reactions[k]))
		if k == "moveZ" :
			GM.currentPlayer.translate(Vector3(0,0,int(reactions[k])))
		if k == "moveX" :
			GM.currentPlayer.translate(Vector3(int(reactions[k]),0,0))
		if k == "moveY" :
			GM.currentPlayer.translate(Vector3(0,int(reactions[k]),0))
		elif get(k)!=null:
			set(k,bool(reactions[k]))


	pass
	
func print_dialog(text):
	#this is very unsafe and needs to check if dialogScene exists to avoid error
#	print(text)
	dialogScene.display(text)
	pass

func test_print(text):
	#body still missing
	dialogScene.display(text)
	pass

