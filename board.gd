extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is Selectable:
			print("Found a selectable")
			child.selected.connect(_on_selectable_selected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_selectable_selected(selectable: Selectable) -> void:
	selectable._select()
