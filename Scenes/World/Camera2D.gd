extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var target_name = "Player"
var target
# Called when the node enters the scene tree for the first time.
func _ready():
    target = get_parent().find_node(target_name)  
    position = target.position
	
func _process(delta):
    target = get_parent().find_node(target_name)  
    position = target.position
