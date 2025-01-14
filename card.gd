class_name Card
extends Selectable

@onready var selected_indicator: Polygon2D = $SelectedIndicator
@onready var sprite_2d: Sprite2D = $Sprite2D

var stats: CardStats
var selected: bool

func _ready() -> void:
	if !stats:
		stats = CardStats.random_card_stats()
	sprite_2d.texture = stats.texture()
	super()

func _toggle_select() -> void:
	if selected:
		_unselect()
	else:
		_select()

func _select() -> void:
	print("Card selected! " + str(stats))
	selected_indicator.visible = true
	selected = true

func _unselect() -> void:
	print("Card unselected! " + str(stats))
	selected_indicator.visible = false
	selected = false

func _on_signal_bus_selected(selectable: Selectable) -> void:
	if selectable == self:
		_toggle_select()
	else:
		_unselect()
