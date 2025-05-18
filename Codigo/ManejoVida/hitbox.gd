class_name HitBox
extends Area2D

@export var daño: int = 1 : set = set_daño, get = get_daño

func set_daño(valor: int):
	daño = valor
	
func  get_daño() -> int:
	return daño
