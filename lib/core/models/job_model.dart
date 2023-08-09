class JobModel {
  final String jobId;
  final String jobImageUrl;
  final String jobName;

  JobModel(
      {required this.jobImageUrl, required this.jobName, required this.jobId});

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
        jobImageUrl: json["imageUrl"] ?? "",
        jobName: json["jobName"],
        jobId: json["_id"]);
  }

  static List<JobModel> fromJsonList(List<dynamic> json) {
    return json.map((jobModel) => JobModel.fromJson(jobModel)).toList();
  }
}
