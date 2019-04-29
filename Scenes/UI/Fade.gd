extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var timer = 2
	if(timer<=0):
		get_parent().remove_child(self)
	timer -= delta



func _on_Button_pressed():
	get_tree().paused = false
	self.queue_free()
