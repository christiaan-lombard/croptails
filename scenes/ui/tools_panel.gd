extends PanelContainer

@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_hoe: Button = $MarginContainer/HBoxContainer/ToolHoe
@onready var tool_water: Button = $MarginContainer/HBoxContainer/ToolWater
@onready var tool_corn: Button = $MarginContainer/HBoxContainer/ToolCorn
@onready var tool_tomato: Button = $MarginContainer/HBoxContainer/ToolTomato


func _ready() -> void:
	tool_axe.toggled.connect(_on_tool_axe_toggled)
	tool_hoe.toggled.connect(_on_tool_hoe_toggled)
	tool_water.toggled.connect(_on_tool_water_toggled)
	tool_corn.toggled.connect(_on_tool_corn_toggled)
	tool_tomato.toggled.connect(_on_tool_tomato_toggled)

func _on_tool_axe_toggled(on: bool) -> void:
	select_tool_or_none(DataTypes.Tools.Axe, on)

func _on_tool_hoe_toggled(on: bool) -> void:
	select_tool_or_none(DataTypes.Tools.Hoe, on)

func _on_tool_water_toggled(on: bool) -> void:
	select_tool_or_none(DataTypes.Tools.Water, on)

func _on_tool_corn_toggled(on: bool) -> void:
	select_tool_or_none(DataTypes.Tools.SeedCorn, on)

func _on_tool_tomato_toggled(on: bool) -> void:
	select_tool_or_none(DataTypes.Tools.SeedTomato, on)

func select_tool_or_none(tool: DataTypes.Tools, on: bool) -> void:
	if on:
		ToolManager.select_tool(tool)
	else:
		ToolManager.select_tool(DataTypes.Tools.None)
		
