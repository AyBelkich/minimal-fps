extends Node3D

var score := 0
var target_id := 0
var target_goal := 4

@onready var score_label: Label = $UI/ScoreLabel
@onready var win_label: Label = $UI/WinLabel
@export var target_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_targets()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func add_score(amount: int):
	score += amount
	score_label.text = "Score: " + str(score)

	if score >= target_goal:
		win_label.visible = true

func spawn_target_at(spawn_point: Node3D) -> void:
	var target = target_scene.instantiate()

	target.id = target_id
	target_id += 1

	spawn_point.add_child(target)

	target.position = Vector3.ZERO
	target.target_died.connect(on_target_died)

func spawn_targets() -> void:
	var spawn_points = $Targets/SpawnPoints.get_children()

	for spawn_point in spawn_points:
		spawn_target_at(spawn_point)

func respawn_target():
	await get_tree().create_timer(2.0).timeout

	var spawn_points = $Targets/SpawnPoints.get_children()
	var empty_spawn_points = []
	
	for spawn_point in spawn_points:
		if spawn_point.get_child_count() == 0:
			empty_spawn_points.append(spawn_point)

	if empty_spawn_points.is_empty():
		print("There are no empty spawn points!")
		return

	var random_spawn = empty_spawn_points.pick_random()
	spawn_target_at(random_spawn)

func on_target_died(dead_target_id: int) -> void:
	print("target %s died" % dead_target_id)
	respawn_target()
