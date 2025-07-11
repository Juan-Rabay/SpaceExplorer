class RoverPhoto {
  final String id;
  final String imgSrc;
  final String roverName;
  final String cameraName;
  final String earthDate;

  RoverPhoto({
    required this.id,
    required this.imgSrc,
    required this.roverName,
    required this.cameraName,
    required this.earthDate,
  });

  factory RoverPhoto.fromJson(Map<String, dynamic> json) {
    return RoverPhoto(
      id: json['id'].toString(),
      imgSrc: json['img_src'],
      roverName: json['rover']['name'],
      cameraName: json['camera']['full_name'],
      earthDate: json['earth_date'],
    );
  }
}
