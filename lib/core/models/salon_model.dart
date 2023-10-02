class SalonModel {
  final String salonId;
  final String jobId;
  final String email;
  final String phone;
  final String whatsappNumber;
  final String desc;
  final String salonName;
  final double latitude;
  final double longitude;
  final String imageUrl;
  final String address;
  final int nbrStar;

  SalonModel(
      {required this.jobId,
      required this.salonId,
        required this.desc,
      required this.address,
      required this.imageUrl,
      required this.latitude,
      required this.longitude,
      required this.nbrStar,
      required this.salonName, required this.phone, required this.whatsappNumber, required this.email});

  factory SalonModel.fromJson(Map<String, dynamic> json) {
    return SalonModel(
        jobId: json["jobId"] ?? "",
        salonId: json["_id"] ?? "",
        desc: json["desc"] ?? "",
        address: json["address"] ?? "",
        imageUrl: json["imageUrl"] ?? "",
        latitude: json["lat"] ?? 0.0,
        longitude: json["long"] ?? 0.0,
        nbrStar: json["nbrStar"] ?? 1,
        salonName: json["name"] ?? "",
      phone: json["phone"] ?? "",
        whatsappNumber: json["whatsappNumber"] ?? "",
      email: json["email"] ?? ""
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "_id": salonId,
      "jobId": jobId,
      "address": address,
      "imageUrl": imageUrl,
      "latitude": latitude,
      "longitude": longitude,
      "nbrStar": nbrStar,
      "salonName": salonName,
      "phone": phone,
      "whatsappNumber": whatsappNumber
    };
  }

  static SalonModel currentSalon() =>  SalonModel(jobId: "", salonId: "", desc: "this.desc,", address: "Calavi-UAC", imageUrl: "", latitude: 1.1, longitude: 1.7, nbrStar: 4, salonName: "Jonas Coiffure", phone: "", email: "", whatsappNumber: '');
}
