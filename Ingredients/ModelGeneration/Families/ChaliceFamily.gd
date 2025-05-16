extends IngredientFamily

class_name ChaliceFamily

func get_probability_weight() -> float:
	return 0.1

func generate_species(seed: int) -> IngredientSpecies:
	return IngredientSpecies.new()
