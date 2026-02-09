extends MeshInstance3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	print(body.get_groups())
	if body.is_in_group("Objects"):
		set_meta("Pressed", true)
		check_win_condition()


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Objects"):
		set_meta("Pressed",false) 
		check_win_condition()
		
func check_win_condition():
	var conditions_met = true
	for child in get_tree().get_nodes_in_group("WinConditionButtons"):
		if not child.get_meta("Pressed"):
			conditions_met = false
			break
	if conditions_met:
		Global.activate_button("SpawnDoor")
	else:
		Global.activate_button("DespawnDoor")
