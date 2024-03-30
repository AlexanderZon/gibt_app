import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gibt_1/models/models.dart';

class DataProvider extends ChangeNotifier {
  List<Character> characters = [];
  List<Weapon> weapons = [];
  List<MaterialItem> materials = [];

  List<String> charactersData = [
    'ambor_021', // Amber
    'kaeya_015', // Kaeya
    'lisa_006', // Lisa
    'barbara_014', // Barbara
    'razor_020', // Razor
    'xiangling_023', // Xiangling
    'beidou_024', // Beidou
    'xingqiu_025', // Xingqiu
    'ningguang_027', // Ningguang
    'fischl_031', // Fischl
    'bennett_032', // Bennett
    'noel_034', // Noelle
    'chongyun_036', // Chongyun
    'sucrose_043', // Sucrose
    'qin_003', // Jean
    'diluc_016', // Diluc
    'qiqi_035', // Qiqi
    'mona_041', // Mona
    'keqing_042', // Keqing
    'venti_022', // Venti
    'klee_029', // Klee
    'diona_039', // Diona
    'tartaglia_033', // Tartaglia
    'xinyan_044', // Xinyan
    'zhongli_030', // Zhongli
    'albedo_038', // Albedo
    'ganyu_037', // Ganyu
    'xiao_026', // Xiao
    'hutao_046', // Hu Tao
    'rosaria_045', // Rosaria
    'feiyan_048', // Yanfei
    'eula_051', // Eula
    'kazuha_047', // Kaedehara Kazuha
    'ayaka_002', // Kamisato Ayaka
    'sayu_053', // Sayu
    'yoimiya_049', // Yoimiya
    'aloy_062', // Aloy:
    'sara_056', // Kujou Sara
    'shougun_052', // Raiden Shogun
    'kokomi_054', // Sangonomiya Kokomi
    'tohma_050', // Thoma
    'gorou_055', // Gorou:
    'itto_057', // Arataki Itto
    'yunjin_064', // Yun Jin
    'shenhe_063', // Shenhe
    'yae_058', // Yae Miko
    'ayato_066', // Kamisato Ayato
    'yelan_060', // Yelan
    'shinobu_065', // Kuki Shinobu
    'heizo_059', // Shikanoin Heizou
    'collei_067', // Collei
    'tighnari_069', // Tighnari
    'dori_068', // Dori
    'candace_072', // Candace
    'cyno_071', // Cyno
    'nilou_070', // Nilou
    'nahida_073', // Nahida
    'layla_074', // Layla
    'faruzan_076', // Faruzan
    'wanderer_075', // Wanderer
    'yaoyao_077', // Yaoyao
    'alhatham_078', // Alhaitham
    'dehya_079', // Dehya
    'mika_080', // Mika
    'kaveh_081', // Kaveh
    'baizhuer_082', // Baizhu
    'momoka_061', // Kirara
    'linette_083', // Lynette
    'liney_084', // Lyney
    'freminet_085', // Freminet
    'wriothesley_086', // Wriothesley
    'neuvillette_087', // Neuvillette
    'charlotte_088', // Charlotte
    'furina_089', // Furina
    'chevreuse_090', // Chevreuse
    'navia_091', // Navia
    'gaming_092', // Gaming
    'liuyun_093', // Xianyun
    'chiori_094', // Chiori
    'arlecchino_096', // Arlecchino
  ];

