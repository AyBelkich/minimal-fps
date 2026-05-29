extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.003

@onready var camera = $PlayerCamera

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	if event is InputEventMouseMotion:
		
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)

		camera.rotate_x(event.relative.y * MOUSE_SENSITIVITY)
		
		camera.rotation.x = clamp(
			camera.rotation.x,
			deg_to_rad(-80),
			deg_to_rad(80)
		)
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			shoot()

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Vector2.ZERO

	if Input.is_key_pressed(KEY_Z):
		input_dir.y += 1
	if Input.is_key_pressed(KEY_S):
		input_dir.y -= 1
	if Input.is_key_pressed(KEY_Q):
		input_dir.x += 1
	if Input.is_key_pressed(KEY_D):
		input_dir.x -= 1

	var direction := (
		transform.basis *
		Vector3(input_dir.x, 0, input_dir.y)
	).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func shoot():

	$PlayerCamera/Weapon.position.z += 0.1

	var space_state = get_world_3d().direct_space_state

	var start = camera.global_position

	var end = start + (-camera.global_transform.basis.z * 100)

	var query = PhysicsRayQueryParameters3D.create(start, end)

	var result = space_state.intersect_ray(query)

	if result:
		var target = result.collider.get_parent()

		if target.has_method("take_damage"):
			target.take_damage(1)

	await get_tree().create_timer(0.05).timeout

	$PlayerCamera/Weapon.position.z -= 0.1
