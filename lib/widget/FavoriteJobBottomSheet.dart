import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/jobs_bloc/jobs_bloc.dart';
import 'package:instax/blocs/jobs_bloc/jobs_event.dart';
import 'package:instax/blocs/subjob_bloc/subjob_bloc.dart';
import 'package:instax/blocs/subjob_bloc/subjob_state.dart';
import 'package:instax/providers/temporary_job_selected_provider.dart';
import 'package:job_repository/job_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class FavoriteJobBottomSheet extends StatelessWidget {
  const FavoriteJobBottomSheet({Key? key, required this.job}) : super(key: key);
  final Job job;

  @override
  Widget build(BuildContext context) {
    var temporaryGenderProvider =
        Provider.of<TemporarySelectedSubJobsProvider>(context);
    return Scaffold(
      body: BlocBuilder<SubJobBloc, SubJobState>(builder: (context, state) {
        // get sub job by parentJob
        final subjobByParentJob = state.subJobs
            .where((element) => element.jobParentId == job.jobId)
            .toList();

        return Stack(children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align children to the left
              children: [
                const SizedBox(height: 50),
                // ClipRRect to apply border radius to the top corners
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: Image(
                    image: NetworkImage(job.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.jobName,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                          "เชื่อมต่อกับผู้คนในวงการก่อสร้าง - ไม่ว่าคุณจะเป็นผู้รับเหมา, ช่าง, หรือผู้ที่กำลังมองหางานในสายนี้.")
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Divider(
                  color: Colors.grey[350], // Change color as needed
                  height: 20, // Adjust height as needed
                  thickness: 4, // Adjust thickness as needed
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40, // Adjust size as needed
                        height: 40, // Adjust size as needed
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[400], // Change color as needed
                        ),
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.bell,
                            color: Colors.black, // Change color as needed
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '5',
                            style: TextStyle(fontSize: 30),
                          ),
                          Text('งานใหม่')
                        ],
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      Container(
                        width: 40, // Adjust size as needed
                        height: 40, // Adjust size as needed
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[400], // Change color as needed
                        ),
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.bell,
                            color: Colors.black, // Change color as needed
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '1,000',
                            style: TextStyle(fontSize: 30),
                          ),
                          Text('สมาชิก/ช่าง')
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey[350], // Change color as needed
                  height: 20, // Adjust height as needed
                  thickness: 4, // Adjust thickness as needed
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "งานเฉพาะทาง",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "เลือกงานเฉพาะทางที่คุณสนใจ",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ...subjobByParentJob.map((subJob) {
                  return ListTile(
                    onTap: () {
                      // add unique subjob to selectedSubJobs
                      if (!temporaryGenderProvider.selectedSubJobs
                          .contains(subJob)) {
                        temporaryGenderProvider.addSelectedSubJob(subJob);
                      } else {
                        temporaryGenderProvider.removeSelectedSubJob(subJob);
                      }
                    },
                    title: Row(
                      children: [
                        Consumer<TemporarySelectedSubJobsProvider>(
                          builder: (context, provider, child) {
                            return Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(
                                    8), // Adjust the radius as needed
                                border: Border.all(
                                  color:
                                      provider.selectedSubJobs.contains(subJob)
                                          ? Color.fromRGBO(0, 86, 210, 1)
                                          : Colors.grey[200]!,
                                ),
                                color: provider.selectedSubJobs.contains(subJob)
                                    ? Color.fromRGBO(0, 86, 210, 1)
                                    : Colors.grey[200],
                              ),
                              child: Center(
                                child: provider.selectedSubJobs.contains(subJob)
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.check,
                                        color: Colors.transparent,
                                      ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(subJob.subJobName),
                      ],
                    ),
                  );
                }).toList(),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  )),
                  onPressed: () {
                    print(temporaryGenderProvider.selectedSubJobs);

                    context.read<JobBloc>().add(SubJobSelected(
                        selectedSubJobs:
                            temporaryGenderProvider.selectedSubJobs));

                    Navigator.pop(context);
                  },
                  child: const Text('เข้าร่วมประเภทงานนี้',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ),
          ),
        ]);
      }),
    );
  }
}
