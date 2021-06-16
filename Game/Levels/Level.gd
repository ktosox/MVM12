extends Spatial

var previousLevel = null
var movableElements = {}
enum {DEFAULTSTATE_VISIBLE, DEFAULTSTATE_HIDDEN}

func _ready():
	if GM.currentLevel == null:
		GM.currentLevel = self
		movableElements = {
			Phone = [$Furniture/Phone, DEFAULTSTATE_VISIBLE]
		}
		resetAllVisibility(EM.eventState.get("elemsHidden"))

func beforeSceneExit():
	if previousLevel == null:
		GM.currentLevel = previousLevel

func hideObject(objectName):
	var element = movableElements.get(objectName)
	if element == null: return false
	element[0].hide()
	return true

func showObject(objectName):
	var element = movableElements.get(objectName)
	if element == null: return false
	element[0].show()
	return true

func resetObjectVisibility(objectName):
	var element = movableElements.get(objectName)
	if element == null: return null
	if element[1]==DEFAULTSTATE_HIDDEN:
		element[0].hide()
	if element[1]== DEFAULTSTATE_VISIBLE:
		element[0].show()
	return element[1]

func resetAllVisibility(differences):
	if differences == null:
		differences = {}
	for elementName in movableElements.keys():
		var hiddenByDefault = differences.get(elementName)
		if hiddenByDefault == null:
			# no requested value, but resetting anyway
			resetObjectVisibility(elementName)
		elif hiddenByDefault == true:
			hideObject(elementName)
		else:
			showObject(elementName)