  List<String> weaponsData = [
    //############################ Swords
    'i_n11514', // Urakugo Rensai
    'i_n11513', // Splendor of Tranquil Waters
    'i_n11512', // Light of Foliar Incision
    'i_n11511', // Key of Khaj-Nisut
    'i_n11510', // Haran Geppaku Futsu
    'i_n11509', // Mistsplitter Reforged
    'i_n11505', // Primordial Jade Cutter
    'i_n11504', // Summit Shaper
    'i_n11503', // Freedom-Sworn
    'i_n11502', // Skyward Blade
    'i_n11501', // Aquila Favonia
    'i_n11428', // Sword of Narzissenkreuz
    'i_n11427', // The Dockhand's Assistant
    'i_n11426', // Fleuve Cendre Ferryman
    'i_n11425', // Finale of the Deep
    'i_n11422', // Toukabou Shigure
    'i_n11418', // Xiphos' Moonlight
    'i_n11417', // Sapwood Blade
    'i_n11416', // Kagotsurube Isshin
    'i_n11415', // Cinnabar Spindle
    'i_n11414', // Amenoma Kageuchi
    'i_n11413', // Festering Desire
    'i_n11412', // Sword of Descension
    'i_n11410', // The Alley Flash
    'i_n11409', // The Black Sword
    'i_n11408', // Blackcliff Longsword
    'i_n11407', // Iron Sting
    'i_n11406', // Prototype Rancour
    'i_n11405', // Lion's Roar
    'i_n11404', // Royal Longsword
    'i_n11403', // Sacrificial Sword
    'i_n11402', // The Flute
    'i_n11401', // Favonius Sword
    'i_n11306', // Skyrider Sword
    'i_n11305', // Fillet Blade
    'i_n11304', // Dark Iron Sword
    'i_n11303', // Traveler's Handy Sword
    'i_n11302', // Harbinger of Dawn
    'i_n11301', // Cool Steel
    'i_n11201', // Silver Sword
    'i_n11101', // Dull Blade
    //############################ Claymore
    'i_n12512', // Verdict
    'i_n12511', // Beacon of the Reed Sea
    'i_n12510', // Redhorn Stonethresher
    'i_n12504', // The Unforged
    'i_n12503', // Song of Broken Pines
    'i_n12502', // Wolf's Gravestone
    'i_n12501', // Skyward Pride
    'i_n12427', // Portable Power Saw
    'i_n12426', // "Ultimate Overlord's Mega Magic Sword"
    'i_n12425', // Tidal Shadow
    'i_n12424', // Talking Stick
    'i_n12418', // Mailed Flower
    'i_n12417', // Forest Regalia
    'i_n12416', // Akuoumaru
    'i_n12415', // Makhaira Aquamarine
    'i_n12414', // Katsuragikiri Nagamasa
    'i_n12412', // Luxurious Sea-Lord
    'i_n12411', // Snow-Tombed Starsilver
    'i_n12410', // Lithic Blade
    'i_n12409', // Serpent Spine
    'i_n12408', // Blackcliff Slasher
    'i_n12407', // Whiteblind
    'i_n12406', // Prototype Archaic
    'i_n12405', // Rainslasher
    'i_n12404', // Royal Greatsword
    'i_n12403', // Sacrificial Greatsword
    'i_n12402', // The Bell
    'i_n12401', // Favonius Greatsword
    'i_n12306', // Skyrider Greatsword
    'i_n12305', // Debate Club
    'i_n12304', // Quartz
    'i_n12303', // White Iron Greatsword
    'i_n12302', // Bloodtainted Greatsword
    'i_n12301', // Ferrous Shadow
    'i_n12201', // Old Merc's Pal
    'i_n12101', // Waster Greatsword
    //############################ Polearm
    'i_n13512', // Crimson Moon's Semblance
    'i_n13511', // Staff of the Scarlet Sands
    'i_n13509', // Engulfing Lightning
    'i_n13507', // Calamity Queller
    'i_n13505', // Primordial Jade Winged-Spear
    'i_n13504', // Vortex Vanquisher
    'i_n13502', // Skyward Spine
    'i_n13501', // Staff of Homa
    'i_n13427', // Prospector's Drill
    'i_n13425', // Rightful Reward
    'i_n13424', // Ballad of the Fjords
    'i_n13419', // Missive Windspear
    'i_n13417', // Moonpiercer
    'i_n13416', // Wavebreaker's Fin
    'i_n13415', // "The Catch"
    'i_n13414', // Kitain Cross Spear
    'i_n13409', // Dragonspine Spear
    'i_n13408', // Royal Spear
    'i_n13407', // Favonius Lance
    'i_n13406', // Lithic Spear
    'i_n13405', // Deathmatch
    'i_n13404', // Blackcliff Pole
    'i_n13403', // Crescent Pike
    'i_n13402', // Prototype Starglitter
    'i_n13401', // Dragon's Bane
    'i_n13303', // Black Tassel
    'i_n13302', // Halberd
    'i_n13301', // White Tassel
    'i_n13201', // Iron Point
    'i_n13101', // Beginner's Protector
    //############################ Catalyst
    'i_n14515', // Crane's Echoing Call
    'i_n14514', // Tome of the Eternal Flow
    'i_n14513', // Cashflow Supervision
    'i_n14512', // Tulaytullah's Remembrance
    'i_n14511', // A Thousand Floating Dreams
    'i_n14509', // Kagura's Verity
    'i_n14506', // Everlasting Moonglow
    'i_n14505', // Jadefall's Splendor
    'i_n14504', // Memory of Dust
    'i_n14502', // Lost Prayer to the Sacred Winds
    'i_n14501', // Skyward Atlas
    'i_n14426', // Ballad of the Boundless Blue
    'i_n14425', // Flowing Purity
    'i_n14424', // Sacrificial Jade
    'i_n14417', // Fruit of Fulfillment
    'i_n14416', // Wandering Evenstar
    'i_n14415', // Oathsworn Eye
    'i_n14414', // Hakushin Ring
    'i_n14413', // Dodoco Tales
    'i_n14412', // Frostbearer
    'i_n14410', // Wine and Song
    'i_n14409', // Eye of Perception
    'i_n14408', // Blackcliff Agate
    'i_n14407', // Mappa Mare
    'i_n14406', // Prototype Amber
    'i_n14405', // Solar Pearl
    'i_n14404', // Royal Grimoire
    'i_n14403', // Sacrificial Fragments
    'i_n14402', // The Widsith
    'i_n14401', // Favonius Codex
    'i_n14306', // Amber Bead
    'i_n14305', // Twin Nephrite
    'i_n14304', // Emerald Orb
    'i_n14303', // Otherworldly Story
    'i_n14302', // Thrilling Tales of Dragon Slayers
    'i_n14301', // Magic Guide
    'i_n14201', // Pocket Grimoire
    'i_n14101', // Apprentice's Notes
    //############################ Bow
    'i_n15512', // The First Great Magic
    'i_n15511', // Hunter's Path
    'i_n15509', // Thundering Pulse
    'i_n15508', // Aqua Simulacra
    'i_n15507', // Polar Star
    'i_n15503', // Elegy for the End
    'i_n15502', // Amos' Bow
    'i_n15501', // Skyward Harp
    'i_n15427', // Range Gauge
    'i_n15425', // Song of Stillness
    'i_n15424', // Scion of the Blazing Sun
    'i_n15419', // Ibis Piercer
    'i_n15418', // End of the Line
    'i_n15417', // King's Squire
    'i_n15416', // Mouun's Moon
    'i_n15415', // Predator
    'i_n15414', // Hamayumi
    'i_n15413', // Windblume Ode
    'i_n15412', // Mitternachts Waltz
    'i_n15411', // Fading Twilight
    'i_n15410', // Alley Hunter
    'i_n15409', // The Viridescent Hunt
    'i_n15408', // Blackcliff Warbow
    'i_n15407', // Compound Bow
    'i_n15406', // Prototype Crescent
    'i_n15405', // Rust
    'i_n15404', // Royal Bow
    'i_n15403', // Sacrificial Bow
    'i_n15402', // The Stringless
    'i_n15401', // Favonius Warbow
    'i_n15306', // Ebony Bow
    'i_n15305', // Messenger
    'i_n15304', // Slingshot
    'i_n15303', // Recurve Bow
    'i_n15302', // Sharpshooter's Oath
    'i_n15301', // Raven Bow
    'i_n15201', // Seasoned Hunter's Bow
    'i_n15101', // Hunter's Bow
  ];

