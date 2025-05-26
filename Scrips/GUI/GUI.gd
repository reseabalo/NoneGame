extends CanvasLayer

var gui_componentes = [
	"res://Escenas/GUI/menu_Pausa.tscn"
]


var resoluciones = {
	"3840x2160": Vector2i(3840,2160),
	"2560x1440": Vector2i(2560,1440),
	"1920x1080": Vector2i(1920,1080),
	"1366x768": Vector2i(1366,768),
	"1280x720": Vector2i(1280,720),
	"1440x900": Vector2i(1440,900),
	"1600x900": Vector2i(1600,900),
	"1024x600": Vector2i(1024,600),
	"800x600": Vector2i(800,600),
	"640x360": Vector2i(640,360)
}


func _ready() -> void:
	for i in gui_componentes:
		var new_escena = load(i).instantiate()
		#add_sibling(new_escena)
		add_child(new_escena)
		new_escena.hide()
		
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("salir_opciones"):
		var menu_opciones = get_node("Menu Pausa")
		menu_opciones.visible = !menu_opciones.visible
		if menu_opciones.visible:
			menu_opciones.update_botton_values()

func centrar_ventana():
	var centro_pantalla:Vector2i = DisplayServer.screen_get_position() + DisplayServer.screen_get_size()
	var tamaño_pantalla:Vector2i = get_window().get_size_with_decorations()
	get_window().set_position(centro_pantalla - tamaño_pantalla /2)
	
func _cambio_visibilidad():
		var menu_opciones = get_node("Menu Pausa")
		menu_opciones.visible = !menu_opciones.visible
