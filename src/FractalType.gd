# NoiseType.gd
#---------------------------------
extends OptionButton

#---------------------------------
@onready var g_map: Map = get_tree().root.get_node("World").get_node("Map")

#---------------------------------
func _ready():
	add_item('fractal none', FastNoiseLite.FractalType.FRACTAL_NONE)
	add_item('fractal fbm', FastNoiseLite.FractalType.FRACTAL_FBM)
	add_item('fractal ridged', FastNoiseLite.FractalType.FRACTAL_RIDGED)
	add_item('fractal ping pong', FastNoiseLite.FractalType.FRACTAL_PING_PONG)

#---------------------------------
func _on_item_selected(index):
	g_map.m_fractalType = index
	g_map.generateWorld()

#---------------------------------


