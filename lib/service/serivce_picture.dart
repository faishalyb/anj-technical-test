class PictureModel {
  final int? id;
  final String imagePath;
  final double latitude;
  final double longitude;
  final String datetime;

  PictureModel({
    this.id,
    required this.imagePath,
    required this.latitude,
    required this.longitude,
    required this.datetime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'latitude': latitude,
      'longitude': longitude,
      'datetime': datetime,
    };
  }
}
