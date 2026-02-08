extends Node

enum levels {LEVEL1, LEVEL2}
var state = levels.LEVEL1
var level_selected


func _ready() -> void:
	change_level()

func change_level():
	if is_instance_valid(level_selected):
		level_selected.queue_free()
	if state == levels.LEVEL1:
		level_selected = preload("res://Scenes/Levels/level_1.tscn").instantiate()
	elif state == levels.LEVEL2:
		level_selected = preload("res://Scenes/Levels/level_2.tscn").instantiate()
	add_child(level_selected)
	state+=1
	
func activate_button(activation):
	if is_instance_valid(level_selected.get_node("Door")):
		var door = level_selected.get_node("Door")
		if activation == "SpawnDoor":
			level_selected.get_node("Door").visible = true
		elif activation == "DespawnDoor":
			level_selected.get_node("Door").visible = false
		
