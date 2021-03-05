extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect("network_peer_connected",self, "_connected")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Host_Button_pressed():
	var server = NetworkedMultiplayerENet.new()
	server.create_server(8080,2)
	get_tree().set_network_peer(server)
	

func _on_Join_Button2_pressed():
	var client = NetworkedMultiplayerENet.new()
	client.create_client("192.168.141.201",8080)
	get_tree().set_network_peer(client)

func _connected(client_id):
	Singelton.user_id = client_id
	var game = preload("res://Game.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()
