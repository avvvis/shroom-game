extends Control

func _init():
	# In order for all this 3D rendering to work in 2D you need both the SubViewportContainer and SubViewport. You also need to have this particular hierarchy:
	# Base:
	#	 SubVieportContainer:
	#		 SubViewport:
	#			 Shroom
	var container = SubViewportContainer.new()
	var subviewport = SubViewport.new()
	
	subviewport.add_child(ExampleShroom.new())
	container.add_child(subviewport)
	add_child(container)
