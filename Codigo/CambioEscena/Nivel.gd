class_name Level extends Node2D

@export var player:Jugador
@export var doors:Array[Door]
var data:LevelDataHandoff

func _ready() -> void:
	player.disable()
	player.visible = false
	# This block is here to allow us to test current scene without needing the SceneManager to call these :) 
	if data == null: 
		init_scene()
		start_scene()
		

func get_data():
	return data
	
func receive_data(_data):

	if _data is LevelDataHandoff:
		data = _data
	else:
		push_warning("Level %s is receiving data it cannot process" % name)

func init_scene() -> void:
	init_player_location()

func start_scene() -> void:
	player.enable()
	_connect_to_doors()

## put player in front of the correct door, facing the correct direction
func init_player_location() -> void:
	player.visible = true
#	var doors = find_children("*","Door")
	if data != null:
		for door in doors:
			if door.name == data.entry_door_name:
				player.position = door.get_player_entry_vector()
		player.orient(data.move_dir)

## signal emitted by Door, # disables doors and players, create handoff data to pass to the new scene (if new scene is a Level)
func _on_player_entered_door(door:Door) -> void:
	_disconnect_from_doors()
	player.disable()
	player.queue_free()
	data = LevelDataHandoff.new()
	data.entry_door_name = door.entry_door_name
	data.move_dir = door.get_move_dir()
	set_process(false)
		

## connects to all door signals in level
func _connect_to_doors() -> void:
	for door in doors:
		if not door.player_entered_door.is_connected(_on_player_entered_door):
			door.player_entered_door.connect(_on_player_entered_door)

## disconnect from all door signals in level			
func _disconnect_from_doors() -> void:
	for door in doors:
		if door.player_entered_door.is_connected(_on_player_entered_door):
			door.player_entered_door.disconnect(_on_player_entered_door)
			
