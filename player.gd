extends Area2D

@export var player_id = 2
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

signal hit

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_body_entered(_body):
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		var velocity = Vector2.ZERO # The player's movement vector.
		if Input.is_action_pressed("move_right_%s" % [player_id]):
			velocity.x += 1
		if Input.is_action_pressed("move_left_%s" % [player_id]):
			velocity.x -= 1
		if Input.is_action_pressed("move_down_%s" % [player_id]):
			velocity.y += 1
		if Input.is_action_pressed("move_up_%s" % [player_id]):
			velocity.y -= 1

		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.stop()
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)
