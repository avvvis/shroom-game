class_name State
extends Node

@export var animation_name: String

var parent: CharacterBody2D

func enter() -> void:
	parent.update_animation(animation_name)

func exit() -> void:
	pass

func handle_input(event: InputEvent) -> State:
	return null

func process(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
