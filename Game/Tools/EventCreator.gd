extends HBoxContainer


var eventDirectory = "res://Resources/Events/"

var eventFile

var eventBoxScene = preload("res://Tools/EventBox.tscn")
# a utility scene that presents event: id, type, conditions and reactions
# in a nice visual form

var flagScene = preload("res://Tools/Flag.tscn")
# a toggable scene that represents the state of a given flag variable

var loadedFlags = {}

var file = File.new()

var selectedEvent

# Called when the node enters the scene tree for the first time.
func _ready():
	reload_file_list()
	pass # Replace with function body.

func reload_event_list():
	$Selection/Events.clear()
	
	
	file.open(eventFile,file.READ)

	var text = file.get_as_text()
	
	var result = (parse_json(text))

	for e in result :
		$Selection/Events.add_item(e)
#	else:
#		var source = result[name] 
#		for n in source:
#			if (source[n].get("type") == type ) :
#				for z in source[n].get("conditions"):
#
#					if eventState.get(z.keys()[0]) == bool(int(z.values()[0])):
#						for k in source[n].get("reactions") :
#							process_reaction(k)
#	pass

func load_event_details(eventName):
	for k in $Events/EventContainer/Layout.get_children():
		k.queue_free()
	file.open(eventFile,file.READ)

	var text = file.get_as_text()
	
	var result = (parse_json(text))
	
	var output = result[eventName]
	var keys = output.keys()
	for c in keys :
		var newEvent = eventBoxScene.instance()
		newEvent.id = c
		newEvent.type = output[c].get("type")
		newEvent.conditions = output[c].get("conditions")
		newEvent.reactions = output[c].get("reactions")
		$Events/EventContainer/Layout.add_child(newEvent)
		pass
	pass

func reload_file_list():
	$Selection/Files.clear()
	var dir = Directory.new()
	var error = dir.open(eventDirectory)
	if error != 0 :
		print("error while opening folder at directory: ",eventDirectory," - error code",error)
	else:
		dir.list_dir_begin()
		var filename = dir.get_next()
		while(filename!=""):
			if(!dir.current_is_dir()):
				if filename.find(".json") > 0 : 
					$Selection/Files.add_item(filename)
			filename = dir.get_next()
		pass

func reload_flags():
	loadedFlags.clear()
	for i in $Data/Input/Flags.get_children():
		i.queue_free()
	var text = file.get_as_text()
	
	var result = (parse_json(text))

	var events = result[selectedEvent]
	for n in events :
		for m in events[n]["conditions"]:
			if !loadedFlags.has(m.keys()[0]):
				add_flag(m.keys()[0])
	pass

func add_flag(flag):
	loadedFlags[flag]=false
	var newFlag = flagScene.instance()
	newFlag.text = flag
	newFlag.connect("switch",self,"_on_Flag_switch")
	$Data/Input/Flags.add_child(newFlag)
	pass

func _on_Files_item_selected(index):
	eventFile = eventDirectory + $Selection/Files.get_item_text(index)
	reload_event_list()
	pass # Replace with function body.

func process_reactions(reactions):
	$Data/Output/TextBox.text=""
	for k in reactions:
		if k == "text" :
			$Data/Output/TextBox.text+=tr(reactions[k])
		elif k == "moveZ" :
			$Data/Output/TextBox.text+="Player has been moved "+String(int(reactions[k]))+" units in the Z axis"
#			GM.currentPlayer.translate(Vector3(0,0,int(reactions[k])))
		elif k == "moveX" :
			$Data/Output/TextBox.text+="Player has been moved "+String(int(reactions[k]))+" units in the X axis"
#			GM.currentPlayer.translate(Vector3(int(reactions[k]),0,0))
		elif k == "moveY" :
			$Data/Output/TextBox.text+="Player has been moved "+String(int(reactions[k]))+" units in the Y axis"
#			GM.currentPlayer.translate(Vector3(0,int(reactions[k]),0))
		elif k == "hide" :
			$Data/Output/TextBox.text+="An object has been hidden"
#			var level = GM.currentLevel
#			if level.has_method ("hideObject"):
#				if level.hideObject (reactions[k]):
#					eventState ["elemsHidden"][reactions[k]] = true
		elif k == "show" :
			$Data/Output/TextBox.text+="An object has been revealed"
#			var level = GM.currentLevel
#			if level.has_method ("showObject"):
#				if level.hideObject (reactions[k]):
#					eventState ["elemsHidden"][reactions[k]] = false
		elif k == "resetVisibility" :
			$Data/Output/TextBox.text+="An object's visibility has been reset"
#			var level = GM.currentLevel
#			if level.has_method ("resetObjectVisibility"):
#				eventState ["elemsHidden"][reactions[k]] = level.hideObject (reactions[k])
		for flag in $Data/Input/Flags.get_children():
			if flag.text == k:
				flag.pressed = bool(reactions[k])
#		elif eventState.get(k)!=null:
#			eventState [k] = bool(reactions[k])
	pass

func _on_Events_item_selected(index):
	load_event_details($Selection/Events.get_item_text(index))
	selectedEvent = $Selection/Events.get_item_text(index)
	reload_flags()
	pass # Replace with function body.

func _on_Action_pressed():
	for i in $Events/EventContainer/Layout.get_children():
		if i.type == "action":
			for n in i.get("reactions"):
				process_reactions(n)
#		process_reactions
	pass # Replace with function body.


func _on_Flag_switch(flag, state):
	loadedFlags[flag] = state

	pass # Replace with function body.


func _on_Enter_pressed():
	for i in $Events/EventContainer/Layout.get_children():
		if i.type == "enter":
			for n in i.get("reactions"):
				process_reactions(n)
	pass # Replace with function body.
