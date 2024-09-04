class FeaturesAPI {
  final List<Attributes> features;

  FeaturesAPI({required this.features});

  factory FeaturesAPI.fromJson(Map<String, dynamic> json) {
    return FeaturesAPI(
      features: List<Attributes>.from(
        json['features'].map(
          (item) => Attributes.fromModel(item['attributes']),
        ),
      ),
    );
  }
}

class Attributes {
  final int lastupdate;
  final int recoverd;
  final int deaths;
  final int confirmed;

  Attributes({
    required this.lastupdate,
    required this.recoverd,
    required this.deaths,
    required this.confirmed,
  });

  factory Attributes.fromModel(Map<String, dynamic> json) {
    return Attributes(
      lastupdate: json['Last_Update'] ?? 0, // Corrected field name
      recoverd: json['Recovered'] ?? 0,
      deaths: json['Deaths'] ?? 0,
      confirmed: json['Confirmed'] ?? 0,
    );
  }
}
