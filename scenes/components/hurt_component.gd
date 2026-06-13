class_name HurtComponent
extends Area2D

@export var tool: DataTypes.Tools = DataTypes.Tools.None

signal hurt(damage: int)

func _on_area_entered(area: Area2D) -> void:
	if area is HitComponent:
		var hit_component = area as HitComponent
		if tool == hit_component.tool:
			hurt.emit(hit_component.damage)
	else:
		push_warning("HurtComponent collided with non-HitComponent area")
