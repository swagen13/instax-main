import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/Job_post_bloc/job_post_bloc.dart';
import 'package:instax/blocs/Job_post_bloc/job_post_state.dart';
import 'package:instax/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:instax/blocs/job_post_bloc/job_post_event.dart';
import 'package:instax/blocs/jobs_bloc/jobs_bloc.dart';
import 'package:instax/blocs/jobs_bloc/jobs_state.dart';
import 'package:instax/features/shareToX.dart';
import 'package:instax/widget/switchThemeColor.dart';

class FavoriteWorksSelectionScreen extends StatelessWidget {
  const FavoriteWorksSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List<String> avatarImages = [
    //   'assets/images/avatar.avif',
    //   'assets/images/mechanics_image.jpg',
    //   'assets/images/avatar.avif',
    //   'assets/images/mechanics_image.jpg',
    //   'assets/images/avatar.avif',
    //   'assets/images/avatar.avif',
    //   'assets/images/avatar.avif',
    // ];

    return Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.more_vert,
                  color: Colors.black, size: 30, semanticLabel: 'More'),
            ],
          ),
          actions: const [
            SwitchThemeColor(),
          ],
        ),
        body: BlocBuilder<JobBloc, JobState>(builder: (context, jobState) {
          print('jobState : $jobState');
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image:
                      const AssetImage('assets/images/construction_image.jpg'),
                  width: MediaQuery.of(context).size.width,
                  height: 200, // Set the desired height
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobState.selectedJobs.first.name,
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          'เชื่อมต่อกับผู้คนในวงการก่อสร้าง - ไม่ว่าคุณจะเป็นผู้รับเหมา, ช่าง, หรือผู้ที่กำลังมองหางานในสายนี้.',
                          style: TextStyle(
                            fontSize:
                                Theme.of(context).textTheme.bodyLarge!.fontSize,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      // SizedBox(
                      //   width: 300, // Adjust the width as needed
                      //   height: 50, // Adjust the height as needed
                      //   child: Stack(
                      //     children: List.generate(
                      //       min(
                      //         4,
                      //         avatarImages.length,
                      //       ), // Use min to ensure it doesn't exceed 4
                      //       (index) => Positioned(
                      //         left: 70,
                      //         child: Transform.translate(
                      //           offset: Offset(
                      //             -index * 25.0,
                      //             0,
                      //           ), // Use negative offset for overlap
                      //           child: ClipOval(
                      //             child: Container(
                      //               decoration: BoxDecoration(
                      //                 shape: BoxShape.circle,
                      //                 border: Border.all(
                      //                   color: Colors.white,
                      //                   width: 2.0,
                      //                 ),
                      //               ),
                      //               child: ClipOval(
                      //                 child: Image.asset(
                      //                   avatarImages[index],
                      //                   height: 40,
                      //                   width: 40,
                      //                   fit: BoxFit.cover,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("ผู้ที่กำลังมองหางาน: 390 คน")
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey[350],
                  height: 20,
                  thickness: 2,
                ),
                BlocBuilder<JobPostBloc, JobPostState>(
                    builder: (context, jobPostState) {
                  if (jobPostState.status == JobPostStatus.initial)
                    context.read<JobPostBloc>().add(getJobPostByUserId(
                        context.read<AuthenticationBloc>().state.user!.uid));
                  return Column(
                    children: [
                      Wrap(
                        spacing: 5.0,
                        children: List.generate(
                          jobState.selectedSubJobs.length,
                          (index) => FilledButton.icon(
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                              backgroundColor: jobPostState.jobPosts
                                      .where((element) =>
                                          element.subJob ==
                                          jobState.selectedSubJobs[index].id)
                                      .isNotEmpty
                                  ? Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer
                                  : Colors.white,
                              side: BorderSide(
                                color: jobPostState.jobPosts
                                        .where((element) =>
                                            element.subJob ==
                                            jobState.selectedSubJobs[index].id)
                                        .isNotEmpty
                                    ? Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer
                                    : Colors.black,
                                width: 0,
                              ),
                            ),
                            onPressed: () {
                              context.read<JobPostBloc>().add(
                                  JobPostsGetRequested(
                                      jobState.selectedSubJobs[index].id));
                            },
                            icon: Image.asset(
                              "assets/images/user-icon.png",
                              height: 15,
                              fit: BoxFit.cover,
                            ),
                            label: Text(
                              jobState.selectedSubJobs[index].name,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                        // close the scroll view
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: jobPostState.jobPosts.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.grey[100],
                            elevation: 0.0,
                            child: ListTile(
                              title: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        // ClipOval(
                                        //   child: Image.asset(
                                        //     'assets/images/avatar.avif',
                                        //     height: 50,
                                        //     width: 50,
                                        //     fit: BoxFit.cover,
                                        //   ),
                                        // ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "สมชาย  จงจอหอ",
                                              style: TextStyle(
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontSize,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "2 ชม.",
                                              style: TextStyle(
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .fontSize,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ตำแหน่งงาน : ",
                                        style: TextStyle(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .fontSize,
                                        )),
                                    Text(jobPostState.jobPosts[index].position,
                                        style: TextStyle(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .headlineLarge!
                                              .fontSize,
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        jobPostState
                                            .jobPosts[index].description1,
                                        style: TextStyle(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .fontSize,
                                        )),
                                    Text(
                                        jobPostState
                                            .jobPosts[index].description2,
                                        style: TextStyle(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .fontSize,
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 3, 15, 3),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondaryContainer,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            "฿${jobPostState.jobPosts[index].wage} / วัน",
                                            style: TextStyle(
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .fontSize,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 3, 15, 3),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            "รังสิต",
                                            style: TextStyle(
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .fontSize,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(32.0),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                              minimumSize: const Size(80, 30),
                                              backgroundColor: Colors.grey[100],
                                              side: const BorderSide(
                                                color: Colors.black,
                                                width: 0,
                                              ),
                                              elevation: 0,
                                            ),
                                            onPressed: () {
                                              context.read<JobPostBloc>().add(
                                                  SelectJobPosts(
                                                      jobPostState
                                                          .jobPosts[index],
                                                      context
                                                          .read<
                                                              AuthenticationBloc>()
                                                          .state
                                                          .user!
                                                          .uid));
                                            },
                                            icon: jobPostState.selectedJobPosts
                                                    .where((element) =>
                                                        element.id ==
                                                        jobPostState
                                                            .jobPosts[index].id)
                                                    .isNotEmpty
                                                ? const Icon(
                                                    Icons.close,
                                                  )
                                                : const Icon(
                                                    Icons.add,
                                                  ),
                                            label: Text(
                                              jobPostState.selectedJobPosts
                                                      .where((element) =>
                                                          element.id ==
                                                          jobPostState
                                                              .jobPosts[index]
                                                              .id)
                                                      .isNotEmpty
                                                  ? "ยกเลิก"
                                                  : " เลือก",
                                              style: TextStyle(
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .fontSize,
                                              ),
                                            )),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, 'post_detail',
                                                  arguments: {
                                                    'postId': jobPostState
                                                        .jobPosts[index].id
                                                  });
                                            },
                                            child: Text("เพิ่มเติม")),
                                        // const Icon(
                                        //   Icons.bookmark_outline,
                                        //   color: Colors.black,
                                        //   size: 40,
                                        // ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        ElevatedButton.icon(
                                            onPressed: () {
                                              print(
                                                  'job post is ${jobPostState.jobPosts[index]}');
                                              shareToX(context,
                                                  jobPostState.jobPosts[index]);
                                            },
                                            icon: const Icon(
                                              Icons.share,
                                              color: Colors.black,
                                              size: 30,
                                            ),
                                            label: const Text(''))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 100,
                      )
                    ],
                  );
                }),
              ],
            ),
          );
        }));
  }
}
