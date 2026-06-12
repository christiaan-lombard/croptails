class_name InteractableComponent
extends Area2D

signal interact_activated
signal interact_deactivated



func _on_body_entered(body: Node2D) -> void:
	interact_activated.emit()


func _on_body_exited(body: Node2D) -> void:
	interact_deactivated.emit()
