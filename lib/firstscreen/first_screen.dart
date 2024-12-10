import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/classified.dart';
import 'package:mlmdiary/database/database.dart';
import 'package:mlmdiary/firstscreen/home_controller.dart';
import 'package:mlmdiary/home/home/home_screen.dart';
import 'package:mlmdiary/menu/menuscreens/advertising/advertising.dart';
import 'package:mlmdiary/menu/moreoption/more_option.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/widgets/bottom_nav_bar.dart';

// home_screen

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Obx(
        () => controller.newIndex.value == 0
            ? const HomeScreen()
            : controller.newIndex.value == 1
                ? const ClassifiedScreen()
                : controller.newIndex.value == 2
                    ? const DatabaseScreen()
                    : controller.newIndex.value == 3
                        ? const Advertising()
                        : const MoreOptionScreen(),
      ),
      bottomNavigationBar: BottomNavBar(
        onTap: (index) {
          controller.newIndex.value = index;
          controller.tappedIndex.value = index;
        },
      ),
    );
  }
}
