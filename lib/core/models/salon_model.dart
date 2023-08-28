class SalonModel {
  final String salonId;
  final String jobId;
  final String salonName;
  final double latitude;
  final double longitude;
  final String imageUrl;
  final String address;
  final int nbrStar;

  SalonModel(
      {required this.jobId,
      required this.salonId,
      required this.address,
      required this.imageUrl,
      required this.latitude,
      required this.longitude,
      required this.nbrStar,
      required this.salonName});

  factory SalonModel.fromJson(Map<String, dynamic> json) {
    return SalonModel(
        jobId: json["jobId"] ?? "",
        salonId: json["_id"] ?? "",
        address: json["address"] ?? "",
        imageUrl: json["imageUrl"] ?? "",
        latitude: json["lat"] ?? 0.0,
        longitude: json["long"] ?? 0.0,
        nbrStar: json["nbrStar"] ?? 1,
        salonName: json["name"] ?? "");
  }

  static SalonModel currentSalon() =>  SalonModel(jobId: "", salonId: "", address: "Calavi-UAC", imageUrl: "", latitude: 1.1, longitude: 1.7, nbrStar: 4, salonName: "Jonas Coiffure");
}
