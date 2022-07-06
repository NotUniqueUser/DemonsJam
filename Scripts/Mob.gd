extends RigidBody2D
# -------TODO SWAP NODE TYPES WITH PLAYER VERY IMPORTANT-------
signal shot(stage_shot)

export(Color) var blend_color
export(int) var stage = 3
export(int, 10, 100) var speed = 20

onready var sprite

var move_angle
var sprite_size
var sprite_x_half
var sprite_y_half
var screen_size

func _init(stage = 3, speed = 20):
	self.stage = stage
	self.speed = speed

func _ready():
	sprite = $Sprite
	move_angle = rand_range(0, TAU)
	sprite.scale = sprite.get_scale() * stage
	sprite_size = sprite.texture.get_size() * sprite.get_scale()
	sprite_x_half = sprite_size.x / 2
	sprite_y_half = sprite_size.y / 2
	screen_size = get_viewport_rect().size
	
	sprite.material = sprite.material.duplicate(true)
	sprite.material.set_shader_param(
		"color",
		# color(0,0,0,1) is default color and returns false
		blend_color if blend_color else Color(rand_range(0, 1), rand_range(0, 1), rand_range(0, 1)) 
		)

func _process(delta):
	var velocity = Vector2.ONE.rotated(move_angle)
	velocity = velocity.normalized() * speed
	
	position += velocity * delta
	
	position.x = clamp(position.x, sprite_x_half, screen_size.x - sprite_x_half)
	position.y = clamp(position.y, sprite_y_half, screen_size.y - sprite_y_half)
	
	# bounce the mob (you may modify the bounce but it works good)
	if is_on_edge():
		move_angle += PI / 2

func is_on_edge():
	if position.x == screen_size.x - sprite_x_half || position.x == sprite_x_half:
		return true
	if position.y == screen_size.y - sprite_y_half || position.y == sprite_y_half:
		return true
	return false

# debug function
func stimulate():
	pass

func _on_RigidBody2D_body_entered(body: Area2D):
	print('collided')
	if body.get_name() == "Player":
		print('collided with player!')
		return
	# TODO if body is bullet, in the meantime use the player as a collision body
	#emit_signal("shot", stage)
	
	# TODO split mob - doing it here feels the rightest...
