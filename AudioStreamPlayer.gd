extends AudioStreamPlayer

# Declare member variables here. Examples:
var a = -20
var b = false

# Called when the node enters the scene tree for the first time.
func _ready():
	playing = true
	autoplay = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if !a>=0&&!b:
		a += delta
	set_volume_db(a)
	
func boss(area):
	b = true
	a = -50
func notBoss(area):
	b = false
	a = -20