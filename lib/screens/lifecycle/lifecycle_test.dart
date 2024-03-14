import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/app_state_bloc/app_state_bloc.dart';
import 'package:lifecycle/lifecycle.dart';

class LifeCycleTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppStateBloc, AppState>(
      listener: (context, state) {
        log('AppLifecycleStatess: ${state.state}');
        // if (state.state == AppLifecycleState.resumed) {
        //   log('App Resumed');
        // } else {
        //   log('App Paused');
        // }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lifecycle Test'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondScreen()),
              );
            },
            child: Text('Navigate to Second Screen'),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go Back'),
        ),
      ),
    );
  }
}
