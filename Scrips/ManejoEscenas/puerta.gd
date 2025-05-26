extends Area2D

class_name Puerta

@export_enum ("ir_oscurecer","no_transicion") var tipo_transicion: String
@export var direccion_nivel: String
@export var nombre_puerta_destinar: String
@export var direccion_entrada: String = "arriba"

@onready var spawn: Marker2D = $Spawn

var jugador : Jugador

func _on_body_entered(body: Node2D) -> void:
	if body is Jugador:
		ManejoEscenas.ir_a_nivel(direccion_nivel,nombre_puerta_destinar,tipo_transicion)
		
	
