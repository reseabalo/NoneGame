class_name  Hurtbox
extends Area2D

signal  daño_recivido(daño: int)

@export var vida: Vida

func  _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox != null:
		vida.vida -= hitbox.daño
		daño_recivido.emit(hitbox.daño)
