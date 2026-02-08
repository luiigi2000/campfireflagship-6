extends MeshInstance3D




func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Object":
		Global.activate_button("SpawnDoor")


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Object":
		Global.activate_button("DespawnDoor")
