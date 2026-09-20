extends Node2D
class_name VillageBuilding

enum Kind { HOUSE, STOREHOUSE, WORKSHOP }

var kind: Kind = Kind.HOUSE
var _sprite: Sprite2D

func setup(k: Kind, pos: Vector2) -> void:
	kind = k
	position = pos

func _ready() -> void:
	_sprite = Sprite2D.new()
	_sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	match kind:
		Kind.HOUSE:
			_sprite.texture = PixelArt.get_tex("house")
		Kind.STOREHOUSE:
			_sprite.texture = PixelArt.get_tex("storehouse")
		Kind.WORKSHOP:
			_sprite.texture = PixelArt.get_tex("workshop")
	add_child(_sprite)
