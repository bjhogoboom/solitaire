class_name Card
extends Node2D

@onready var selected_indicator: Polygon2D = $SelectedIndicator
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var selection_area: Area2D = $SelectableArea
@onready var collision_shape_2d: CollisionShape2D = $SelectableArea/CollisionShape2D

@export var stats: CardStats
var selected: bool
const CHILD_OFFSET = Vector2(0, 20)

func _ready() -> void:
	if !stats:
		stats = CardStats.random_card_stats()
	sprite_2d.texture = stats.texture()
	selection_area.input_event.connect(_on_area_2d_input)
	collision_shape_2d.debug_color = stats.debug_color()

func _toggle_select() -> void:
	if selected:
		_unselect()
	else:
		_select()

func _on_area_2d_input(viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		print("card input event")
		get_viewport().set_input_as_handled()
		viewport.set_input_as_handled()
		SelectionManager.card_selected.emit(self)

func _select() -> void:
	print("Card selected! " + str(stats))
	selected_indicator.visible = true
	selected = true

func _unselect() -> void:
	print("Card unselected! " + str(stats))
	selected_indicator.visible = false
	selected = false

func stackable(card: Card) -> bool:
	var can_stack = self.stats.stackable(card.stats)
	var str_can = ""
	if can_stack:
		str_can = " is "
	else:
		str_can = " is not "
	print(str(card) + str_can + "stackable on " + str(self))
	return self.stats.stackable(card.stats)

func resize_collision_shape() -> void:
	var shape = collision_shape_2d.shape
	shape.set_size(Vector2(shape.size.x, CHILD_OFFSET.y))
	collision_shape_2d.position = -CHILD_OFFSET*1.5

func _to_string():
	return str(stats)

func stack(card: Card) -> void:
	if stackable(card):
		card.reparent(self)
		card.position = Vector2.ZERO + CHILD_OFFSET
		resize_collision_shape()
