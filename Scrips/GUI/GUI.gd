extends CanvasLayer

var gui_componentes : Array = [
	"res://Escenas/GUI/menu_Pausa.tscn"
]

#Se encarga de que sea posible abri el menu de pausa
var visibilidad: bool = true

#nombre y direccion del archivo donde se guardaran los datos de las opciones realizadas
const opciones_direccion: String = "user://opciones.data"

#Lista con las resoluciones aplicabes, se pueden agregar mas de ser necesario
var resoluciones_lista : Array = [
	{ "ancho": 640,  "alto": 360 },
	{ "ancho": 1024, "alto": 768 },
	{ "ancho": 1280, "alto": 720 },
	{ "ancho": 1366, "alto": 768 },
	{ "ancho": 1600, "alto": 900 },
	{ "ancho": 1920, "alto": 1080 },
	{ "ancho": 2042, "alto": 1152 },
	{ "ancho": 2560, "alto": 1440 },
]


func _ready() -> void:
	#agrega al menu de pausa como hijo de GUI por lo tanto siempre esta cargado.
	#solamente se le cambia su visibilidad.
	for i in gui_componentes:
		var new_escena = load(i).instantiate()
		add_child(new_escena)
		new_escena.hide()

#abre el archivo de opciones y lee los datos que este tenga en ese preciso momento
func leer_opciones():
	var opciones = {}
	var archivo = FileAccess.open(opciones_direccion, FileAccess.READ)
	#si no fue creado el archivo no entrara en este if
	if archivo:
		opciones = archivo.get_var()
		archivo.close()
	return opciones

#escribe las opciones que allas creado y las guarda en el archivo si existo sino lo crea.
func escribir_opciones(options):
	var archivo = FileAccess.open(opciones_direccion, FileAccess.WRITE)
	archivo.store_var(options)
	archivo.close()

#se encarga de ver en que resolucion quedo la pantalla 
func set_modo_pantalla():
	var modo_ventana = DisplayServer.WINDOW_MODE_WINDOWED
	var opciones = leer_opciones()
	#revisa si el archivo de opcione tiene pantalla completa como escrito
	if opciones.has("pantalla_completa"):
		modo_ventana = DisplayServer.WINDOW_MODE_FULLSCREEN if opciones.pantalla_completa else DisplayServer.WINDOW_MODE_WINDOWED
	#el modo de pantalla completa o esta activo settea el modo de pantalla que se alla degado en el menu de opciones
	DisplayServer.window_set_mode(modo_ventana)
	escribir_opciones(opciones)


func redimencionar_ventana():
	var opciones = leer_opciones()
	if not opciones.has("pantalla_completa") or not opciones.pantalla_completa:
		var tamaño_ventana = Vector2i(opciones.window_ancho, opciones.window_alto)
		var tamaño_pantalla = DisplayServer.screen_get_size()
		get_window().size = tamaño_ventana
		DisplayServer.window_set_position(Vector2i((tamaño_pantalla.x - tamaño_ventana.x) / 2, (tamaño_pantalla.y - tamaño_ventana.y) / 2))

func calculate_window_size():
	var options = leer_opciones()
	var screen_size = DisplayServer.screen_get_size()
	var window_ancho = screen_size.x
	var window_alto = screen_size.y
	if options.has("window_ancho") and options.has("window_alto"):
		window_ancho = options.window_ancho
		window_alto = options.window_alto
	else:
		for tamaños in resoluciones_lista:
			# find the biggest window to fit the screen
			if tamaños.ancho < window_ancho:
				window_ancho = tamaños.ancho
				window_alto = tamaños.alto
		options.window_ancho = window_ancho
		options.window_alto = window_alto
		escribir_opciones(options)


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("salir_opciones") and  visibilidad:
		#ManejoEscenas.ir_a_escena("res://Escenas/GUI/menu_opciones.tscn","ir_oscurecer")
		#get_tree().change_scene_to_file("res://Escenas/GUI/menu_Pausa.tscn")
		var menu_opciones = get_node("Menu Pausa")
		menu_opciones.visible = !menu_opciones.visible
	else:
		return

func _cambio_visibilidad():
	var menu_opciones = get_node("Menu Pausa")
	menu_opciones.visible = !menu_opciones.visible
