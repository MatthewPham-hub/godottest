extends Node

export(PackedScene) var mob_scene
var score 

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_ScoreTimer_timeout():
	score += 1

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	


func _on_MobTimer_timeout():
	#Creates new instance of mob 
	var mob = mob_scene.instance()
	
	#Random location
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.offset = randi()
	
	#Sets direction perpendicular / inwards
	# PI / 2 = 90 degree turn 
	var direction = mob_spawn_location.rotation + PI / 2  
	
	#Sets mobs position to position we created earlier
	mob.position = mob_spawn_location.position
	
	#Adds randomness to direction)=
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	#Velocity for mob 
	var velocity = Vector2(rand_range(150, 250), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	#Spawn mob we created 	
	add_child(mob)
	
	
