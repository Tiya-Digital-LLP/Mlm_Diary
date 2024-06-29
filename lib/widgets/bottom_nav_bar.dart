import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/firstscreen/home_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/lists.dart';

class BottomNavBar extends StatefulWidget {
  final Function onTap;
  const BottomNavBar({super.key, required this.onTap});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final HomeScreenController controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          bottomBarImages.length,
          (index) => Obx(
            () => GestureDetector(
              onTap: () {
                widget.onTap(index);
              },
              child: SizedBox(
                height: size.height * 0.07,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      bottomBarImages[index],
                      // ignore: deprecated_member_use
                      color: (controller.tappedIndex.value == index)
                          ? AppColors.primaryColor
                          : AppColors.bottomIcon,
                      height: 26,
                    ),
                    Text(
                      bottomBarTexts[index],
                      style: TextStyle(
                        fontSize: 10,
                        color: (controller.tappedIndex.value == index)
                            ? AppColors.primaryColor
                            : AppColors.bottomIcon,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
