import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../UI/home/home_viewmodel.dart';

class CustomBottomNavigationBar extends ViewModelWidget<HomeViewmodel> {
  const CustomBottomNavigationBar({Key? key}) : super(key: key, reactive: true);
  @override
  Widget build(BuildContext context, HomeViewmodel viewModel) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(-1, -1),
            color: Theme.of(context).colorScheme.background.withOpacity(0.1),
            blurRadius: 6,
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedFontSize: 10,
        selectedFontSize: 10,
        selectedLabelStyle: GoogleFonts.montserrat(
          fontSize: 10,
          color: Theme.of(context).colorScheme.secondary,
        ),
        unselectedLabelStyle: GoogleFonts.montserrat(),
        elevation: 0,
        currentIndex: viewModel.getBottomNavigationBarIndex,
        onTap: (int value) => viewModel.setBottomNavigationBarIndex(value),
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.home_outlined,
              color: Theme.of(context).colorScheme.secondary,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.add_location_outlined,
              color: Theme.of(context).colorScheme.secondary,
            ),
            activeIcon: Icon(
              Icons.add_location_rounded,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.date_range_outlined,
              color: Theme.of(context).colorScheme.secondary,
            ),
            activeIcon: Icon(
              Icons.date_range,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
