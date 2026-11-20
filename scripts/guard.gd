
extends CharacterBody2D

signal player_spotted(player: Node2D)

@export var patrol_speed: float = 45.0
@export var patrol_distance: float = 100.0
@export var detection_distance: float = 90.0

var start_position: Vector2
var direction: int = 1
var player_detected: bool = false

func _ready() -> void:
	start_position = global_position
	add_to_group("guards")

func _physics_process(_delta: float) -> void:
	_patrol()
	_check_for_player()
	move_and_slide()
	queue_redraw()

func _patrol() -> void:
	velocity.x = patrol_speed * direction

	if global_position.x >= start_position.x + patrol_distance:
		direction = -1
	elif global_position.x <= start_position.x - patrol_distance:
		direction = 1

func _check_for_player() -> void:
	var player = get_tree().get_first_node_in_group("player")

	if player == null:
		return

	var distance = global_position.distance_to(player.global_position)
	var in_front = (player.global_position.x - global_position.x) * direction > 0

	if distance <= detection_distance and in_front:
		if not player_detected:
			player_detected = true
			player_spotted.emit(player)
	else:
		player_detected = false

func _draw() -> void:
	# Тело стражника
	draw_rect(Rect2(-8, -12, 16, 18), Color("#536d68"))
	# Голова
	draw_rect(Rect2(-6, -23, 12, 11), Color("#d4a477"))
	# Шлем
	draw_rect(Rect2(-8, -25, 16, 5), Color("#b9a477"))
	# Ноги
	draw_rect(Rect2(-7, 6, 5, 10), Color("#403b36"))
	draw_rect(Rect2(2, 6, 5, 10), Color("#403b36"))
	# Направление взгляда
	var eye_x = 3.0 if direction == 1 else -5.0
	draw_rect(Rect2(eye_x, -19, 2, 2), Color.BLACK)
