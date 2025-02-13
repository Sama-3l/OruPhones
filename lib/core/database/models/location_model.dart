class LocationModel {
  final String id;
  final String type;
  final List<double> coordinates;

  LocationModel({
    required this.id,
    required this.type,
    required this.coordinates,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'coordinates': coordinates,
    };
  }

  factory LocationModel.fromJson(Map<String, dynamic> map) {
    return LocationModel(
      id: map['_id'] as String,
      type: map['type'] as String,
      coordinates: List<double>.from((map['coordinates'] as List)),
    );
  }
}
