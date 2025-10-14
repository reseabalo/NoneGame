extends CharacterBody2D
class_name enemigo

func _cambiar_vida(diff: int):
	%Vida.set_vida(diff)

func _on_vida_enemigo_vida_cambio(_diff: int) -> void:
	ManejoEscenas.set_dato(%Vida.get_vida())
