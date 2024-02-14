import 'package:flutter_destroyer/components/interface.dart';

class VoHon implements JsonMap, DauLaChung {
  String ten = '';
  double heso = 0.0;

  int capdo = 0;
  String phamchat = 'Phẩm Võ Hồn';

  final loaivohon = [
    KhiVoHon(),
    ThuVoHon(),
  ];

  static final honhieu = [
    'Nhất', // Khởi đầu
    'Nhị', // Hồn tôn
    'Tam', // 3 hh trăm năm và 3 cp trên cấp 100
    'Tứ', // Hồn tông, 3 cp trên cấp 500 và linh hải cảnh
    'Ngũ', // Hồn vương và 4 hh nghìn năm
    'Lục', // Hồn đế, 4 hh vạn năm và linh uyên cảnh
    'Thất', // Hồn thánh, 7 hh vạn năm và 3 cp trên cấp 5000
    'Bát', // Hồn đấu la, 1 hh 10 vạn năm và linh vực cảnh
    'Cửu', // Siêu cấp đấu la, 6 hh 10 vạn năm và 3 cp trên vạn cấp
    'Thập', // Cực hạn đấu la, 9 hh 10 vạn năm, thần nguyên cảnh và 3 cp trên 10 vạn cấp
  ];

  static final hontro = [
    1.0,
    5.0,
    7.0,
    10.0,
    15.0,
    20.0,
    25.0,
    30.0,
    35.0,
    40.0,
  ];

  VoHon();

  VoHon.fromMap(Map<String, dynamic> map) {
    ten = map['ten'] as String;
    heso = map['heso'] as double;
    capdo = map['capdo'] as int;
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ten': ten,
      'heso': heso,
      'capdo': capdo,
    };
  }

  @override
  void reset() {
    ten = '';
    heso = 0.0;
    capdo = 0;
  }
}

class LoaiHon {
  String loaivohon;
  List<String> baogom = [];

  LoaiHon({
    required this.loaivohon,
  });
}

class KhiVoHon extends LoaiHon {
  KhiVoHon() : super(loaivohon: 'Khí Võ Hồn') {
    // 164 khí võ hồn
    baogom = [
      // 4-A
      // Air Element
      // Amorous Sword
      // Astroblade
      // Altas Divine Spear

      // 14-B
      // Big Dipper Umbrella
      // Black Dragon Shield
      // Black Flute
      // Blade Soul
      // Bloodthirsty Battle Axes
      'Lam Ngân Thảo', // Blue Silver Grass
      'Lam Ngân Hoàng', // Blue Silver Emperor
      // Bone Staff
      // Boomerang
      // Boundless Sea
      // Boxing Gloves
      // Bright Mirror
      // Broken Sword
      // Brush
      // Bubble

      // 10-C
      // Cherry Blossom
      // Chicken Leg
      // Chopsticks
      'Kỳ Nhung Thông Thiên Cúc', // Chrysanthemum
      // Cigar
      'Hạo Thiên Chùy', // Clear Sky Hammer
      // Cloud Fan
      // Coiling Dragon Staff
      // Cold Rhyme Guzheng
      // Crystal Ball

      // 13-D
      // Dark Lightning Element
      // Dark Cloak
      // Darkness Bell
      // Dazzling Golden Rope
      // Death Flame
      // Demon Guqin Mantra
      // Demon Scythe
      // Demonslayer Sun
      // Diamond Chisel
      // Dragon Pattern Staff
      // Dragon Slaying Saber
      // Dragon Staff
      // Dread Knight

      // 7-E
      // Earth Element
      // Earth Hammer
      // Eight-Petal Plum Blossom Sliver Hammer
      // Elf King's Bow
      // Emerald Demon Daggers
      // Emerald Jade Phoenix Zither
      // Emperor Sword

      // 6-G
      // Gemstone
      // Glacial Sword
      // God Sword
      // Golden Leaf
      // Green Mist
      // Grimoire

      // 11-H
      // Half Moon Blades
      // Halo
      'Trị Liệu Quyền Trượng', // Healing Sceptre
      // Heartless Sword
      // Heavenly Armor Shield
      // Heaven Star Furnace
      // Heavenly Gauze Twin Covers
      // Heavenfiend Lonestar
      // Heaven's Book
      // Holy Crystal
      // Horror Piranha

      // 5-I
      // Ice Element
      // Ice Staff
      // Illusionary Snake
      // Iron Hammer
      // Iron Wake Shield

      // 1-J
      // Jade Phoenix Zither

      // 1-K
      // Knife

      // 5-L
      // Light Dragon Dagger
      // Light Element
      // Light of Shattered Stars
      // Lightning Element
      // Lightning Knife

      // 7-M
      // Maze Pearl
      // Metal Element
      // Meteor Hammer
      // Moon
      'Nguyệt Nhận', // Moon Blade
      // Mo Sword
      // Myriad Soul Banner

      // 6-N
      // Needle
      // Netherworld Sword
      // Nether Demon Spear
      'Cửu Tâm Hải Đường', // Nine Heart Flowering Apple
      // Nine Phoenix Dancing Flute
      // North Tip Saber

      // 1-O
      // Orange

      // 3-P
      // Purgatory Ji
      // Purpleflower Bow
      // Purple Star Spirit Bow

      // 1-Q
      // Quill

      // 40-S
      // Sacred Molding Pen
      'Xúc Xích', // Sausage
      // Scarlet Flame Thistle
      // Sea Scepter
      // Sea Lance
      'Trượng Xà Đầu', // Serpent Cane
      'Thất Sát Kiếm', // Seven Kill Sword
      // Seven Star Bamboo
      // Seven Star Sword
      'Thất Bảo Lưu Ly Tháp', // Seven Treasure Glazed Tile Pagoda
      'Cửu Bảo Lưu Ly Tháp', // Nine Treasure Glazed Tile Pagoda
      // Shadow
      // Shadow Dragon Dagger
      // Shining Sun
      // Skycrosser Divine Spear
      // Skyfrost Sword
      // Sky Blue Vine
      'Xà Mâu', // Snake Lance
      // Snow Element
      // Snow Lotus
      // Solar Man-Eating Flower
      // Soulchasing Sword
      // Soulsucking Bell
      'Phá Hồn Thương', // Soul Breaking Spear
      // Soul Sealing Cauldron
      // Space Element
      // Space-Time Silverplate
      // Spectral Lance
      // Star Crown
      // Star Luo
      // Star Luo Chess
      // Star Staff
      // Starsaint Sword
      // Stargod Sword
      // Starwheel Ice Staff
      // Stuffed Bun
      // Summon Gold Coin
      // Summoning Door
      // Sun Wood Saber
      // Sunflower
      // Sweet Pea

      // 11-T
      // Tail Stinger
      // Thousandstrike Lance
      // Thunder Beads
      // Thunder Element
      // Thunder Flame Spear
      // Thunder Umbrella
      // Thunderflash Sword
      // Tide
      // Time Fleeing Clock
      // Tree of Life
      // Treasured Book

      // 1-U
      // Underworld

      // 1-V
      // Vajra Shield

      // 7-W
      // Water Element
      // Weeping Blood Sword
      // White Dragon Spear
      // Willow Tree
      // Wind Sword
      // Wishful Disk
      'Đàn Lễ Nhạc', // Wishful Ring
      // Wood Element

      // 1-X
      // Xun
    ];
  }
}

