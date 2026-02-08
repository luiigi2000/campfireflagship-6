extends RigidBody3D


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_F):
			constant_force = constant_force * Vector3(-1,-1,-1)
