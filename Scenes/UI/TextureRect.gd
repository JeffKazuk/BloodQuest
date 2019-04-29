extends TextureRect

var player
var stick = load("res://Sprites/Stick.png")
var sword = load("res://Sprites/Sword1.png")
var fire = load("res://Sprites/Test fire.png")
var dagger = load("res://Sprites/Dagger.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_parent()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player != null:
		if player.equipped == 'stick':
			set_texture(stick)
		if player.equipped == 'sword':
			set_texture(sword)
		if player.equipped == 'fire':
			set_texture(fire)
		if player.equipped == 'dagger':
			set_texture(dagger)
