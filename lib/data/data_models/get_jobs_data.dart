import '../../core/models/job_model.dart';

class GetJobsData {
  List<JobModel>? jobs;

  GetJobsData({this.jobs});

  GetJobsData.fromJson(List l) {
    jobs = <JobModel>[];
    for (var element in l) {
      jobs!.add(JobModel.fromJson(element));
    }
  }
}
