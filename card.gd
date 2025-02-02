class_name Card
extends Node2D

enum Flip {FACE_UP, FACE_DOWN}

@onready var selected_indicator: Polygon2D = $SelectedIndicator
@onready var card_front_sprite: Sprite2D = $CardFront
@onready var card_back_sprite: Sprite2D = $CardBack
@onready var selection_area: Area2D = $SelectableArea
@onready var collision_shape_2d: CollisionShape2D = $SelectableArea/CollisionShape2D

@export var stats: CardStats
var selected: bool
var flip: Flip
const CHILD_OFFSET = Vector2(0, 20)

static func new_card(p_stats: CardStats = null, p_flip: Flip = Flip.FACE_UP) -> Card:
	var scene: PackedScene = load("res://card.tscn")
	var card = scene.instantiate()
	card.stats = p_stats
	card.flip = p_flip
	return card

func _ready() -> void:
	if !stats:
		stats = CardStats.random_card_stats()
	card_front_sprite.texture = stats.texture()
	selection_area.input_event.connect(_on_area_2d_input)
	collision_shape_2d.debug_color = stats.debug_color()

func _process(delta: float) -> void:
	if flip == Flip.FACE_UP:
		card_front_sprite.visible = true
		card_back_sprite.visible = false
	else:
		card_front_sprite.visible = false
		card_back_sprite.visible = true
	

func _toggle_select() -> void:
	if selected:
		_unselect()
	else:
		_select()

func _on_area_2d_input(viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		get_viewport().set_input_as_handled()
		viewport.set_input_as_handled()
		if flip == Flip.FACE_UP:
			SelectionManager.card_selected.emit(self)
		else:
			flip_over()
			
func flip_over():
	if flippable():
		flip = Flip.FACE_UP

func flippable():
	return get_children().is_empty()

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
	show_selection_indicators()
	selected = true

func _unselect() -> void:
	hide_selection_indicators()
	selected = false

func stackable(card: Card) -> bool:
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
		var parent = card.get_parent()
		if parent is Card:
			parent.use_childless_collision_shape()
		card.reparent_and_pop(self)
		card.enable()
		card.position = Vector2.ZERO + CHILD_OFFSET
		use_parent_collision_shape()

func reparent_and_pop(new_parent: Node) -> void:
	if get_parent() is AceStack || get_parent() is Deck || get_parent() is Rank:
		get_parent().pop()
	reparent(new_parent)
