import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/database/controller/database_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
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
  final DatabaseController controller = Get.put(DatabaseController());

  @override
  void initState() {
    super.initState();
    controller.getMlmDatabase(1);
    _refreshData();
  }

  Future<void> _refreshData() async {
    await controller.getMlmDatabase(1);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'MLM Database',
        onTap: () {},
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.primaryColor,
        color: AppColors.white,
        onRefresh: _refreshData,
        child: Container(
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

                          _refreshData();
                        },
                        onChanged: (value) {
                          if (value.isEmpty) {
                            WidgetsBinding.instance.focusManager.primaryFocus;

                            _refreshData();
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
              Obx(() {
                if (controller.isLoading.value &&
                    controller.mlmDatabaseList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.mlmDatabaseList.isEmpty) {
                  return const Center(
                    child: Text(
                      'Data not found',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                        controller: controller.scrollController,
                        itemCount: controller.mlmDatabaseList.length +
                            (controller.isLoading.value ? 1 : 0),
                        padding: EdgeInsets.zero,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (index == controller.mlmDatabaseList.length) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          final user = controller.mlmDatabaseList[index];
                          String location =
                              '${user.city ?? ''}, ${user.state ?? ''}, ${user.country ?? ''}';
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                Routes.userprofilescreen,
                                arguments: controller.mlmDatabaseList[index],
                              );
                            },
                            child: UserCard(
                              userImage: user.imagePath ?? '',
                              userName: user.name ?? '',
                              location: location,
                              designation: user.immlm ?? '',
                              plan: user.plan ?? '',
                            ),
                          );
                        }),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
