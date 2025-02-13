class ImageModel {
  final String id;
  final String thumbImage;
  final String fullImage;
  final String isVerified;
  final String option;

  ImageModel({
    required this.id,
    required this.thumbImage,
    required this.fullImage,
    required this.isVerified,
    required this.option,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '_id': id,
      'thumbImage': thumbImage,
      'fullImage': fullImage,
      'isVarified': isVerified,
      'option': option,
    };
  }

  factory ImageModel.fromJson(Map<String, dynamic> map) {
    return ImageModel(
      id: map['_id'] as String,
      thumbImage: map['thumbImage'] as String,
      fullImage: map['fullImage'] as String,
      isVerified: map['isVarified'] as String,
      option: map['option'] as String,
    );
  }
}
