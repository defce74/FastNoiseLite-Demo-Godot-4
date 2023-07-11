# Noise.gd
#---------------------------------
extends PanelContainer

#---------------------------------
@onready var g_map: Map = get_tree().root.get_node("World").get_node("Map")

@onready var m_noiseType: OptionButton = $"VBoxContainer/OptionButton"
@onready var m_seedLabel: Label = $"VBoxContainer/Seed/Label"
@onready var m_freqLabel: Label = $"VBoxContainer/Frequency/Label"

#---------------------------------
func _ready():
	m_noiseType.add_item('noise type simplex', FastNoiseLite.NoiseType.TYPE_SIMPLEX)
	m_noiseType.add_item('noise type simplex smooth', FastNoiseLite.NoiseType.TYPE_SIMPLEX_SMOOTH)
	m_noiseType.add_item('noise type cellular', FastNoiseLite.NoiseType.TYPE_CELLULAR)
	m_noiseType.add_item('noise type perlin', FastNoiseLite.NoiseType.TYPE_PERLIN)
	m_noiseType.add_item('noise type cubic', FastNoiseLite.NoiseType.TYPE_VALUE_CUBIC)
	m_noiseType.add_item('noise type value', FastNoiseLite.NoiseType.TYPE_VALUE)

#---------------------------------
func _on_noiseType_item_selected(index):
	g_map.m_noiseType = index
	g_map.generateWorld()

#---------------------------------
func _on_seed_value_changed(value):
	g_map.m_seed = value
	m_seedLabel.set_text('seed: ' + str(g_map.m_seed))
	g_map.generateWorld()

#---------------------------------
func _on_frequency_value_changed(value):
	g_map.m_freq = value
	m_freqLabel.set_text('freq: ' + str(g_map.m_freq))
	g_map.generateWorld()
