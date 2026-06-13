extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var hit_component_collision_shape: CollisionShape2D

func _ready() -> void:
	hit_component_collision_shape.disabled = true
	hit_component_collision_shape.position = Vector2.ZERO

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	pass

func _on_next_transitions() -> void:
	if !animated_sprite_2d.is_playing():
		transition.emit("Idle")


func _on_enter() -> void:
	match player.direction:
		Vector2.UP:
			animated_sprite_2d.play("chopping_back")
			hit_component_collision_shape.position = Vector2(0,-13.0)
		Vector2.DOWN:
			animated_sprite_2d.play("chopping_front")
			hit_component_collision_shape.position = Vector2(0,5.0)
		Vector2.LEFT:
			animated_sprite_2d.play("chopping_left")
			hit_component_collision_shape.position = Vector2(-7.0,-3.0)
		Vector2.RIGHT:
			animated_sprite_2d.play("chopping_right")
			hit_component_collision_shape.position = Vector2(7.0,-3.0)
		_:
			animated_sprite_2d.play("chopping_front")
			hit_component_collision_shape.position = Vector2(0,5.0)
		
	hit_component_collision_shape.disabled = false

func _on_exit() -> void:
	hit_component_collision_shape.position = Vector2.ZERO
	hit_component_collision_shape.disabled = true
