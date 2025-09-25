extends Node

var master_bus
var sfx_bus
var musica_bus


func _ready() -> void:
	master_bus = AudioServer.get_bus_index("Master")
	musica_bus = AudioServer.get_bus_index("Musica")
	sfx_bus = AudioServer.get_bus_index("Sfx")


func set_master_volumen(valor = -1):
	if valor == -1:
			valor = GUI.get_master_volumen()
	AudioServer.set_bus_volume_db(master_bus, linear_to_db(valor))

func set_musica_volumen(valor = -1):
	if valor == -1:
		valor = GUI.get_musica_volumen()
	AudioServer.set_bus_volume_db(musica_bus, linear_to_db(valor))

func set_sfx_volumen(valor = -1):
	if valor == -1:
		valor = GUI.get_sfx_volumen()
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(valor))