  List<String> materialsData = [
    "i_",
    "i_101",
    "i_102",
    "i_103",
    "i_111",
    "i_112",
    "i_113",
    "i_121",
    "i_122",
    "i_123",
    "i_131",
    "i_132",
    "i_133",
    "i_141",
    "i_142",
    "i_143",
    "i_151",
    "i_152",
    "i_153",
    "i_161",
    "i_162",
    "i_163",
    "i_171",
    "i_172",
    "i_173",
    "i_174",
    "i_175",
    "i_176",
    "i_181",
    "i_182",
    "i_183",
    "i_185",
    "i_186",
    "i_187",
    "i_201",
    "i_202",
    "i_203",
    "i_204",
    "i_205",
    "i_206",
    "i_207",
    "i_208",
    "i_21",
    "i_210",
    "i_211",
    "i_212",
    "i_213",
    "i_214",
    "i_215",
    "i_216",
    "i_22",
    "i_23",
    "i_31",
    "i_311",
    "i_312",
    "i_313",
    "i_314",
    "i_32",
    "i_321",
    "i_322",
    "i_323",
    "i_324",
    "i_33",
    "i_331",
    "i_332",
    "i_333",
    "i_334",
    "i_341",
    "i_342",
    "i_343",
    "i_344",
    "i_351",
    "i_352",
    "i_353",
    "i_354",
    "i_361",
    "i_362",
    "i_363",
    "i_364",
    "i_371",
    "i_372",
    "i_373",
    "i_374",
    "i_401",
    "i_402",
    "i_403",
    "i_406",
    "i_407",
    "i_408",
    "i_41",
    "i_411",
    "i_412",
    "i_413",
    "i_416",
    "i_417",
    "i_418",
    "i_42",
    "i_421",
    "i_422",
    "i_423",
    "i_426",
    "i_427",
    "i_428",
    "i_43",
    "i_431",
    "i_432",
    "i_433",
    "i_441",
    "i_442",
    "i_443",
    "i_451",
    "i_452",
    "i_453",
    "i_461",
    "i_462",
    "i_463",
    "i_464",
    "i_465",
    "i_466",
    "i_467",
    "i_468",
    "i_469",
    "i_470",
    "i_471",
    "i_472",
    "i_480",
    "i_481",
    "i_482",
    "i_483",
    "i_484",
    "i_485",
    "i_486",
    "i_491",
    "i_501",
    "i_502",
    "i_503",
    "i_504",
    "i_51",
    "i_511",
    "i_512",
    "i_513",
    "i_514",
    "i_52",
    "i_521",
    "i_522",
    "i_523",
    "i_524",
    "i_53",
    "i_531",
    "i_532",
    "i_533",
    "i_534",
    "i_541",
    "i_542",
    "i_543",
    "i_544",
    "i_551",
    "i_552",
    "i_553",
    "i_554",
    "i_561",
    "i_562",
    "i_563",
    "i_564",
    "i_571",
    "i_572",
    "i_573",
    "i_574",
    "i_581",
    "i_582",
    "i_583",
    "i_584",
    "i_600",
    "i_601",
    "i_602",
    "i_603",
    "i_604",
    "i_605",
    "i_606",
    "i_607",
    "i_608",
    "i_609",
    "i_61",
    "i_610",
    "i_611",
    "i_612",
    "i_613",
    "i_614",
    "i_62",
    "i_63",
    "i_663",
    "i_675",
    "i_677",
    "i_678",
    "i_679",
    "i_680",
    "i_681",
    "i_685",
    "i_686",
    "i_688",
    "i_71",
    "i_72",
    "i_73",
    "i_81",
    "i_82",
    "i_83",
    "i_91",
    "i_92",
    "i_93",
    "i_n101213",
    "i_n101214",
    "i_n101215",
    "i_n101217",
    "i_n101220",
    "i_n101222",
    "i_n101223",
    "i_n101225",
    "i_n101232",
    "i_n101233",
    "i_n101235",
    "i_n101236",
    "i_n101237",
    "i_n101238",
    "i_n101239",
    "i_n101240",
    "i_n101241",
    "i_n104329",
    "i_n104330",
    "i_n104331",
    "i_n104332",
    "i_n104333",
    "i_n104334",
    "i_n104335",
    "i_n104336",
    "i_n104337",
    "i_n104338",
    "i_n104339",
    "i_n104340",
    "i_n104341",
    "i_n104342",
    "i_n104343",
    "i_n104344",
    "i_n104345",
    "i_n104346",
    "i_n112059",
    "i_n112060",
    "i_n112061",
    "i_n112062",
    "i_n112063",
    "i_n112064",
    "i_n112065",
    "i_n112066",
    "i_n112067",
    "i_n112068",
    "i_n112069",
    "i_n112070",
    "i_n112071",
    "i_n112072",
    "i_n112073",
    "i_n112074",
    "i_n112075",
    "i_n112076",
    "i_n112077",
    "i_n112078",
    "i_n112079",
    "i_n112080",
    "i_n112081",
    "i_n112082",
    "i_n112083",
    "i_n112084",
    "i_n112085",
    "i_n112086",
    "i_n112087",
    "i_n112088",
    "i_n112089",
    "i_n112090",
    "i_n112091",
    "i_n112092",
    "i_n112093",
    "i_n112094",
    "i_n112095",
    "i_n112096",
    "i_n112097",
    "i_n112098",
    "i_n112099",
    "i_n112100",
    "i_n113036",
    "i_n113037",
    "i_n113038",
    "i_n113039",
    "i_n113040",
    "i_n113041",
    "i_n113042",
    "i_n113043",
    "i_n113044",
    "i_n113045",
    "i_n113046",
    "i_n113047",
    "i_n113048",
    "i_n113049",
    "i_n113050",
    "i_n113051",
    "i_n113052",
    "i_n113053",
    "i_n113054",
    "i_n113055",
    "i_n113056",
    "i_n113057",
    "i_n113058",
    "i_n113059",
    "i_n113060",
    "i_n113061",
    "i_n114037",
    "i_n114038",
    "i_n114039",
    "i_n114040",
    "i_n114041",
    "i_n114042",
    "i_n114043",
    "i_n114044",
    "i_n114045",
    "i_n114046",
    "i_n114047",
    "i_n114048",
    "i_n114049",
    "i_n114050",
    "i_n114051",
    "i_n114052",
    "i_n114053",
    "i_n114054",
    "i_n114055",
    "i_n114056",
    "i_n114057",
    "i_n114058",
    "i_n114059",
    "i_n114060"
  ];

