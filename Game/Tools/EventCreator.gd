extends HBoxContainer


var eventDirectory = "res://Resources/Events/"

var eventFile

var eventBoxScene = preload("res://Tools/EventBox.tscn")

var file = File.new()

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
	for k in $Data/EventContainer/Layout.get_children():
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
		$Data/EventContainer/Layout.add_child(newEvent)
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


func _on_Files_item_selected(index):
	eventFile = eventDirectory + $Selection/Files.get_item_text(index)
	reload_event_list()
	pass # Replace with function body.


func _on_Events_item_selected(index):
	load_event_details($Selection/Events.get_item_text(index))
	pass # Replace with function body.
