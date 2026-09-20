extends Node2D
class_name ResourceNode

enum Kind { WOOD, STONE, FOOD }

@export var kind: Kind = Kind.WOOD
@export var max_amount: int = 40

var amount: float = 40.0
var _regen_timer: float = 0.0
var _sprite: Sprite2D

func type_id() -> String:
	match kind:
		Kind.WOOD:
			return "wood"
		Kind.STONE:
			return "stone"
		Kind.FOOD:
			return "food"
	return "wood"

func is_depleted() -> bool:
	return amount < 1.0

func gather(request: int) -> int:
	if request <= 0 or amount < 1.0:
		return 0
	var take := mini(request, int(floor(amount)))
	amount -= take
	_update_visual()
	return take

func _ready() -> void:
	amount = float(max_amount)
	_sprite = Sprite2D.new()
	_sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	add_child(_sprite)
	match kind:
		Kind.WOOD:
			_sprite.texture = PixelArt.get_tex("tree")
		Kind.STONE:
			_sprite.texture = PixelArt.get_tex("stone")
		Kind.FOOD:
			_sprite.texture = PixelArt.get_tex("food")
	_update_visual()

func _process(delta: float) -> void:
	if amount < max_amount:
		_regen_timer += delta
		if _regen_timer >= 1.2:
			_regen_timer = 0.0
			amount = minf(amount + 1.0, float(max_amount))
			_update_visual()

func _update_visual() -> void:
	if _sprite == null:
		return
	var t := amount / float(max_amount)
	_sprite.modulate = Color(1, 1, 1, clampf(0.35 + t * 0.65, 0.35, 1.0))
	_sprite.scale = Vector2.ONE * (0.75 + t * 0.25)
