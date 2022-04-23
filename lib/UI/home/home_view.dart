import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

import '/UI/home/home_viewmodel.dart';
import '/UI/map/map_view.dart';
import '../shared_trainings/shared_trainings_view.dart';
import '/UI/workouts/workouts_view.dart';

import '/widgets/bottom_navigation_bar.dart';
import '/widgets/drawer.dart';

class HomeView extends StatelessWidget {
  final int index;
  const HomeView({Key? key, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ViewModelBuilder<HomeViewmodel>.reactive(
        onModelReady: (model) => model.initializeData(index),
        viewModelBuilder: () => HomeViewmodel(),
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading:
                model.getBottomNavigationBarIndex != 0 ? false : true,
            iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.secondary,
            ),
            elevation: 0,
            title: Text(
              appBarTitle(model.getBottomNavigationBarIndex),
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            centerTitle: true,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          body: SafeArea(
            child: buildPageView(model.getBottomNavigationBarIndex),
          ),
          drawer: const CustomDrawer(),
          bottomNavigationBar: const CustomBottomNavigationBar(),
        ),
      ),
    );
  }

  Widget buildPageView(int index) {
    switch (index) {
      case 0:
        return const SharedTrainingsView();

      case 1:
        return const MapView();

      case 2:
        return const WorkoutsView();

      default:
        return const SharedTrainingsView();
    }
  }

  String appBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Shared Workouts';

      case 1:
        return 'Nearby Gyms';

      case 2:
        return 'My Workouts';

      default:
        return 'Shared Workouts';
    }
  }
}
