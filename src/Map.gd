# Map.gd
#---------------------------------
class_name Map extends TileMap

#---------------------------------
# tiles
var m_water = Vector2i(2, 0)
var m_grass = Vector2i(4, 2)

# map dimensions
var m_mapSize: Vector2 = Vector2(256, 256)

# random noise generator
var m_noise = FastNoiseLite.new()

# noise variables (default values)
var m_noiseType: FastNoiseLite.NoiseType = FastNoiseLite.NoiseType.TYPE_SIMPLEX_SMOOTH
var m_seed: int = 0
var m_freq: float = 0.01

# fractal variables (default values)
var m_fractalType: FastNoiseLite.FractalType = FastNoiseLite.FractalType.FRACTAL_FBM
var m_fractalOctaves: int = 5
var m_fractalLacunarity: float = 2.0
var m_fractalGain: float = 0.5
var m_fractalWeightedStrength: float = 0.0 
var m_fractalPingPongStrength: float = 2.0

# cellular variables (default values)
var m_cellularReturnType: FastNoiseLite.CellularReturnType = FastNoiseLite.CellularReturnType.RETURN_DISTANCE
var m_cellularDistanceFunction: FastNoiseLite.CellularDistanceFunction = FastNoiseLite.CellularDistanceFunction.DISTANCE_EUCLIDEAN
var m_cellularJitter: float = 0.45

# domain warp variables (default values)
var m_domainWarpEnabled: bool = false
var m_domainType: FastNoiseLite.DomainWarpType = FastNoiseLite.DomainWarpType.DOMAIN_WARP_SIMPLEX
var m_domainAmplitude: float = 30.0
var m_domainFrequency: float = 0.05
var m_domainFractalType: FastNoiseLite.DomainWarpFractalType = FastNoiseLite.DomainWarpFractalType.DOMAIN_WARP_FRACTAL_PROGRESSIVE
var m_domainFractalOctaves: int = 5
var m_domainFractalGain: float = 0.5
var m_domainFractalLacunarity: float = 6.0

#---------------------------------
func _ready():
	setScale()
	generateWorld()

#---------------------------------
func setScale():
	var viewport: Vector2 = get_viewport_rect().size
	var tileSize: Vector2 = get_tileset().get_tile_size()
	var pixels = tileSize * m_mapSize
	
	set_scale(viewport / pixels)

#---------------------------------
func generateWorld():
	var m_tileList = []
	m_tileList.append(m_water)
	m_tileList.append(m_grass)
	
	m_noise.set_noise_type(m_noiseType)
	m_noise.set_seed(m_seed) # randi_range(0, 500)
	m_noise.set_frequency(m_freq)
	
	m_noise.set_fractal_type(m_fractalType)
	m_noise.set_fractal_octaves(m_fractalOctaves) # number of octaves to generate - 1 octave per tile
	m_noise.set_fractal_lacunarity(m_fractalLacunarity)
	m_noise.set_fractal_gain(m_fractalGain)
	m_noise.set_fractal_weighted_strength(m_fractalWeightedStrength) # keep between 0 to 1
	m_noise.set_fractal_ping_pong_strength(m_fractalPingPongStrength)
	
	m_noise.set_cellular_return_type(m_cellularReturnType)
	m_noise.set_cellular_distance_function(m_cellularDistanceFunction)
	m_noise.set_cellular_jitter(m_cellularJitter)
	
	m_noise.set_domain_warp_enabled(m_domainWarpEnabled)
	m_noise.set_domain_warp_type(m_domainType)
	m_noise.set_domain_warp_amplitude(m_domainAmplitude)
	m_noise.set_domain_warp_frequency(m_domainFrequency)
	m_noise.set_domain_warp_fractal_type(m_domainFractalType)
	m_noise.set_domain_warp_fractal_octaves(m_domainFractalOctaves)
	m_noise.set_domain_warp_fractal_gain(m_domainFractalGain)
	m_noise.set_domain_warp_fractal_lacunarity(m_domainFractalLacunarity)
	
	for x in range(m_mapSize.x):
		for y in range(m_mapSize.y):
			var absNoise: float = abs(m_noise.get_noise_2d(x, y)) # get float value between -1 and 1
			var tileToPlace: int = floori(absNoise * m_tileList.size()) # get tile the noise value corresponds to
			tileToPlace = clamp(tileToPlace, 0, m_tileList.size()-1) # prevents invalid index err when absNoise == 1
			
			if tileToPlace > 1:
				print('absNoise: ', absNoise)
				print('tileToPlace: ', tileToPlace)
			
			set_cell(0, Vector2i(x,y), 0, m_tileList[tileToPlace])

#---------------------------------
