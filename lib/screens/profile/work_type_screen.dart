import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/jobs_bloc/jobs_bloc.dart';
import 'package:instax/blocs/jobs_bloc/jobs_event.dart';
import 'package:instax/blocs/jobs_bloc/jobs_state.dart';
import 'package:instax/blocs/subjob_bloc/subjob_bloc.dart';
import 'package:instax/blocs/subjob_bloc/subjob_event.dart';
import 'package:instax/providers/temporary_job_selected_provider.dart';

// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class WorkTypeScreen extends StatelessWidget {
  const WorkTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<JobBloc, JobState>(
        listener: (context, state) {
          if (state.status == JobStatus.success &&
              state.selectedJobs.isNotEmpty) {
            context.read<SubJobBloc>().add(
                  GetSubjobByJobIds(
                      jobIds:
                          state.selectedJobs.map((e) => e.parentId).toList()),
                );

            // navigation to next screen
            Navigator.pushNamed(context, 'workType/favorite');
          }
        },
        builder: (context, state) {
          if (state.status == JobStatus.failure) {
            return const Center(child: Text('failed to fetch jobs'));
          }
          if (state.status == JobStatus.success) {
            TemporarySelectedJobsProvider selectedJobsProvider =
                Provider.of<TemporarySelectedJobsProvider>(context,
                    listen: false);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 100),
                    Text("ประเภทงานที่สนใจ",
                        style: TextStyle(
                          fontSize: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .fontSize,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 10),
                    Wrap(
                      children: state.jobs.map((job) {
                        return GestureDetector(
                          onTap: () {
                            if (selectedJobsProvider.selectedJobs
                                .contains(job)) {
                              selectedJobsProvider.removeSelectedJob(job);
                            } else {
                              selectedJobsProvider.addSelectedJob(job);
                            }
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
                                    // width = full width / 2
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.8),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          job.name,
                                          style: TextStyle(
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .fontSize,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        if (Provider.of<
                                                    TemporarySelectedJobsProvider>(
                                                context)
                                            .selectedJobs
                                            .contains(job))
                                          const Icon(
                                            Icons.check_circle,
                                            color: Colors.white,
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
                    const SizedBox(height: 20),
                    Text(
                      selectedJobsProvider.selectedJobs.isNotEmpty
                          ? "คุณเลือก ${selectedJobsProvider.selectedJobs.length} งาน "
                          : "คุณยังไม่ได้เลือกงาน",
                    ),
                    selectedJobsProvider.selectedJobs.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  context.read<JobBloc>().add(JobSelected(
                                      selectedJobs:
                                          selectedJobsProvider.selectedJobs));
                                },
                                child: const Text('ถัดไป'),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(height: 50)
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
