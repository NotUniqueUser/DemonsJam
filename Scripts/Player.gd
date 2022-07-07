extends Area2D


var sprite_size
var sprite_x_half
var sprite_y_half
var screen_size
export(int, 100, 1000) var speed = 400

func _ready():
	hide()
	sprite_size = $Sprite.texture.get_size()
	sprite_x_half = sprite_size.x / 2
	sprite_y_half = sprite_size.y / 2
	screen_size = get_viewport_rect().size
	

func _process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	if velocity.length() > 0:
		if(velocity.x > 0):
			$Sprite.scale.x = -1
		elif(velocity.x < 0):
			$Sprite.scale.x = 1
		
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	position.x = clamp(position.x, sprite_x_half, screen_size.x - sprite_x_half)
	position.y = clamp(position.y, sprite_y_half, screen_size.y - sprite_y_half)
	

func start(pos):
	position = pos
	

func _on_Player_body_entered(body):
	print("player collision")
