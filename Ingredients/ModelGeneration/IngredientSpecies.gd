extends Node
class_name IngredientSpecies

var component_connector: ComponentConnector = null
var distributions = {}

func generate_specimen(seed: int) -> IngredientSpecimen:
	return IngredientSpecimen.new()
