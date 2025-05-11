extends Node

var generated_species: Array = []

func add_species(species: IngredientSpecies = null):
	if species == null:
		species = GlobalFamiliesRandomizer.generate_random_species(GameState._game_seed + generated_species.size())
	
	generated_species.append(species)

func get_random_species(seed: int) -> IngredientSpecies:
	if generated_species.size() == 0:
		push_error("No species in registry")
	
	var random = RandomNumberGenerator.new()
	random.seed = seed
	
	return generated_species[random.randi_range(0, generated_species.size() - 1)]
