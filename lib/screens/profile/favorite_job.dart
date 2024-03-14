import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/jobs_bloc/jobs_bloc.dart';
import 'package:instax/blocs/jobs_bloc/jobs_state.dart';
import 'package:instax/blocs/subjob_bloc/subjob_bloc.dart';
import 'package:instax/blocs/subjob_bloc/subjob_state.dart';
import 'package:instax/widget/FavoriteJobBottomSheet.dart';
import 'package:instax/widget/switchThemeColor.dart';
import 'package:job_repository/job_repository.dart';

// ignore: must_be_immutable
class FavoriteJob extends StatelessWidget {
  late List<Job> subjobs = [];

  FavoriteJob({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: const [
          SwitchThemeColor(),
        ],
      ),
      body: BlocConsumer<JobBloc, JobState>(
        listener: (context, state) {
          if (state.selectedSubJobs.isNotEmpty) {
            Navigator.pushNamed(context, 'workType/favorite/section');
          }
        },
        builder: (context, jobState) {
          if (jobState.status == JobStatus.success) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ประเภทงานที่สนใจ",
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.displaySmall!.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: jobState.selectedJobs.map((job) {
                        return GestureDetector(
                          onTap: () async {
                            await showModalBottomSheet(
                              scrollControlDisabledMaxHeightRatio: 0.8,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return FavoriteJobBottomSheet(
                                  job: job,
                                );
                              },
                            );
                          },
                          child: Card(
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image(
                                    image: AssetImage(job.icon ??
                                        'assets/images/construction_image.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.9),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          job.name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .displaySmall!
                                                .fontSize,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        BlocBuilder<SubJobBloc, SubJobState>(
                                          builder: (context, subJobState) {
                                            if (subJobState.status ==
                                                    SubJobStatus.success &&
                                                subJobState
                                                    .subJobs.isNotEmpty) {
                                              return SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: subJobState.subJobs
                                                      .map((subJob) {
                                                    // add uniquely the subjob to the list
                                                    if (!subjobs.contains(
                                                        subJob.parentId)) {
                                                      subjobs.add(subJob);
                                                    }
                                                    final isLastItem = subJob ==
                                                        subJobState
                                                            .subJobs.last;

                                                    return Container(
                                                      child: subJob.parentId ==
                                                              job.parentId
                                                          ? Text(
                                                              '${subJob.name}${isLastItem ? '' : ','}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyLarge!
                                                                    .fontSize,
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                    );
                                                  }).toList(),
                                                ),
                                              );
                                            } else {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
