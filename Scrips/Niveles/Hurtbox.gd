extends Area2D
class_name  Hurtbox

signal  daño_recivido(daño: int)

@export var vida: Vida

func  _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(area: Area2D):
	if area is HitBox and area != null:
		vida.vida -= area.daño
		daño_recivido.emit(area.daño)
