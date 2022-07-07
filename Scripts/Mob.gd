extends Area2D

signal shot(stage_shot)

export(Color) var blend_color
export(int) var stage = 3
export(int, 10, 100) var speed = 20

const ORIGINAL_SIZE = Vector2(0.5, 0.5)
const SPRITES = [preload("res://Sprites/mo.png"), preload("res://Sprites/mib.png"), preload("res://Sprites/mobi.png")]

onready var sprite

var move_angle
var sprite_size
var sprite_x_half
var sprite_y_half
var screen_size

func _ready():
	hide() #it is shown when the start button is pressed
	sprite = $Sprite
	sprite.texture = SPRITES[stage - 1]
	move_angle = rand_range(0, TAU)
	#sprite.scale = ORIGINAL_SIZE * stage
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

func update_stage(stage):
	self.stage = stage
	sprite.scale = sprite.get_scale() * stage
	sprite_size = sprite.texture.get_size() * sprite.get_scale()
	sprite_x_half = sprite_size.x / 2
	sprite_y_half = sprite_size.y / 2

func _process(delta):
	var velocity = Vector2.ONE.rotated(move_angle)
	velocity = velocity.normalized() * speed
	
	position += velocity * delta
	
	position.x = clamp(position.x, sprite_x_half, screen_size.x - sprite_x_half)
	position.y = clamp(position.y, sprite_y_half, screen_size.y - sprite_y_half)
	
	# bounce the mob (you may modify the bounce but it works good)
	if is_on_edge():
		move_angle += rand_range(0, TAU)

func is_on_edge():
	if position.x == screen_size.x - sprite_x_half || position.x == sprite_x_half:
		return true
	if position.y == screen_size.y - sprite_y_half || position.y == sprite_y_half:
		return true
	return false

# debug function
func stimulate():
	_on_Mob_area_entered(null)

func _on_Mob_area_entered(area: Area2D):
	# Debug condition, delete later
	if (area != null && area.get_name() != "Mob") || (area == null):
		if stage - 1 <= 0:
			queue_free()
			return
		
		# Duplicate mobs
		var mob1 = duplicate()
		var mob2 = duplicate()
		
		mob1.sprite = sprite.duplicate()
		mob2.sprite = sprite.duplicate()
		
		mob1.sprite.scale = Vector2(0.25, 0.25)
		mob2.sprite.scale = Vector2(0.25, 0.25)
		
		mob1.move_angle = self.move_angle + PI / 2
		mob2.move_angle = self.move_angle - PI / 2
		
		mob1.update_stage(stage - 1)
		mob2.update_stage(stage - 1)
		
		get_parent().add_child(mob1)
		get_parent().add_child(mob2)
		mob1.show()
		mob2.show()
		
		# Remove original mob
		queue_free()
	# TODO if body is bullet, in the meantime use the player as a collision body
	#emit_signal("shot", stage)
	
	# TODO split mob - doing it here feels the rightest...
