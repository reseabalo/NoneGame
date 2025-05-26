extends Control
class_name  MenuOpciones

@onready var resoluciones_option_button: OptionButton = $Panel/HBoxContainer/VBoxContainer/OptionButton

func _ready() -> void:
	add_resoluciones()

func add_resoluciones():
	for r in GUI.resoluciones:
		resoluciones_option_button.add_item(r)
		
func update_botton_values():
	var tamaño_pantalla_string = str(get_window().size.x, "x", get_window().size.y)
	var indice_resoluciones = GUI.resoluciones.keys().find(tamaño_pantalla_string)
	resoluciones_option_button.selected = indice_resoluciones
	
func _on_option_button_item_selected(index: int) -> void:
	var key = resoluciones_option_button.get_item_text(index)
	get_window().set_size(GUI.resoluciones[key])
	GUI.centrar_ventana()
	
func _on_button_button_up() -> void:
	GUI._cambio_visibilidad()
