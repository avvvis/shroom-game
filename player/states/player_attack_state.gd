extends AttackState

func enter() -> void:
	hit_box.damage = GameState.damage
	attack_speed = GameState.attack_speed
	super()
	
