# Domain.gd
#---------------------------------
class_name DomainWarp extends PanelContainer

#---------------------------------
@onready var g_map: Map = get_tree().root.get_node("World").get_node("Map")

@onready var m_enabled: CheckBox = $"VBoxContainer/Enabled"

@onready var m_type: OptionButton = $"VBoxContainer/Type"

@onready var m_amplitudeLabel: Label = $"VBoxContainer/Amplitude/Label"
@onready var m_amplitude: HSlider = $"VBoxContainer/Amplitude/HSlider"

@onready var m_frequencyLabel: Label = $"VBoxContainer/Frequency/Label"
@onready var m_frequency: HSlider = $"VBoxContainer/Frequency/HSlider"

@onready var m_fractalType: OptionButton = $"VBoxContainer/FractalType"

@onready var m_fractalOctavesLabel: Label = $"VBoxContainer/FractalOctaves/Label"
@onready var m_fractalOctaves: HSlider = $"VBoxContainer/FractalOctaves/HSlider"

@onready var m_fractalGainLabel: Label = $"VBoxContainer/FractalGain/Label"
@onready var m_fractalGain: HSlider = $"VBoxContainer/FractalGain/HSlider"

@onready var m_fractalLacunarityLabel: Label = $"VBoxContainer/FractalLacunarity/Label"
@onready var m_fractalLacunarity: HSlider = $"VBoxContainer/FractalLacunarity/HSlider"

#---------------------------------
func _ready():
	# add items to domainWarpType optionButton
	m_type.add_item('simplex', FastNoiseLite.DomainWarpType.DOMAIN_WARP_SIMPLEX)
	m_type.add_item('simplex reduced', FastNoiseLite.DomainWarpType.DOMAIN_WARP_SIMPLEX_REDUCED)
	m_type.add_item('basic grid', FastNoiseLite.DomainWarpType.DOMAIN_WARP_BASIC_GRID)
	
	# init domain warp labels
	m_amplitudeLabel.set_text('amplitude: ' + str("%.3f" % g_map.m_noise.get_domain_warp_amplitude()))
	m_frequencyLabel.set_text('frequency: ' + str("%.3f" % g_map.m_noise.get_domain_warp_frequency()))
	
	# add items to domainWarpFractalType optionButton
	m_fractalType.add_item('fractal none', FastNoiseLite.DomainWarpFractalType.DOMAIN_WARP_FRACTAL_NONE)
	m_fractalType.add_item('fractal progressive', FastNoiseLite.DomainWarpFractalType.DOMAIN_WARP_FRACTAL_PROGRESSIVE)
	m_fractalType.add_item('fractal independent', FastNoiseLite.DomainWarpFractalType.DOMAIN_WARP_FRACTAL_INDEPENDENT)

	# init domain warp fractal labels
	m_fractalOctavesLabel.set_text('octaves: ' + str("%.3f" % g_map.m_noise.get_domain_warp_fractal_octaves()))
	m_fractalGainLabel.set_text('gain: ' + str("%.3f" % g_map.m_noise.get_domain_warp_fractal_gain()))
	m_fractalLacunarityLabel.set_text('lacunarity: ' + str("%.3f" % g_map.m_noise.get_domain_warp_fractal_lacunarity()))
	
	updateControls()

#---------------------------------
func updateControls():
	m_enabled.set_pressed(g_map.m_noise.is_domain_warp_enabled())
	m_type.select(g_map.m_noise.get_domain_warp_type())
	m_amplitude.set_value(g_map.m_noise.get_domain_warp_amplitude())
	m_frequency.set_value(g_map.m_noise.get_domain_warp_frequency())
	
	m_fractalType.select(g_map.m_noise.get_domain_warp_fractal_type())
	m_fractalOctaves.set_value(g_map.m_noise.get_domain_warp_fractal_octaves())
	m_fractalGain.set_value(g_map.m_noise.get_domain_warp_fractal_gain())
	m_fractalLacunarity.set_value(g_map.m_noise.get_domain_warp_fractal_lacunarity())
	
#---------------------------------
func _on_enabled_toggled(button_pressed):
	g_map.m_data.m_domainWarpEnabled = button_pressed
	g_map.generateMap()
	m_enabled.set_pressed(g_map.m_noise.is_domain_warp_enabled())

#---------------------------------
func _on_domainType_item_selected(index):
	g_map.m_data.m_domainType = index
	g_map.generateMap()
	m_type.select(g_map.m_noise.get_domain_warp_type())

#---------------------------------
func _on_amplitude_value_changed(value):
	g_map.m_data.m_domainAmplitude = value
	g_map.generateMap()
	m_amplitudeLabel.set_text('amplitude: ' + str("%.3f" % g_map.m_noise.get_domain_warp_amplitude()))

#---------------------------------
func _on_frequency_value_changed(value):
	g_map.m_data.m_domainFrequency = value
	g_map.generateMap()
	m_frequencyLabel.set_text('frequency: ' + str( "%.3f" % g_map.m_noise.get_domain_warp_frequency()))

#---------------------------------
func _on_fractalType_item_selected(index):
	g_map.m_data.m_domainFractalType = index
	g_map.generateMap()
	m_fractalType.select(g_map.m_noise.get_domain_warp_fractal_type())

#---------------------------------
func _on_fractalOctaves_value_changed(value):
	g_map.m_data.m_domainFractalOctaves = value
	g_map.generateMap()
	m_fractalOctavesLabel.set_text('octaves: ' + str(g_map.m_noise.get_domain_warp_fractal_octaves()))

#---------------------------------
func _on_fractalGain_value_changed(value):
	g_map.m_data.m_domainFractalGain = value
	g_map.generateMap()
	m_fractalGainLabel.set_text('gain: ' + str("%.3f" % g_map.m_noise.get_domain_warp_fractal_gain()))

#---------------------------------
func _on_fractalLacunarity_value_changed(value):
	g_map.m_data.m_domainFractalLacunarity = value
	g_map.generateMap()
	m_fractalLacunarityLabel.set_text('lacunarity: ' + str("%.3f" % g_map.m_noise.get_domain_warp_fractal_lacunarity()))
