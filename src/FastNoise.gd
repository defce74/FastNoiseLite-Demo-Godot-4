# Noise.gd
#---------------------------------
extends PanelContainer
class_name FastNoise 

#---------------------------------
@onready var g_map: Map = get_tree().root.get_node("World").get_node("Map")

@onready var m_layersLabel: Label = $"VBoxContainer/Layers/Label"
@onready var m_layers: HSlider = $"VBoxContainer/Layers/HSlider"

@onready var m_mapSizeLabel: Label = $"VBoxContainer/MapSize/Label"
@onready var m_mapSize: HSlider = $"VBoxContainer/MapSize/HSlider"

@onready var m_noiseType: OptionButton = $"VBoxContainer/NoiseType"

@onready var m_seedLabel: Label = $"VBoxContainer/Seed/Label"
@onready var m_seed: HSlider = $"VBoxContainer/Seed/HSlider"

@onready var m_freqLabel: Label = $"VBoxContainer/Frequency/Label"
@onready var m_freq: HSlider = $"VBoxContainer/Frequency/HSlider"

#---------------------------------
func _ready():
	m_layers.grab_focus()
	
	m_layersLabel.set_text('layers: ' + str(g_map.m_data.m_layers))
	m_mapSizeLabel.set_text('map size: ' + str(g_map.m_data.m_mapSize))
	
	m_noiseType.add_item('noise type simplex', FastNoiseLite.NoiseType.TYPE_SIMPLEX)
	m_noiseType.add_item('noise type simplex smooth', FastNoiseLite.NoiseType.TYPE_SIMPLEX_SMOOTH)
	m_noiseType.add_item('noise type cellular', FastNoiseLite.NoiseType.TYPE_CELLULAR)
	m_noiseType.add_item('noise type perlin', FastNoiseLite.NoiseType.TYPE_PERLIN)
	m_noiseType.add_item('noise type cubic', FastNoiseLite.NoiseType.TYPE_VALUE_CUBIC)
	m_noiseType.add_item('noise type value', FastNoiseLite.NoiseType.TYPE_VALUE)
	m_noiseType.select(g_map.m_noise.get_noise_type())
	
	m_seedLabel.set_text('seed: ' + str(g_map.m_noise.get_seed()))
	m_freqLabel.set_text('frequency: ' + str( "%.3f" % g_map.m_noise.get_frequency()))
	
	updateControls()

#---------------------------------
func updateControls():
	m_layers.set_value(g_map.m_data.m_layers)
	m_mapSize.set_value(g_map.m_data.m_mapSize.x)
	m_noiseType.select(g_map.m_noise.get_noise_type())
	m_seed.set_value(g_map.m_noise.get_seed())
	m_freq.set_value(g_map.m_noise.get_frequency())

#---------------------------------
func _on_layers_value_changed(value):
	g_map.m_data.m_layers = value
	g_map.generateMap()
	m_layersLabel.set_text('layers: ' + str(g_map.m_data.m_layers))

#---------------------------------
func _on_mapSize_value_changed(value):
	g_map.m_data.set_mapSize(value)
	g_map.setScale()
	g_map.generateMap()
	m_mapSizeLabel.set_text('map size: ' + str(g_map.m_data.m_mapSize))

#---------------------------------
func _on_noiseType_item_selected(index):
	g_map.m_data.m_noiseType = index
	g_map.generateMap()
	m_noiseType.select(g_map.m_noise.get_noise_type())

#---------------------------------
func _on_seed_value_changed(value):
	g_map.m_data.m_seed = value
	g_map.generateMap()
	m_seedLabel.set_text('seed: ' + str(g_map.m_noise.get_seed()))

#---------------------------------
func _on_frequency_value_changed(value):
	g_map.m_data.m_freq = value
	g_map.generateMap()
	m_freqLabel.set_text('frequency: ' + str( "%.3f" % g_map.m_noise.get_frequency()))
