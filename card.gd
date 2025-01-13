class_name Card
extends Selectable

@onready var selected_indicator: Polygon2D = $SelectedIndicator
@onready var sprite_2d: Sprite2D = $Sprite2D

var stats: CardStats

func _ready() -> void:
	if !stats:
		stats = CardStats.random_card_stats()
	sprite_2d.texture = stats.texture()
	super()

func _select() -> void:
	print("Card selected! " + str(stats))
	selected_indicator.visible = !selected_indicator.visible
