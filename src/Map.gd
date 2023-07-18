# Map.gd
#---------------------------------
class_name Map extends TileMap

#---------------------------------
@export var m_data: MapData = MapData.new()

# tiles
var m_lightBlue = Vector2i(14, 0)
var m_darkBlue = Vector2i(2, 0)
var m_aqua = Vector2i(6, 0)
var m_lightGreen = Vector2i(4, 2)
var m_darkGreen = Vector2i(0, 2)
var m_olive = Vector2i(2, 2)

# random noise generator
var m_noise = FastNoiseLite.new()

#---------------------------------
func _ready():
	loadData('res://default.tres')
	setScale()
	generateMap()

#---------------------------------
func loadData(path: String) -> void:
	if ResourceLoader.exists(path, 'MapData'):
		m_data = ResourceLoader.load(path, 'MapData')

#---------------------------------
func saveData(path: String):
	print('saveData path: ', path)
	print('m_data.m_fileName: ', m_data.m_fileName)
	m_data.m_fileName = path
	var result = ResourceSaver.save(m_data, path)
	assert(result == OK)

#---------------------------------
func setScale():
	var viewport: Vector2 = get_viewport_rect().size
	var tileSize: Vector2 = get_tileset().get_tile_size()
	var pixels = tileSize * m_data.m_mapSize
	
	set_scale(viewport / pixels)

#---------------------------------
func generateMap():
	var m_tileList = []
	m_tileList.append(m_darkBlue)
	m_tileList.append(m_lightBlue)
	m_tileList.append(m_aqua)
	m_tileList.append(m_darkGreen)
	m_tileList.append(m_lightGreen)
	m_tileList.append(m_olive)
	
	m_noise.set_noise_type(m_data.m_noiseType)
	m_noise.set_seed(m_data.m_seed) # randi_range(0, 500)
	m_noise.set_frequency(m_data.m_freq)
	
	m_noise.set_fractal_type(m_data.m_fractalType)
	m_noise.set_fractal_octaves(m_data.m_fractalOctaves) # number of octaves to generate - 1 octave per tile
	m_noise.set_fractal_lacunarity(m_data.m_fractalLacunarity)
	m_noise.set_fractal_gain(m_data.m_fractalGain)
	m_noise.set_fractal_weighted_strength(m_data.m_fractalWeightedStrength) # keep between 0 to 1
	m_noise.set_fractal_ping_pong_strength(m_data.m_fractalPingPongStrength)
	
	m_noise.set_cellular_return_type(m_data.m_cellularReturnType)
	m_noise.set_cellular_distance_function(m_data.m_cellularDistanceFunction)
	m_noise.set_cellular_jitter(m_data.m_cellularJitter)
	
	m_noise.set_domain_warp_enabled(m_data.m_domainWarpEnabled)
	m_noise.set_domain_warp_type(m_data.m_domainType)
	m_noise.set_domain_warp_amplitude(m_data.m_domainAmplitude)
	m_noise.set_domain_warp_frequency(m_data.m_domainFrequency)
	m_noise.set_domain_warp_fractal_type(m_data.m_domainFractalType)
	m_noise.set_domain_warp_fractal_octaves(m_data.m_domainFractalOctaves)
	m_noise.set_domain_warp_fractal_gain(m_data.m_domainFractalGain)
	m_noise.set_domain_warp_fractal_lacunarity(m_data.m_domainFractalLacunarity)
	
	# print('m_mapSize: ', m_data.m_mapSize)
	for x in range(m_data.m_mapSize.x):
		for y in range(m_data.m_mapSize.y):
			var absNoise: float = abs(m_noise.get_noise_2d(x, y)) # get float value between -1 and 1
			var tileToPlace: int = floori(absNoise * m_data.m_layers) # get tile the noise value corresponds to
			tileToPlace = clamp(tileToPlace, 0, m_data.m_layers-1) # prevents invalid index err when absNoise == 1
			
			# if tileToPlace > m_tileList.size()-1:
			if tileToPlace > m_data.m_layers-1:
				print('absNoise: ', absNoise)
				print('tileToPlace: ', tileToPlace)
			
			set_cell(0, Vector2i(x,y), 0, m_tileList[tileToPlace])

#---------------------------------
