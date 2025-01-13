class_name Selectable
extends Node

signal selected(selectable: Selectable)

@export var selection_area: Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if selection_area:
		selection_area.input_event.connect(_on_area_2d_input)

func _on_area_2d_input(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		selected.emit(self)

func _select() -> void:
	pass
