-- used in .DAT only

local dict = {
0, "NOT_SET",
98, "B",
103, "G",
114, "R",
120, "X",
121, "Y",
356, "ID",
745, "UI",
42233, "KEY",
47524, "LOD",
48248, "MAX",
48494, "MIN",
55664, "TIP",
6294923, "BANK",
6298733, "BEAM",
6305220, "BOLD",
6338029, "COMM",
6338053, "CORE",
6338100, "COST",
6434245, "FILE",
6436244, "FONT",
6436971, "FLAK",
6469327, "GOTO",
6479204, "GUID",
6577648, "JUMP",
6632900, "HOLD",
6643148, "HULL",
6653358, "ICON",
6688229, "NAME",
6761861, "LINE",
6763952, "LOOP",
6786571, "MARK",
6786611, "MASS",
6790696, "MESH",
6796708, "MOOD",
6823480, "RESX",
6823481, "RESY",
6829509, "ROLE",
6859120, "SHIP",
6885064, "PATH",
6937968, "QUIP",
6983184, "WARP",
7020372, "TEXT",
7024101, "TIME",
7024211, "TIPS",
7040581, "TYPE",
7057780, "UNIT",
11015808, "CHARGE_DURATION_VARIANCE",
18734596, "FEMALE_CHANCE",
24861103, "BUTTON",
29297375, "ACCELERATION",
34372302, "ACCELERATION_DELAY",
41310451, "CENTER",
41378085, "MERCENARY",
44155044, "CHARGE",
44477476, "CHOICE",
44806450, "CHUNKS",
57262751, "MANEUVERABILITY",
58216677, "CURVED",
59997422, "POPULATION_MAX",
59997688, "POPULATION_MIN",
84435180, "INSTALLED_BANK",
102444423, "FACTION",
102454305, "FRACTURE",
104555913, "HIT_MISSILES",
112686413, "FAIL_ID",
117952546, "TIME_POSITION",
146154688, "AFFINITY",
149277624, "FLIP_Y",
149277625, "FLIP_X",
150785432, "SECONDARIES",
151108850, "FRAMES",
156122853, "SHIELDHIT_MODEL",
167341141, "SEEKPARTICLE",
172754945, "NO_BASE_YOFFSET",
173971314, "CHARGE_MIN",
181481410, "REMOVECARGO",
195192029, "PAD_MESH_LOD",
197601623, "MAKENEUTRAL",
198348126, "PROGRESSBAR",
204967076, "DAMAGE",
207049501, "MAX_YAW_RATE",
212973990, "DIALOG",
213535941, "CONDITION",
225748167, "MIN_JUMP_RANGE",
232566841, "CONVERSATION_CONTRABAND_FEMALE",
233838032, "SOUND_FLAK",
234166283, "SOUND_LOOP",
234398611, "SOUND_WASH",
234531285, "SOUND_SCAN",
235001896, "BATCH",
235972082, "GIVECARGO",
236370354, "COLOR",
236371443, "COMMS",
236391987, "CLASS",
238504257, "ALPHA",
238648751, "PROJECTILE",
238771756, "FEATURE",
239450355, "FILES",
240889284, "GUILD",
241416313, "DELAY",
241421000, "DEPTH",
241700206, "DRAIN",
242883988, "EVENT",
246831631, "INTRO",
246910117, "IMAGE",
247577828, "NAMED",
247577843, "NAMES",
247639428, "ENGINE",
249795692, "LEGAL",
250000979, "LOOPS",
250819790, "CARGO_SPAWNCLASS",
251042028, "MODEL",
251056485, "MOVIE",
252226947, "VERSION",
252743109, "SCALE",
253046355, "SHIPS",
253156740, "SOUND",
253300398, "SPAWN",
253304036, "SPEED",
253398541, "SWARM",
253441561, "STORY",
253866220, "PANEL",
254130612, "PILOT",
254193044, "POINT",
254290981, "PRICE",
255379586, "AGGRESSION",
255523689, "GIVEQUEST",
255965925, "VALUE",
256094930, "EVENTS",
256289829, "VOICE",
257268424, "WIDTH",
257351044, "WOUND",
258333125, "TITLE",
258645230, "TWEEN",
260532926, "STRINGVALUE",
262894927, "NEXT_ID",
278886401, "NAME_END_SUCCESS",
281572542, "PLAYER_DIFFICULTY_MIN",
282865187, "STARTING_FLAG",
289523364, "TEXT_VERT_ALIGN",
319922587, "CORKSCREW",
330554530, "DESCRIPTION",
332139485, "INHABITABLE",
334462103, "DEFLECTOR_MESH",
335461374, "SYSTEM_SCALE",
338028974, "FACTIONOVERRIDE",
343250261, "HEIGHT",
347281647, "HIDDEN",
349651408, "REVEALBOUNTIES",
351813525, "DISPLAY_NAME",
372994552, "DIFFICULTY",
376912074, "AMBIENT_R",
376912090, "AMBIENT_B",
376912095, "AMBIENT_G",
383263821, "PRIORITY",
387285480, "VISIBLE",
388780057, "SOUND_AFTERBURNERON",
409579587, "IMPACTPARTICLE",
410017216, "NEBULA",
412314835, "MUZZLEFLASHPARTICLE",
416824429, "NORMAL",
417367368, "IMAGE_BACKGROUND",
424262470, "SOFTWARE_TYPE",
436476981, "OBJECT",
440550618, "ZOFFSET",
446588396, "CHARGE_ANGLE",
450418906, "BOOSTER",
453545452, "FORSALE",
473806581, "LAYOUT",
476448495, "GOVERNMENTS",
477216651, "DEFLECTOR",
488621467, "SUCCESS_EVENT_ID",
506991983, "MARGIN",
531619535, "DIFFICULTY_MAX",
531619801, "DIFFICULTY_MIN",
540225266, "RADIUS",
540552920, "RARITY",
540679729, "BRAVERY",
544257389, "RECOIL",
544386479, "REGION",
544683109, "RELOAD",
547169842, "IMAGE_DISABLE",
548169052, "FREQUENCYVARIATION",
549432230, "ORDNANCE_STARTING_SIZE",
560416169, "AVAILABILITY",
580747705, "SKYBOX",
581279173, "SHIELD",
587461770, "FORCE_PLANET_INDEX",
587572488, "FIXED_PLANET_INDEX",
589419922, "SPAWNS",
589835972, "SPRITE",
593615602, "STATUS",
594268589, "APPROACHABLE",
594678137, "SUFFIX",
599316716, "SYSTEM",
602504195, "SKYBOX_VISIBILITY_MULT",
605300974, "TEMPERATURE_MAXIMUM",
607502565, "PAIRED",
618770677, "PLANET",
619075538, "MANUFACTURER",
620990841, "PREFIX",
634824904, "WARP_MULT",
639660767, "LEVELED_LAYOUT",
647190080, "COMPONENT_SPAWNCLASS",
683203693, "VISUAL",
685202916, "VOLUME",
693520198, "AFTERBURNER_ACCELERATION",
694156489, "ATMOSPHERIC_DAMAGE",
709885151, "TOGGLEBUTTON",
712349013, "WEIGHT",
723578126, "ATMOSPHERE_RADIUS_MULT",
728724198, "MAX_DIFFICULTY",
741659033, "CONTAINER",
750217620, "SORTINDEX",
762806724, "TUMBLE",
762855669, "TURRET",
770975625, "SHORT_NAME",
778340775, "REMOVE_ON_FAIL",
790778676, "FORCE_WAYPOINT",
794515017, "GAMEPAD_ONLY",
819468531, "ZORDER",
833475124, "YAW_ACCELERATION",
853421370, "EXCHANGE_TYPE",
856982480, "EXCHANGECARGO",
861817843, "OCCUPIES_SLOT",
868857542, "TURN_ACCELERATION",
869228866, "ROLL_ACCELERATION",
878101325, "FEATURE_VERSION",
896805102, "TEMPERATURE_MINIMUM",
901067516, "TARGET_HEIGHT",
906659072, "INFER_PASSED_END",
921246553, "SOUND_BRAKEON",
935667651, "OVERHEAT_TIME",
945104093, "AFTERBURNER_DRAIN",
965787356, "DURATION_MIN",
965787594, "DURATION_MAX",
974545192, "HORZ_ALIGN",
974631631, "MIN_COUNT",
977359866, "TURN_DECAY",
981778870, "ALTERNATE_CHOICE",
985098560, "SUB_INDEX",
994104766, "MIN_VALUE",
1020371060, "PARTICLE_ELECTRIC",
1031994068, "ILLUMINATION",
1036525002, "AIMING_LIFESPAN",
1078973634, "PLANET_FEATURE_REQUIREMENT",
1084563799, "CHARGEPARTICLE",
1116655690, "ENDCONVERSATION",
1130035633, "LOD_CUTOFF",
1138169054, "MAX_PLANETS_MAX",
1138169288, "MAX_PLANETS_MIN",
1148987108, "BOUNTY_CHANCE",
1149594813, "PARTICLE_EXPIRE",
1150589615, "EXPLICIT_SYSTEM",
1181338694, "BROADSIDE",
1187949285, "SCAN_JAM",
1189328624, "SCALEMAX",
1189328870, "SCALEMIN",
1197212619, "PARTICLE_DEBRIS",
1212056456, "COMMODITIES",
1212907866, "EXPIREPARTICLE",
1218274002, "HULL_DAMAGE",
1231717518, "SOFTWARE",
1238955978, "CONVERSATIONBUTTON",
1239367022, "STATION_INTERIOR",
1264479844, "CHARGE_TIME",
1290937018, "COMM_FEMALE",
1291624946, "BRIBE_SUCCESSFUL",
1306161819, "MOOD_TEMP",
1316269483, "SEEKING",
1320572527, "Y_CEILING",
1325530888, "TARGET_NAME_SUFFIX",
1329807940, "TARGETABLE",
1331837003, "SETFLAG",
1336946094, "KEYBIND",
1339489844, "BASE_MESH",
1341185652, "IMAGE_ANIM",
1348182005, "TARGET_WIDTH",
1351508645, "LAUNCHANGLE",
1358170871, "CORE_HEALTH",
1362628856, "TARGET_ANGLE",
1362709628, "TARGET_ALPHA",
1365493268, "LAUNCH_UNIT",
1369288520, "LAUNCHPITCH",
1372887926, "SOUND_WARPEND",
1373057545, "CONVERSATIONS",
1395640761, "THROTTLE_SPEED",
1396110300, "CLICKSOUND",
1396273502, "INTERRUPTABLE",
1403727769, "CHARGE_BEAM_TRAVEL",
1412642463, "SHADOWS",
1416730593, "ORDNANCE_PURCHASE_SIZE",
1424139988, "TECHLEVEL",
1429670827, "PHANTOMCOST_PCT",
1439006210, "OVERRIDE_TYPE",
1446305857, "DEMAND_MULTIPLIER",
1449067440, "UNKNOWNREWARD",
1450728554, "AFTERBURNER_RECHARGE",
1452877174, "CREPUSCULAR_PARTICLE",
1453340843, "AOE_STRIKES_FRIENDLIES",
1459068648, "MISSION_ID",
1472037009, "MINING_MULTIPLIER",
1479883822, "SPAWNCLASS",
1490006475, "REQUIRED_STATUS",
1490471928, "ECONOMIES",
1494966925, "SHIELD_DAMAGE",
1497284803, "HULLIMPACTPARTICLE",
1518141139, "TRANSFER_TARGET",
1522447026, "EXCHANGE_COUNT",
1522695969, "SECONDARY",
1523270020, "CONTROL",
1524748984, "ISOLATED",
1540451178, "HAS_ATMOSPHERE",
1542471240, "ASSIST_ANGLE",
1545450867, "BAR_LAYOUT",
1560604184, "WEAPON_BANK",
1568262485, "EXCLUSIVE",
1574530990, "COOL_RATE",
1576609608, "TARGET_MINEABLES",
1579509453, "GLOW_OFFSET_Z",
1579509454, "GLOW_OFFSET_Y",
1579509455, "GLOW_OFFSET_X",
1586000819, "LINKED_QUADRANTS",
1611406230, "TRANSPONDER",
1611875276, "AOE_RADIUS",
1633035541, "DESCRIPTION_END_SUCCESS",
1653810882, "DELETE_ON_COLLAPSE",
1656431638, "POSITIVE",
1668203071, "COST_PCT",
1671840651, "REGION_RADIUS",
1678812716, "DROPCARGO",
1679743393, "REQUIRED_GAMEFLAG",
1681568648, "SPAWN_D",
1681568654, "SPAWN_B",
1681568655, "SPAWN_C",
1692818155, "GIVECREDITS",
1697585214, "FIND_TARGETS",
1753103568, "MISSILE_BANK",
1754987363, "JUMP_TARGET",
1756251755, "MAX_PITCH_RATE",
1761437629, "CONVERSATION_CONTRABAND",
1762577848, "GOVERNMENT_OVERRIDE",
1770075027, "BEAM_TRAVEL",
1771053575, "BASE_ASSIST_ANGLE",
1785402320, "SOUND_DEFLECTOR",
1808604086, "INERTIAL_DAMP",
1815330480, "MAX_ROLL_RATE",
1815817602, "STATION",
1819706552, "SYSTEM_ID",
1823928805, "BOOL_VALUE2",
1830717124, "CORE_HEALTH_DECAY",
1834487802, "OVERRIDE_PLANETARY_SYSTEM_ID",
1837484822, "SOUND_AFTERBURNER",
1872362638, "EXPLOSION_SHIELD_DAMAGE",
1897492848, "SHIELD_RECHARGE",
1923951263, "SOUND_SPECIAL",
1934438837, "ENERGY_COST",
1936309226, "FIGHTER_HANDICAP",
1941797107, "TRACKED_GLOWPARTICLE",
1945418378, "PITCH_ACCELERATION",
1952419158, "USES_ORDNANCE",
1956375164, "CONVERSATION_AGGRESSIVE_FEMALE",
1971442389, "INTIMIDATE_SUCCESSFUL",
1973547563, "ATMOSPHERE_G",
1973547566, "ATMOSPHERE_B",
1973547582, "ATMOSPHERE_R",
1986096378, "GIVE_TRADE_TIP",
1998265823, "SYSTEMS",
2023974691, "SUPPLY_MULTIPLIER",
2027166599, "FACTIONINFLUENCE",
2050924863, "REMOVECONTRABAND",
2051120963, "SEEK_DELAY",
2053308260, "YAW_DECAY",
2063840063, "IS_RELIC",
2104775308, "DEFLECTOR_DRAIN",
2131464315, "CARGOCOUNTMIN",
2131464557, "CARGOCOUNTMAX",
2144654755, "CORKSCREW_SCALE",
2145220642, "FORCE_AT_STATION",
2148422873, "COMMODITY_SPAWNCLASS",
2163038195, "STRINGVALUE2",
2171058898, "TURRET_PITCH_MIN",
2171059140, "TURRET_PITCH_MAX",
2200927350, "DISPLAYNAME",
2223930588, "ALLOWED_SYSTEM",
2225432492, "PLANET_FEATURE_VERSION",
2238270289, "DISPLAY_FACTIONCHANGE",
2247964276, "INFLUENCECHANGE",
2249571144, "GOVERNMENT_OVERRIDE_SPAWNCLASS",
2255791303, "MAX_JUMP_RANGE",
2263121200, "EXPLOSION_RADIUS",
2263360412, "DISALLOWED_SYSTEM",
2265655050, "STARTING",
2266989636, "LIGHT_RADIUS",
2271592222, "STATIONS",
2271989374, "STATUSES",
2299696879, "SHIELD_MULT",
2305749242, "IMAGE_TOGGLE",
2309836587, "MAX_DEFAULT_DIFFICULTY",
2332582837, "OUTPOST_ONLY",
2347919464, "SET_FLAG_ON_SCAN",
2386110886, "REFLECTIVE",
2398022769, "COLLISION_MESH",
2399266424, "Y_PERCENT",
2399266680, "X_PERCENT",
2410372648, "TEXTURE",
2415545813, "TRADE_SELL",
2415562270, "SCALE_SIZE",
2416941559, "LOD_GLOWCUTOFF",
2427478989, "PARTICLE_EXPLODE",
2434529564, "IGNORE_POI_TYPE",
2462505759, "REQUIRED_POI_USERINT",
2476454276, "STRING_VALUE",
2478732167, "LEECH_DURATION",
2485657709, "FRUSTUMLENGTH",
2486917802, "HIDDEN_WAYPOINT",
2490152496, "CHECKRECEIVECARGO",
2493566842, "PARTICLE_SHIELDENGAGE",
2515293010, "TEXT_KEYBOARD",
2522176393, "LIGHT_B",
2522176396, "LIGHT_G",
2522176409, "LIGHT_R",
2533809031, "MULTIPLIER",
2535012432, "DISPLAY",
2546962075, "ORDNANCE_NAME",
2564819907, "IMAGE_FOREGROUND",
2572222122, "DEFLECTOR_RECHARGE",
2575683607, "COMPLETEQUEST",
2579674529, "AFTERBURNER_FUEL",
2585046444, "LOCKING",
2590009713, "SORTOFFSET",
2592842638, "POSSIBLE_MISSION_DESTINATION",
2597804381, "TOOLTIP",
2598413168, "BUTTONCODE",
2598608815, "COMPONENTS",
2598736411, "BUTTONICON",
2599706913, "MIN_CORE_HEALTH",
2620792575, "PLANETS",
2648094575, "HULL_MULT",
2654649563, "KEYBOARD_ONLY",
2678539519, "MAKEHOSTILE",
2682276479, "PROPERTY_NAME",
2684742426, "ECONOMY_OVERRIDE_SPAWNCLASS",
2685508159, "HASTRACTOR",
2687555999, "TRACTOR",
2691658470, "MIN_DIFFICULTY",
2700547479, "CONTROLLER",
2700568977, "CONTROLSET",
2701687128, "SOUND_CRUISEOFF",
2705624637, "FROM_BOTTOM_LEFT",
2707046514, "PILOT_FEMALE",
2717862607, "SETMISSIONFLAG",
2726382043, "DROPSHADOW",
2772737515, "PARTICLE_WARPENGAGE",
2775666075, "FIRE_VARIANCE",
2787495973, "SHIELD_RECHARGE_DELAY",
2792636850, "SOUND_ENGINE",
2813487388, "PARTICLE_HULLDAMAGE",
2813491570, "PARTICLE_HEATDAMAGE",
2813780283, "HIREMERCENARY",
2843723462, "ORDNANCE_DESCRIPTION",
2848866410, "ALLOW_FEMALE",
2853645458, "SOUND_CHARGE",
2858884727, "ALLOW_MARK_MULTIPLIER",
2859058498, "SPAWN_CHANCE",
2864420948, "SAFE_SCALE_X",
2864420949, "SAFE_SCALE_Y",
2881307154, "SOUND_CRUISE",
2908175606, "DEFLECTOR_ENERGY",
2909941351, "IMAGE_ROLLOVER",
2920826116, "PARTICLE_WARP",
2920959866, "PARTICLE_SCAN",
2936545022, "TURRETS",
2938919533, "REWARDMULTIPLIER",
2945402887, "SOUND_DEFLECTORON",
2946724074, "DEFLECTOR_DAMAGE",
2963307038, "BROADSIDE_RANGE_BONUS",
2970025185, "GIVECOMPONENT",
3018165650, "FACTION_ONLY_MISSIONS",
3028210646, "CARGO_DESTROY_CHANCE",
3035435264, "BROADSIDE_VERTICAL",
3043049820, "FIRE_ALL_DIRECTIONS",
3046015299, "ALLOW_ON_OUTPOST",
3073791818, "COLLISION_MESH_LOD",
3074010140, "PHANTOMCARGO",
3076867355, "DONT_DELETE_ON_LOOT",
3084888331, "PRICE_MK_PCT",
3086422183, "DOLLY_MULT",
3090853761, "SOUND_HULLHIT",
3103323261, "SOUND_SHIELDHIT",
3112624276, "MINING_DAMAGE",
3117849135, "LAYOUT_OVERRIDE",
3121982251, "VERT_ALIGN",
3121998715, "TEXT_ALIGN",
3122115210, "MAX_COUNT",
3124857098, "ROLL_DECAY",
3129612635, "CARGO_OBJECT",
3133216742, "TECH_LEVEL",
3135325839, "REFLECTIVE_DEFLECTOR",
3138939528, "TOP_SPEED",
3138941946, "MAX_SPEED",
3141588475, "MAX_VALUE",
3143641351, "DETERMINISTIC",
3143743374, "BOOL_VALUE",
3157236513, "CONTROL_WEIGHT",
3163926424, "SILENT_COMPLETE",
3177470291, "IMAGE_NORMAL",
3181924630, "DEFAULT_DIFFICULTY",
3190252225, "FIXED_INDEX",
3195799868, "MISSION_FLAG",
3196246904, "SOUND_FLYBY",
3197131467, "PANEL_GROUP",
3198564777, "SOUND_DEATH",
3198874227, "PITCH_DECAY",
3200586283, "LEECH_SPEED_PCT",
3201153604, "SOUND_BRAKE",
3201340361, "SPLIT_COUNT",
3201752316, "FACTION_REQUIREMENT",
3204334211, "PILOT_ALIEN",
3220079057, "ORIENTED_EDGES",
3258641565, "PARTICLE_DEATH",
3263150774, "PRICE_PCT",
3263155962, "PRICE_MAX",
3263156204, "PRICE_MIN",
3264133522, "CONVERSATION",
3268818384, "ECONOMY",
3270751877, "MAX_PER_STATION",
3272589265, "PARTICLE_WOUND",
3278225331, "FACTIONS",
3295108737, "VARIABILITY",
3300029766, "CAN_ABANDON",
3325043572, "CONVERSATION_SURRENDER",
3345306433, "DEATHTIP",
3345730258, "FEATURES",
3352661237, "CONVERSATION_AGGRESSIVE",
3363357212, "LIFESPAN",
3372145309, "DIFFICULTY_THRESHOLD",
3372913571, "LEECH_SHIELD_PCT",
3376892352, "DEPRIORITIZED_TARGET",
3379249740, "LINKED_FIRE",
3383060978, "ECONOMY_OVERRIDE",
3390015161, "DESCRIPTION_END",
3397361964, "IMAGE_PS4",
3411068533, "EXPLOSION_HULL_DAMAGE",
3430937721, "TRADE_BUY",
3442837659, "BROADSIDES",
3453457592, "PAD_MESH",
3457995769, "REQUIRED_FLAG",
3458325297, "SPLIT_MISSILE",
3467956662, "NAME_OVERRIDE",
3474492558, "MESSAGE",
3487160670, "TIME_SIZE",
3495547465, "ORDNANCE_CAPACITY",
3559007882, "AOE_STRIKE_FRIENDLIES",
3563037320, "FIRE_ON_MAX_CHARGE",
3584837738, "CARGOFORMISSION",
3588401592, "REQUIRES_TRACTOR",
3603290459, "MINITIP",
3605649797, "TRAILSIZE",
3608718725, "MISSION",
3608718830, "MISSILE",
3621482093, "AI_TYPE",
3623887932, "DROP_CARGO_TO_CRATE",
3625375726, "MINCOUNT",
3629827502, "JOINGUILD",
3630333868, "SOUNDDATA",
3631212552, "SOUND_DIE",
3632189062, "LINE_SET",
3634285169, "RANK_REQ",
3634701777, "CHARGE_VARIANCE",
3641739199, "MINSCALE",
3656803260, "ALIEN_NAME",
3661776090, "YOFFSET",
3662090376, "WAYPOINT_SUFFIX",
3667548007, "WIDTH_PERCENT",
3669413455, "SETGAMEFLAG",
3678403991, "DESTROYS_DEBRIS_ON_IMPACT",
3691135307, "CONVERSATION_FEMALE",
3693585858, "STARTING_MISSION",
3694864175, "RELATION",
3696006689, "SHIELD_MAX",
3697398670, "GUILDCOST",
3706631725, "HULL_MAX",
3710085792, "SOUND_BRAKEOFF",
3710226431, "HELPICON",
3714268464, "ORIGIN_HORZ",
3714848062, "ORIGIN_VERT",
3724131935, "TRAIL_TYPE",
3724181279, "TRAIL_SIZE",
3727861687, "DAMAGING",
3728363212, "ANIMATION",
3732838372, "NAME_END",
3738324914, "COMMODITY",
3758816543, "GIVECARGOCOUNT",
3763130268, "REWARD_PCT",
3763589384, "TARGET_X",
3763589385, "TARGET_Y",
3764089024, "MULTIPLIER2",
3765911166, "AIRELOAD",
3769525105, "MEMBERSHIP_FEE",
3770674079, "EXPLOSION_DEFLECTOR_DAMAGE",
3773247541, "GOVERNMENT",
3774994762, "ERRATIC",
3776426021, "OVERSOUND",
3780151907, "DISTANCE_MAX",
3780152181, "DISTANCE_MIN",
3795592729, "CENTERCHANCE",
3804421923, "FRESNEL_B",
3804421926, "FRESNEL_G",
3804421939, "FRESNEL_R",
3809853417, "MISSIONS",
3810965668, "RESPONSE",
3814832663, "DISTANCE",
3815392451, "BASE_MESH_LOD",
3821502858, "REQUIRES_TERRESTRIAL",
3824857651, "SOUND_EXPLODE",
3827370303, "AFTERBURNER_SPEED_PERCENTAGE",
3828393169, "CAPACITY",
3833995476, "Y_SAFE_OFFSET",
3837226542, "REQUIREMENT",
3839327487, "COMPONENT",
3843664015, "FAILURE_EVENT_ID",
3851026964, "SOUND_AFTERBURNEROFF",
3859671026, "RECEIVECARGO",
3870370276, "STRIKE_MISSILES",
3876897271, "BROADSIDE_ASSIST_BONUS",
3880880734, "REQUIRED_STATION_FACTION",
3895703655, "MAX_TURN_RATE",
3898464640, "PARTICLE_EXPLODEDEBRIS",
3910041036, "TARGET_NAME",
3917165666, "TURRET_VERTICAL",
3922934990, "NAV_DOWN",
3923187444, "NAV_LEFT",
3936575646, "SOUND_COLLISION",
3945020764, "CAN_DESTROY_FOR_NAVIGATION",
3951400749, "SUGGESTED_SHIELD_RADIUS",
3963315317, "DATATYPE",
3964896239, "SPRITEANIM",
3966942225, "CATEGORY",
3969229737, "VOLATILITY",
3973588697, "TUTORIAL",
3987836420, "CONSUME_RELIC",
3988229944, "REQUIRED_POI_TYPE",
3990279270, "SILENT_CONTROL",
4013735516, "RADIUS_MIN",
4013735754, "RADIUS_MAX",
4042144871, "EXPLOSION_MASS",
4059774717, "MAKEFRIENDLY",
4066918391, "ECONOMY_SUPPLY_MULTIPLIER",
4070357363, "BAR_CONVERSATION",
4083420435, "IMAGE_TOGGLE_OVER",
4092888141, "HIGHPRIORITY",
4095137772, "MAXCOUNT",
4102430932, "X_SAFE_OFFSET",
4110959488, "SOUND_CRUISEON",
4111501245, "MAXSCALE",
4124051443, "MAX_BANK",
4127570586, "KEYBINDS",
4162339639, "ORDNANCE_PRICE",
4172461662, "BOUNTY_MULTIPLIER",
4174933257, "CULL_DISTANCE",
4186432439, "ORDNANCE_IMAGE",
4192773854, "CRUISE_SPEED_PERCENTAGE",
4195671740, "TIME_ANGLE",
4195713592, "TIME_ALPHA",
4198593280, "TIME_DELAY",
4204120172, "HEIGHT_PERCENT",
4211298370, "COMMODITY_MIN",
4211298644, "COMMODITY_MAX",
4211617708, "BASE_PRICE",
4218704297, "LINE_WIDTH",
4224873610, "LIFESPAN_VARIANCE",
4243333483, "CORKSCREW_PERIOD",
4244088790, "ORDNANCE_DROP_CHANCE",
4253529256, "VOLUMEVARIATION",
4253881709, "HANGAR_LAYOUT",
4259905971, "SOUND_DEFLECTOROFF",
4259912769, "SOUND_DEFLECTORHIT",
4273655554, "IMAGE_CLICK",
4279097004, "IMAGE_XBONE",
}

return dict