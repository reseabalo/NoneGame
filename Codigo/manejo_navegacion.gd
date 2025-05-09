extends Node

const escena_comedor = preload("res://escenas/comedor.tscn")
const escena_pasillo = preload("res://escenas/pasillo.tscn")
const escena_pasillo_2 = preload("res://escenas/pasillo_2.tscn")
const escena_aula = preload("res://escenas/aula.tscn")

var etiqueta_puerta_spawn 

signal on_trigger_player_spawn

func ir_a_nivel(etiqueta_nivel, etiqueta_destinacion):
	var escena_a_cargar
	
	match etiqueta_nivel:
		"comedor":
			escena_a_cargar = escena_comedor
		"pasillo":
			escena_a_cargar = escena_pasillo
		"pasillo 2":
			escena_a_cargar = escena_pasillo_2
		"aula":
			escena_a_cargar = escena_aula	
	if escena_a_cargar != null:
		etiqueta_puerta_spawn = etiqueta_destinacion
		get_tree().change_scene_to_packed.bind(escena_a_cargar).call_deferred()
		
func trigger_player_spawn(posicion: Vector2, direccion: String):
	on_trigger_player_spawn.emit(posicion,direccion)
