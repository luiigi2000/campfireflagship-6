extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var h_joint := $H_Joint
@onready var v_joint := $H_Joint/V_Joint
@export var mouse_sens := 0.15
@onready var ray_cast = $H_Joint/V_Joint/Camera3D/RayCast3D
var object_being_carried
var object_carried_original_force
var is_carrying = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not object_being_carried:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction = (h_joint.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED 
		velocity.z = direction.z * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	move_object()
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		h_joint.rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		v_joint.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		v_joint.rotation.x = clamp(v_joint.rotation.x,deg_to_rad(-60),deg_to_rad(60))
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			pick_up_object()
	
func pick_up_object():
	if is_instance_valid(object_being_carried):
		object_being_carried.constant_force = object_being_carried.get_meta("OrigForce")
		object_being_carried.set_meta("Carrying",false)
		object_being_carried = null
	elif ray_cast.is_colliding() and ray_cast.get_collider().is_in_group("Objects"):
		object_being_carried = ray_cast.get_collider()
		object_being_carried.set_meta("Carrying",true)
		object_carried_original_force = object_being_carried.constant_force
		object_being_carried.set_meta("OrigForce",object_carried_original_force)
		object_being_carried.constant_force = Vector3(0,0,0)
		
func move_object():
	if is_instance_valid(object_being_carried):
		var camera = $H_Joint/V_Joint/Camera3D
		object_being_carried.global_position = object_being_carried.global_position.move_toward(camera.global_position -camera.global_transform.basis.z * 2, .1)
		
	
