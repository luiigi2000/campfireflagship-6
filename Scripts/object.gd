extends RigidBody3D


var is_carrying 
				
func _ready() -> void:
	set_meta("OrigForce", constant_force)
	set_meta("Carrying",false)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		var is_carrying = get_meta("Carryings")
		var orig_force = get_meta("OrigForce")
		if Input.is_key_pressed(KEY_F) and not is_carrying:
			set_meta("OrigForce", orig_force * Vector3(-1,-1,-1))
			constant_force *= Vector3(-1,-1,-1)
		elif Input.is_key_pressed(KEY_F) and is_carrying and not is_in_group("FlipDirectObj"):
			set_meta("OrigForce", orig_force * Vector3(-1,-1,-1))
			constant_force *= Vector3(-1,-1,-1)
			
func _physics_process(delta: float) -> void:
	var size = 3.5
	position = Vector3(clamp(position.x,-size,size),clamp(position.y,0,8),clamp(position.z,-size,size))

	
