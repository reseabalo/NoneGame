extends Area2D
class_name bala
@export var speed = 3
var a_la_derecha : bool
var direccion_disparo : Vector2

func start(pos):
	position = pos

func apuntar(dir):
	direccion_disparo = dir


func _physics_process(_delta: float) -> void:
	$AnimationPlayer.play("travel")
	global_position += (-direccion_disparo*speed).normalized()



func _on_area_entered(area: Area2D):
	if area.get_parent() is Jugador:
		queue_free()


func _on_timer_timeout():
	queue_free()
