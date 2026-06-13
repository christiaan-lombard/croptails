extends NodeState

@export var character: AnimalCharacter
@export var animated_sprite_2d: AnimatedSprite2D
@export var navigation_agent: NavigationAgent2D

var speed: float = 0.0
var cycle: int = 0
var num_cycles: int = 0

func _ready() -> void:
	navigation_agent.velocity_computed.connect(_on_safe_velocity_computed)
	navigation_agent.navigation_finished.connect(_on_navigation_finished)

func set_movement_target() -> void:
	await get_tree().physics_frame
	
	var target_position: Vector2 = NavigationServer2D.map_get_random_point(
		navigation_agent.get_navigation_map(),
		navigation_agent.navigation_layers,
		false
	)
	navigation_agent.target_position = target_position
	speed = randf_range(character.min_speed, character.max_speed)
	

func _on_process(_delta: float) -> void:
	pass

func _on_physics_process(_delta: float) -> void:
	if navigation_agent.is_navigation_finished():
		return
	
	var target_position: Vector2 = navigation_agent.get_next_path_position()
	var target_direction: Vector2 = character.global_position.direction_to(target_position)
	var velocity: Vector2 = target_direction * speed
	navigation_agent.velocity = velocity
	
func _on_navigation_finished() -> void:
	cycle += 1
	if (cycle < num_cycles):
		set_movement_target()

func _on_safe_velocity_computed(velocity: Vector2) -> void:
	character.velocity = velocity
	animated_sprite_2d.flip_h = character.velocity.x < 0
	character.move_and_slide()

func _on_next_transitions() -> void:
	if cycle >= num_cycles:
		transition.emit("Idle")


func _on_enter() -> void:
	navigation_agent.avoidance_enabled = true
	num_cycles = randi_range(
		character.min_walk_cycle,
		character.max_walk_cycle
	)
	cycle = 0
	animated_sprite_2d.play("walking")

	call_deferred("set_movement_target")


func _on_exit() -> void:
	character.velocity = Vector2.ZERO
	navigation_agent.avoidance_enabled = false
	navigation_agent.target_position = character.global_position
	animated_sprite_2d.stop()
