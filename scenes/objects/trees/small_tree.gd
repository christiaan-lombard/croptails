extends Sprite2D

@onready var damage_component: DamageComponent = $DamageComponent
@onready var hurt_component: HurtComponent = $HurtComponent

var log_scene = preload("res://scenes/objects/collectables/log.tscn")

func _ready() -> void:
	damage_component.max_damage_reached.connect(on_max_damage_reached)
	hurt_component.hurt.connect(on_hurt)
	
	
func on_max_damage_reached() -> void:
	print("max damage reached")
	call_deferred("spawn_log")
	queue_free()
	
func on_hurt(damage: int) -> void:
	damage_component.apply_damage(damage)
	material.set_shader_parameter("shake_intensity", 0.8)
	await get_tree().create_timer(1.0).timeout
	material.set_shader_parameter("shake_intensity", 0.0)

func spawn_log() -> void:
	var instance = log_scene.instantiate() as Node2D
	instance.global_position = global_position
	get_parent().add_child(instance)
