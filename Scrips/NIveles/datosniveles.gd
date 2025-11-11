extends Node2D
var datos = "user://TemporalNivel"


# al entrar a un nivel se cargan los datos que esten en el archivo
# guardado si es que este existe si no existe se quedara en su estado base
# la escena
func _ready() -> void:
	var cont : int = 0
	var ciclo: bool = true
	var datos_temporales : String = datos + str(cont) +".json"
	
	while ciclo:
		if FileAccess.file_exists(datos_temporales):
			var archivo := FileAccess.open(datos_temporales,FileAccess.READ)
			
			var json := archivo.get_as_text()
			var datos_guardados = JSON.parse_string(json)
			
			if datos_guardados[0]["direccion_nivel"] == scene_file_path:
				get_tree().call_group("cargar_juego","cargardo_del_momento",datos_temporales)
				ciclo = false
			else:
				cont +=  1
				datos_temporales = datos + str(cont) +".json"
		else:
			ciclo = false

# al entrar en una puerta se guarda el estado en el que quedo el nivel
# en un archivo Json
func _on_puerta_entro() -> void:
	var loop:bool = true
	var cont :int = 0
	var datos_temporales : String = datos + str(cont) +".json"
	
	while loop:
		if FileAccess.file_exists(datos_temporales):
			
			var archivo := FileAccess.open(datos_temporales,FileAccess.READ)
			
			var json := archivo.get_as_text()
			var datos_guardados = JSON.parse_string(json)
			
			if datos_guardados[0]["direccion_nivel"] == scene_file_path:
				get_tree().call_group("cargar_juego","guardado_del_momento",datos_temporales)
				loop = false
			else:
				cont +=  1
				datos_temporales = datos + str(cont) +".json"
		else:
			get_tree().call_group("cargar_juego","guardado_del_momento",datos_temporales)
			loop = false
	
