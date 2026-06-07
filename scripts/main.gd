extends Node3D

var score := 0
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

func spawn_targets():

	var spawn_points = $Targets/SpawnPoints.get_children()

	for spawn in spawn_points:

		var target = target_scene.instantiate()

		target.position = spawn.position

		$Targets.add_child(target)
