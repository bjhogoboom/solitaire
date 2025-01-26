class_name Card
extends Node2D

@onready var selected_indicator: Polygon2D = $SelectedIndicator
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var selection_area: Area2D = $SelectableArea
@onready var collision_shape_2d: CollisionShape2D = $SelectableArea/CollisionShape2D

@export var stats: CardStats
var selected: bool
const CHILD_OFFSET = Vector2(0, 20)

static func new_card(p_stats: CardStats = null) -> Card:
	var scene: PackedScene = load("res://card.tscn")
	var card = scene.instantiate()
	card.stats = p_stats
	return card

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
		
func show_selection_indicators() -> void:
	selected_indicator.visible = true
	for child in get_children():
			if child is Card:
				child.show_selection_indicators()
				
func hide_selection_indicators() -> void:
	selected_indicator.visible = false
	for child in get_children():
			if child is Card:
				child.hide_selection_indicators()

func _select() -> void:
	print("Card selected! " + str(stats))
	show_selection_indicators()
	selected = true

func _unselect() -> void:
	print("Card unselected! " + str(stats))
	hide_selection_indicators()
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

func use_parent_collision_shape() -> void:
	var shape = collision_shape_2d.shape
	shape.set_size(Vector2(shape.size.x, CHILD_OFFSET.y))
	collision_shape_2d.position = -CHILD_OFFSET*1.5

func use_childless_collision_shape() -> void:
	var shape = collision_shape_2d.shape
	shape.set_size(Vector2(shape.size.x, 82))
	collision_shape_2d.position = Vector2.ZERO
	
func disable() -> void:
	selection_area.input_pickable = false
	
func enable() -> void:
	selection_area.input_pickable = true

func _to_string():
	return str(stats)

func stack(card: Card) -> void:
	if stackable(card):
		var parent_card = card.get_parent()
		if parent_card is Card:
			parent_card.use_childless_collision_shape()
		card.reparent(self)
		card.position = Vector2.ZERO + CHILD_OFFSET
		use_parent_collision_shape()
