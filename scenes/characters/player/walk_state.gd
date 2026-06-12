extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 50

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	
	var direction = GameInputEvents.movement_input()
	if direction == Vector2.ZERO:
		return;
	
	player.direction = direction
	player.velocity = player.direction * speed
	player.move_and_slide()
		
	match direction:
		Vector2.UP:
			animated_sprite_2d.play("walking_back")
		Vector2.DOWN:
			animated_sprite_2d.play("walking_front")
		Vector2.LEFT:
			animated_sprite_2d.play("walking_left")
		Vector2.RIGHT: 
			animated_sprite_2d.play("walking_right")

func _on_next_transitions() -> void:
	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
