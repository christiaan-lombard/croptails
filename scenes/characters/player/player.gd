class_name Player
extends CharacterBody2D

@onready var hit_component: HitComponent = $HitComponent

var direction: Vector2 = Vector2.DOWN
@export var tool: DataTypes.Tools = DataTypes.Tools.Axe

func _ready() -> void:
	ToolManager.tool_selected.connect(_on_tool_selected)
	
func _on_tool_selected(next_tool: DataTypes.Tools) -> void:
	tool = next_tool
	hit_component.tool = next_tool
	print("Tool selected", next_tool)
