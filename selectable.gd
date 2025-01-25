class_name Selectable
extends Node

@export var selection_area: Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if selection_area:
		selection_area.input_event.connect(_on_area_2d_input)
	SelectionManager.selectable_selected.connect(_on_selectable_selected)


func _on_area_2d_input(viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		print("card input event")
		get_viewport().set_input_as_handled()
		viewport.set_input_as_handled()
		SelectionManager.selectable_selected.emit(self)

func _select() -> void:
	pass

func _unselect() -> void:
	pass

func _on_selectable_selected(selectable: Selectable) -> void:
	pass
