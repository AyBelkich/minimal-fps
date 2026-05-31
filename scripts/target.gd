extends Node3D

var health := 4

@onready var mesh: MeshInstance3D = $DummyTarget

func _ready():
	mesh.material_override = StandardMaterial3D.new()
	mesh.material_override.albedo_color = Color.GREEN
	
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
		queue_free()
