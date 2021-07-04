extends Panel


export var id = 0
export var type = "yes"
export var conditions = []
export var reactions = []


func _ready():
	$Layout/ID/Value.text = String(id)
	$Layout/Type/Value.text = type
	var conditionsText = ""
	for c in conditions :
		conditionsText = conditionsText + c.keys()[0]
		conditionsText = conditionsText + " "
	$Layout/Conditions/Value.text = conditionsText
	var reactionsText = ""
	for c in reactions :
		reactionsText = reactionsText + c.keys()[0]
		reactionsText = reactionsText + " "
	$Layout/Reactions/Value.text = reactionsText
	pass # Replace with function body.


