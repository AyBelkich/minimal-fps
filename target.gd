extends MeshInstance3D

var health := 3

func take_damage(amount: int):
	health -= amount
	print("Health:", health)

	if health == 2:
		material_override.albedo_color = Color.YELLOW

	if health == 1:
		material_override.albedo_color = Color.ORANGE

	if health <= 0:
		queue_free()
