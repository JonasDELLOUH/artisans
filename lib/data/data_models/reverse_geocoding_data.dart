class ReverseGeocodingData {
  List<Results>? results;
  String? status;

  ReverseGeocodingData({this.results, this.status});

  ReverseGeocodingData.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }

  String get formattedAddress {
    if (results?.isEmpty ?? true) return "";
    return results?.first.formattedAddress ?? "";
  }
}

class Results {
  String? formattedAddress;

  Results({this.formattedAddress});

  Results.fromJson(Map<String, dynamic> json) {
    formattedAddress = json['formatted_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['formatted_address'] = formattedAddress;
    return data;
  }
}