  final StreamController<List<Character>> _suggestionStreamController =
      StreamController.broadcast();
  Stream<List<Character>> get suggestionStream =>
      _suggestionStreamController.stream;

  DataProvider() {
    getCharacters();
    getWeapons();
    getMaterials();
  }

  Future<String> readJson(String folder, String filename) async {
    final String response = await rootBundle
        .loadString('assets/data/$folder/$filename.json', cache: false);
    return response;
  }

  Future<List<String>> readData(String folder, List<String> origin) async {
    List<String> data = [];
    for (var i = 0; i < origin.length; i++) {
      data.add(await readJson(folder, origin[i]));
    }

    return data;
  }

  getCharacters() async {
    final charactersList = await readData('characters', charactersData);

    characters =
        charactersList.map((e) => Character.fromRawJson(e.toString())).toList();
    notifyListeners();
  }

  getWeapons() async {
    final weaponsList = await readData('weapons', weaponsData);

    weapons = weaponsList.map((e) => Weapon.fromRawJson(e.toString())).toList();
    notifyListeners();
  }

  getMaterials() async {
    final materialsList = await readData('materials', materialsData);

    materials = materialsList
        .map((e) => MaterialItem.fromRawJson(e.toString()))
        .toList();
    notifyListeners();
  }
}
