import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/lists.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/customfilter/custom_filter.dart';
import 'package:mlmdiary/widgets/custom_location.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';
import 'package:mlmdiary/database/user_card.dart';

class DatabaseScreen extends StatefulWidget {
  const DatabaseScreen({super.key});

  @override
  State<DatabaseScreen> createState() => _DatabaseState();
}

class _DatabaseState extends State<DatabaseScreen> {
  final _loc = TextEditingController();
  final _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'MLM Database',
        onTap: () {},
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.background),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: CustomLocationInput(
                      controller: _loc,
                      prefixIcon: Icons.location_on_outlined,
                      suffixIcon: Icons.clear,
                      onClear: () {},
                      onTap: () async {},
                      onChanged: (value) {},
                      hintText: 'Location',
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Expanded(
                    child: CustomSearchInput(
                      controller: _search,
                      onSubmitted: (value) {
                        WidgetsBinding.instance.focusManager.primaryFocus
                            ?.unfocus();

                        setState(() {});
                      },
                      onChanged: (value) {
                        if (value.isEmpty) {
                          WidgetsBinding.instance.focusManager.primaryFocus;

                          setState(() {});
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return const BottomSheetContent();
                        },
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: size.height * 0.048,
                      width: size.height * 0.048,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.white, shape: BoxShape.circle),
                      child: SvgPicture.asset(Assets.svgFilter),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      final user = userList[index];
                      return UserCard(
                          userImage: user.userImage,
                          userName: user.userName,
                          location: user.location,
                          designation: user.designation,
                          plan: user.plan);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