class ThuVoHon extends LoaiHon {
  ThuVoHon() : super(loaivohon: 'Thú Võ Hồn') {
    // 160 thú võ hồn
    baogom = [
      // 7-A
      // Abomination
      // Anaconda
      // Angel of Hope
      // Ant Emperor
      // Armored Dragon
      // Abyss Demon Dragon Shark
      // Abyss Ice Demon Dragon

      // 22-B
      // Battle Tiger
      // Bear *
      'Gấu Kim Cang Đại Lục', // Vigorous Vajra Bear
      // Berserk Lightning Panther
      // Black Flame Phoenix
      'Hắc Yêu', // Black Goblin
      // Black Leopard
      // Black Lined Ghost Leopard
      // Black Tortoise
      // Blaze Tiger
      // Blazing Fire Dragon
      // Blood Demon
      // Bloody Demon Puppet
      // Blood Devil Mad Bear
      // Blood-devouring Lion
      'Lam Điện Phách Vương Long', // Blue Lightning Tyrant Dragon
      // Blue Palmed Frog
      // Braineater
      // Bright Goddess Butterfly
      // Bright Phoenix
      // Brutal Dream
      'Cốt Long', // Bone Dragon
      // Bone Dragon King

      // 2-C
      // Cat
      // Celestial Dragon

      // 13-D
      // Dark Emperor Dragon
      // Darkdemon Tiger
      // Darkness Crow
      // Darkness Holy Dragon
      // Dark Phoenix
      'Tử Vong Chu Hoàng', // Death Spider Emperor
      // Demonic Maggot
      // Demon Spirit Great White Shark
      // Devil Ray
      'Kim Cương Ma Mút', // Diamond Mammoth
      // Dragon Soul
      // Dragonwolf
      // Duskgold Bear

      // 6-E
      // Eagle
      // Emerald Phoenix
      // Evil Butterfly
      'Tà Hỏa Phượng Hoàng', // Evil Fire Phoenix
      // Evil Phoenix
      // Evil Servant

      // 11-F
      // Fallen Angel
      // Fierce Orangutan
      // Fire Crane
      'Hỏa Long', // Fire Dragon
      'Hỏa Ảnh', // Fire Shadow
      // Five Elements Qilin
      // Flame Leopard
      'Hỏa Diệm Lãnh Chúa', // Flame Lord
      // Flaming Golden Bird
      // Fox *
      'Yêu Hồ', // Charming Fox
      // Frost Bear

      // 13-G
      'Quỷ Mị', // Ghost Demon
      // Giant Sea Turtle
      // Godly Taotie Bull
      // Golden Crocodile King
      // Golden Crow
      // Golden Dragon
      // Golden Eagle
      // Golden Lion King
      // Golden Saint Dragon
      // Golden Skeleton King
      // Greenflame Dragon
      // Greenshadow Godly Hawk
      // Green Shadow Snake

      // 8-H
      // Healing Angel
      // Heavenly Centipede
      // Heavenly Snow Woman
      // Heavenly Swan
      'U Minh Linh Miêu', // Hell Civet
      // Hell Flame Beast
      // Holy Angel
      // Holy Phoenix

      // 6-I
      'Băng Phượng Hoàng', // Ice Phoenix
      // Ice Scorpion Emperor
      // Illusion Cat
      // Illusionary Snake
      // Iron Dragon
      // Iron Shelled Snail

      // 3-J
      // Jade Crystal Qilin
      'Bích Lân Xà', // Jade Phosphor Serpent
      'Bích Lân Xà Hoàng', // Jade Phosphor Serpent Emperor
      // Jasper Bluebird

      // 4-L
      // Light Holy Dragon
      // Light Unicorn
      // Lightning Leopard
      'La Tam Pháo', // Luo San Pao

      // 4-M
      // Meteor
      // Monkey
      // Mountain Dragon King
      // Mystic Deep Turtle

      // 3-N
      'Tiêm Vĩ Vũ Yến', // Needle-Tailed Swift
      // Nightmare Demon
      // Ninth Heaven Rainbow Phoenix

      // 4-O
      'Độc Giác Hỏa Bạo Long', // One-Horned Tyrant Dragon
      // Orangutan *
      'Đại Lực Tinh Tinh', // Vigorous Orangutan
      // Overlord Dragon
      'Miêu Ưng', // Owl

      // 3-P
      // Phoenix
      // Porcupinefish
      // Purplebrilliant Heaven Destroying Dragon

      // 8-R
      // Rabbit *
      'Nhu Cốt Thỏ', // Soft Boned Rabbit
      // Radiant Phoenix
      // Rainbow Dragon
      // Rat
      // Red Eyed Ice Toad
      // Rhinoceros *
      'Bản Giáp Cự Tê', // Armor Plated Giant Rhinoceros
      // Rogue Dragon
      // Rubber Elephant

      // 24-S
      // Sabertooth Earth Dragon
      // Sapphire Phoenix
      // Scarlet Armored Dragon
      // Scorpion Tiger
      // Sea Dragon
      // Sea God
      // Sea Serpent
      // Sea Star
      // Seahorse
      // Seal
      'Lục Dực Thiên Sứ', // Seraphim
      // Shadow Phantasm Eagle
      // Sheep
      'Cổ Lâu', // Skeleton
      // Skeleton King
      // Skyscraping Battle Eagle
      // Snow Leopard
      'Phệ Hồn Chu Hoàng', // Soul Devouring Spider Emperor
      // Spatial Unicorn
      // Spectre
      // Spider
      // Spirit of Retribution
      'Tật Phong Song Đầu Lang', // Stormwind Doubleheaded Wolf
      // Sword Beak Hummingbird

      // 6-T
      // Three Legged Golden Toad
      'Lôi Ưng', // Thunder Hawk
      // Thunder Lion
      // Thunder Spider
      // Thunder Wolf
      // Titan Giant Ape

      // 1-U
      // Underworld Snake

      // 3-V
      // Vampire Bat
      // Velociraptor
      // Vigorous Demon Ape

      // 7-W
      // White Tiger *
      'Tà Mâu Bạch Hổ', // Evil-Eyed White Tiger
      // White Armored Dragon
      'Phong Linh Điểu', // Wind Chime Bird
      // Wind Dragon
      // Witch Demon
      // Witch
      // Wolf *
      'Liệt Hỏa Thương Lang', // Inferno Grey Wolf
      'Độc Lang', // Lone Wolf

      // 1-X
      // Xuan Wu

      // 1-Y
      // Yin-Yang Five Elements Qilin
    ];
  }
}

class BanTheVoHon extends LoaiHon {
  BanTheVoHon() : super(loaivohon: 'Bản Thể Võ Hồn') {
    baogom = [];
  }
}
