import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/Job_post_bloc/job_post_bloc.dart';
import 'package:instax/blocs/Job_post_bloc/job_post_event.dart';
import 'package:instax/blocs/Job_post_bloc/job_post_state.dart';
import 'package:instax/blocs/jobs_bloc/jobs_bloc.dart';
import 'package:instax/blocs/jobs_bloc/jobs_state.dart';

class FavoriteWorksSelectionScreen extends StatelessWidget {
  const FavoriteWorksSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(Icons.more_vert,
                  color: Colors.black, size: 30, semanticLabel: 'More'),
            ],
          ),
        ),
        body: BlocBuilder<JobBloc, JobState>(builder: (context, jobState) {
          print(jobState.selectedJobs);
          print(jobState.selectedSubJobs);

          // get the selected jobs from the jobState
          final selectedJobs = jobState.selectedSubJobs
              .map((e) => jobState.jobs
                  .where((element) => element.jobId == e.jobParentId))
              .toList()
              .first;

          print(selectedJobs);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
