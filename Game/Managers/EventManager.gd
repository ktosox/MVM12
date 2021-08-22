extends Node

	# FLAGS #

var defaultEventState = { # This is what the other two reset to
	playerHasPhone = false,
	introductionComplete = false,
	elemsHidden = {}
}

var otherEventState = defaultEventState.duplicate(true) # why is this here?
var eventState = defaultEventState.duplicate(true)

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

					if eventState.get(z.keys()[0]) == bool(int(z.values()[0])):
						for k in source[n].get("reactions") :
							process_reaction(k)

	file.close()
	pass
	


func process_reaction(reactions):
	for k in reactions :
		if k == "text" :
			print_dialog(tr(reactions[k]))
		elif k == "moveZ" :
			GM.currentPlayer.translate(Vector3(0,0,int(reactions[k])))
		elif k == "moveX" :
			GM.currentPlayer.translate(Vector3(int(reactions[k]),0,0))
		elif k == "moveY" :
			GM.currentPlayer.translate(Vector3(0,int(reactions[k]),0))
		elif k == "hide" :
			var level = GM.currentLevel
			if level.has_method ("hideObject"):
				if level.hideObject (reactions[k]):
					eventState ["elemsHidden"][reactions[k]] = true
		elif k == "show" :
			var level = GM.currentLevel
			if level.has_method ("showObject"):
				if level.hideObject (reactions[k]):
					eventState ["elemsHidden"][reactions[k]] = false
		elif k == "resetVisibility" :
			var level = GM.currentLevel
			if level.has_method ("resetObjectVisibility"):
				eventState ["elemsHidden"][reactions[k]] = level.hideObject (reactions[k])
		elif eventState.get(k)!=null: #this line checks if the event name matches an event flag
			eventState [k] = bool(reactions[k]) #if it does, the flag is updated accordingly


	pass

func reset_game(resetTo=null):
	if resetTo == null:
		resetTo = defaultEventState
	eventState = resetTo.duplicate(true)
	var currentLevel = GM.currentLevel
	if currentLevel != null:
		currentLevel.resetAllVisibility(resetTo["elemsHidden"])
	# else: print ("Could not reset the level, because there is no level!")
	
func print_dialog(text):
	#this is very unsafe and needs to check if dialogScene exists to avoid error
#	print(text)
	dialogScene.display(text)
	pass

func test_print(text):

	dialogScene.display(text)
	pass

