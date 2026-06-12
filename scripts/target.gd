extends Node3D

signal target_died(dead_target_id: int)

var id = 0
var health := 4
var move_direction := 1
var move_speed := 1.5

@onready var mesh: MeshInstance3D = $DummyTarget

func _ready():
	mesh.material_override = StandardMaterial3D.new()
	mesh.material_override.albedo_color = Color.GREEN

func _process(delta):

	position.x += move_direction * move_speed * delta

	if position.x > 2:
		move_direction = -1

	if position.x < -2:
		move_direction = 1

func take_damage(amount: int):
	health -= amount
	print("Health:", health)

	if health == 3:
		mesh.material_override.albedo_color = Color.YELLOW

	if health == 2:
		mesh.material_override.albedo_color = Color.ORANGE
	
	if health == 1:
		mesh.material_override.albedo_color = Color.RED

	if health <= 0:
		target_died.emit(id)
		get_tree().current_scene.add_score(1)
		queue_free()
