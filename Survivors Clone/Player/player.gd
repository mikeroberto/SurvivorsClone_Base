extends CharacterBody2D

var movement_speed = 64.0 #this controls the speed of the character
# In the future having a way to make the speed change for a period of time would be cool
# like a speed potion
var hp = 80.0
@onready var sprite = $Sprite2D
@onready var walkTimer = get_node("%walkTimer")


func _physics_process(delta): #processed every 1/60 of a frame
	movement()
	
func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov, y_mov)
	if mov.x > 0:
		sprite.flip_h = true
	elif mov.x < 0:
		sprite.flip_h = false
	
	if mov != Vector2.ZERO:
		if walkTimer.is_stopped():
			if sprite.frame >= sprite.hframes - 1:
				sprite.frame = 0
			else:
				sprite.frame += 1
			walkTimer.start()
			
	
	velocity = mov.normalized() * movement_speed
	move_and_slide()
	


func _on_hurt_box_hurt(damage):
	hp -= damage
	print(hp)
