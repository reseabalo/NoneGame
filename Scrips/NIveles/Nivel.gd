extends Node2D
class_name  Nivel

@export var jugador: Jugador
@export var puertas: Array[Puerta]

var puerta_salida

func _ready() -> void:
	if ManejoEscenas.nombre_puerta_salir != null:
		_on_nivel_spawn(ManejoEscenas.nombre_puerta_salir)
		
		
func _on_nivel_spawn(etiqueta_destinacion: String):
	for puerta in puertas:
		if puerta.name == etiqueta_destinacion:
			ManejoEscenas.posicion_en_spawn(puerta.spawn.global_position, puerta.direccion_entrada)
