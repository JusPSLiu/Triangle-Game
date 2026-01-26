extends Node

var prior_room = ""
var tvOn = true

var dict : Dictionary[String, bool]

func in_inventory(check : String):
	return dict.has(check) and dict[check]

func add_to_inventory(check : String):
	if (dict.has(check)):
		dict[check] = true
	else:
		dict.set(check, true)
