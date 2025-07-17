class SuperheroDetailResponse {
  final String id;
  final String name;
  final String url;
  final String realName;
  final String firstAppearance;
  final String publisher;
  final String occupation;
  final String raza;
  final String alterEgos;
  final List<String> alias;
  final String placeOfBirth;
  final String gender;
  final List<String> height;
  final List<String> weight;
  final String base;
  final String relatives;
  final PowerStatsResponse powerStatsResponse;

  SuperheroDetailResponse({
    required this.id,
    required this.name,
    required this.url,
    required this.realName,
    required this.firstAppearance,
    required this.publisher,
    required this.occupation,
    required this.raza,
    required this.alterEgos,
    required this.alias,
    required this.placeOfBirth,
    required this.gender,
    required this.height,
    required this.weight,
    required this.base,
    required this.relatives,
    required this.powerStatsResponse,
  });

  factory SuperheroDetailResponse.fromJson(Map<String, dynamic> json) {
    return SuperheroDetailResponse(
      id: json["id"],
      name: json["name"],
      url: json["image"]["url"],
      realName: json["biography"]["full-name"],
      firstAppearance: json["biography"]["first-appearance"],
      publisher: json["biography"]["publisher"],
      occupation: json["work"]["occupation"],
      raza: json["appearance"]["race"],
      alterEgos: json["biography"]["alter-egos"],
      alias: _parseStringList(json["biography"]["aliases"]),
      placeOfBirth: json["biography"]["place-of-birth"],
      gender: json["appearance"]["gender"],
      height: _parseStringList(json["appearance"]["height"]),
      weight: _parseStringList(json["appearance"]["weight"]),
      base: json["work"]["base"],
      relatives: json["connections"]["relatives"],
      powerStatsResponse: PowerStatsResponse.fromJson(json["powerstats"]),
    );
  }
  // Método helper para convertir dynamic a List<String>
  static List<String> _parseStringList(dynamic value) {
    if (value == null) return [];

    if (value is String) {
      return [value];
    }

    if (value is List) {
      return value.map((item) => item.toString()).toList();
    }

    return [value.toString()];
  }
}

class PowerStatsResponse {
  final String intelligence;
  final String strength;
  final String speed;
  final String durability;
  final String power;
  final String combat;

  PowerStatsResponse({
    required this.intelligence,
    required this.strength,
    required this.speed,
    required this.durability,
    required this.power,
    required this.combat,
  });

  factory PowerStatsResponse.fromJson(Map<String, dynamic> json) {
    return PowerStatsResponse(
      intelligence: json["intelligence"],
      strength: json["strength"],
      speed: json["speed"],
      durability: json["durability"],
      power: json["power"],
      combat: json["combat"],
    );
  }
}
