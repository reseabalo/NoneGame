extends Node2D
class_name Nivel

@export var jugador: Jugador
@export var puertas: Array[Puerta]

var puerta_salida: String

#se encarga de ver si existe un nombre de puerta
func _ready() -> void:
	GUI.visibilidad = true
	if ManejoEscenas.nombre_puerta_salir != null:
		_on_nivel_spawn(ManejoEscenas.nombre_puerta_salir)

#si existe un nombre de puerta setea la posicion del personaje a la entrada de esta.
func _on_nivel_spawn(etiqueta_destinacion: String):
	#busca la puerta correcta por puede haber varias en un mismo nivel(escena)
	for puerta in puertas:
		if puerta.name == etiqueta_destinacion:
			ManejoEscenas.posicion_en_spawn(puerta.spawn.global_position, puerta.direccion_entrada)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("salir_opciones"):
		ManejoEscenas.jugador_posicion = jugador.global_position
		
