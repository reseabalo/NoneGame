extends Area2D

class_name Puerta

@export var etiqueta_nivel_destinar: String
@export var etiqueta_pueta_destinar: String
@export var salida_dirreccion = "arriba"

@onready var spawn = $spawn

func _on_body_entered(body: Node2D) -> void:
	if body is Jugador:
		ManejoNavegacion.ir_a_nivel(etiqueta_nivel_destinar, etiqueta_pueta_destinar)
