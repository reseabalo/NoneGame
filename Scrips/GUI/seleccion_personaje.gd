extends Node2D

var personaje_1: bool
var personaje_2: bool


func _on_maria_pressed() -> void:
	personaje_1 = true
	personaje_2 = false
	ManejoEscenas.set_seleccionar_personaje(personaje_1,personaje_2)
	get_tree().change_scene_to_file("res://Escenas/Raiz/Juego.tscn")

func _on_jere_pressed() -> void:
	personaje_1 = false
	personaje_2 = true
	ManejoEscenas.set_seleccionar_personaje(personaje_1,personaje_2)
	get_tree().change_scene_to_file("res://Escenas/Raiz/Juego.tscn")
