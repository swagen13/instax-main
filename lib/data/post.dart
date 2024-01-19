class JobPost {
  final String availableWorks;
  final String id;
  final PostData post;

  JobPost({
    required this.availableWorks,
    required this.id,
    required this.post,
  });
}

class PostData {
  final String description1;
  final String description2;
  final String position;
  final String id;
  final String jobType;
  final String wage;

  PostData({
    required this.description1,
    required this.description2,
    required this.position,
    required this.id,
    required this.jobType,
    required this.wage,
  });
}

class JobDataService {
  static List<JobPost> jobPosts = [
    JobPost(
      availableWorks: "ช่างผสมปูน",
      id: "1",
      post: PostData(
        description1: "การช่วยเหลือในการยกและขนส่งวัสดุก่อสร้างต่างๆ",
        description2:
            "การเตรียมพื้นที่สำหรับการทำงาน, เช่น การขุด, การเตรียมคอนกรีต, และการตั้งแบบ",
        position: "พนักงานแบกปูน",
        id: "1",
        jobType: "ช่างผสมปูน",
        wage: "300",
      ),
    ),
    JobPost(
      availableWorks: "ช่างผสมปูน",
      id: "2",
      post: PostData(
        description1: "การช่วยเหลือในการยกและขนส่งวัสดุก่อสร้างต่างๆ",
        description2:
            "การเตรียมพื้นที่สำหรับการทำงาน, เช่น การขุด, การเตรียมคอนกรีต, และการตั้งแบบ",
        position: "พนักงานแบกปูน",
        id: "2",
        jobType: "ช่างผสมปูน",
        wage: "300",
      ),
    ),
    JobPost(
      availableWorks: "ช่างก่อสร้าง",
      id: "3",
      post: PostData(
        description1: "การช่วยเหลือในการยกและขนส่งวัสดุก่อสร้างต่างๆ",
        description2:
            "การเตรียมพื้นที่สำหรับการทำงาน, เช่น การขุด, การเตรียมคอนกรีต, และการตั้งแบบ",
        position: "พนักงานก่อสร้าง",
        id: "3",
        jobType: "ช่างก่อสร้าง",
        wage: "325",
      ),
    ),
    JobPost(
      availableWorks: "ช่างก่อสร้าง",
      id: "4",
      post: PostData(
        description1: "การช่วยเหลือในการยกและขนส่งวัสดุก่อสร้างต่างๆ",
        description2:
            "การเตรียมพื้นที่สำหรับการทำงาน, เช่น การขุด, การเตรียมคอนกรีต, และการตั้งแบบ",
        position: "พนักงานก่อสร้าง",
        id: "4",
        jobType: "ช่างก่อสร้าง",
        wage: "325",
      ),
    ),
    JobPost(
      availableWorks: "ช่างทาสี",
      id: "5",
      post: PostData(
        description1: "การช่วยเหลือในการยกและขนส่งวัสดุก่อสร้างต่างๆ",
        description2:
            "การเตรียมพื้นที่สำหรับการทำงาน, เช่น การขุด, การเตรียมคอนกรีต, และการตั้งแบบ",
        position: "พนักงานทาสี",
        id: "5",
        jobType: "ช่างทาสี",
        wage: "360",
      ),
    ),
  ];

  static List<JobPost> getPostsByAvailableWorks(String availableWorks) {
    jobPosts.where((post) => post.availableWorks == availableWorks).toList();

    return jobPosts;
  }

  static List<JobPost> getJobPosts() {
    return jobPosts;
  }

  static void addJobPost(JobPost jobPost) {
    jobPosts.add(jobPost);
  }

  // Add other methods as needed
}
