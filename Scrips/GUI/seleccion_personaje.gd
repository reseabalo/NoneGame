extends Node2D

var personaje_1: bool
var personaje_2: bool


func _on_maria_pressed() -> void:
	personaje_1 = true
	personaje_2 = false
	borrar_archivos_temporrales()
	ManejoEscenas.set_seleccionar_personaje(personaje_1,personaje_2)
	get_tree().change_scene_to_file("res://Escenas/Raiz/Juego.tscn")

func _on_jere_pressed() -> void:
	personaje_1 = false
	personaje_2 = true
	borrar_archivos_temporrales()
	ManejoEscenas.set_seleccionar_personaje(personaje_1,personaje_2)
	get_tree().change_scene_to_file("res://Escenas/Raiz/Juego.tscn")
	
func borrar_archivos_temporrales():
	var loop : bool = true
	var cont : int = 0
	var datos_temporales: String = "user://TemporalNivel" + str(cont) +".json"
	 
	while loop:
		if FileAccess.file_exists(datos_temporales):
			DirAccess.remove_absolute(datos_temporales)
			cont += 1
			datos_temporales = "user://TemporalNivel" + str(cont) +".json"
		else:
			loop = false
		
	
