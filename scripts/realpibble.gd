extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@onready var hitbox = $Hitbox
@onready var timer = $CooldownTimer
@onready var animation_player = $AnimationPlayer

var can_attack = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_up_1") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left_1", "move_right_1")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	#Flip teh Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	
	if Input.is_action_just_pressed("attack_1") and can_attack:
		
		animated_sprite.play("attack") 
		  # Disable further attacks until cooldown is over
		timer.start(3.0)  # Start the cooldown timer
	

	#play animations
	if is_on_floor():

		if direction == 0:
			animated_sprite.play("idle")

		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
		animation_player.play("jump")


	move_and_slide()

func _on_iron_man_body_entered(body):
	animated_sprite.play("tranquility")