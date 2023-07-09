# NoiseType.gd
#---------------------------------
extends OptionButton

#---------------------------------
@onready var g_map: Map = get_tree().root.get_node("World").get_node("Map")

#---------------------------------
func _ready():
	add_item('noise type simplex', FastNoiseLite.NoiseType.TYPE_SIMPLEX)
	add_item('noise type simplex smooth', FastNoiseLite.NoiseType.TYPE_SIMPLEX_SMOOTH)
	add_item('noise type cellular', FastNoiseLite.NoiseType.TYPE_CELLULAR)
	add_item('noise type perlin', FastNoiseLite.NoiseType.TYPE_PERLIN)
	add_item('noise type cubic', FastNoiseLite.NoiseType.TYPE_VALUE_CUBIC)
	add_item('noise type value', FastNoiseLite.NoiseType.TYPE_VALUE)

#---------------------------------
func _on_item_selected(index):
	g_map.m_noiseType = index
	g_map.generateWorld()

