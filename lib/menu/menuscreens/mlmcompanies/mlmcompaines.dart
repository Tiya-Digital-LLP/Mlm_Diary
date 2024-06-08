import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/controller/company_controller.dart';
import 'package:mlmdiary/menu/menuscreens/mlmcompanies/mlmcompanies_card.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';
import 'package:mlmdiary/widgets/customfilter/custom_filter.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';

class MlmCompanies extends StatefulWidget {
  const MlmCompanies({super.key});

  @override
  State<MlmCompanies> createState() => _MlmCompaniesState();
}

class _MlmCompaniesState extends State<MlmCompanies> {
  final _search = TextEditingController();
  final CompanyController controller = Get.put(CompanyController());

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    await controller.getAdminCompany(1);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'MLM Companies',
      ),
      body: RefreshIndicator(
        backgroundColor: AppColors.primaryColor,
        color: AppColors.white,
        onRefresh: _refreshData,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomSearchInput(
                      controller: _search,
                      onSubmitted: (value) {
                        WidgetsBinding.instance.focusManager.primaryFocus
                            ?.unfocus();
                      },
                      onChanged: (value) {
                        if (value.isEmpty) {
                          WidgetsBinding.instance.focusManager.primaryFocus;
                        }
                      },
                    ),
                  ),
                  5.sbw,
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
              10.sbh,
              Obx(() {
                if (controller.isLoading.value &&
                    controller.companyAdminList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.companyAdminList.isEmpty) {
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
                    child: Container(
                  color: AppColors.background,
                  child: ListView.builder(
                    controller: controller.scrollController,
                    padding: EdgeInsets.zero,
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.companyAdminList.length +
                        (controller.isLoading.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == controller.companyAdminList.length) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final post = controller.companyAdminList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.mlmcompaniesdetails,
                                arguments: post);
                          },
                          child: MlmCompaniesCard(
                            userImage: post.image ?? '',
                            companyId: post.id ?? 0,
                            controller: controller,
                            viewcounts: post.pgcnt ?? 0,
                            likedCount: post.totallike ?? 0,
                            bookmarkCount: post.totalbookmark ?? 0,
                            postTitle: post.sname ?? '',
                            postCaption: post.description ?? '',
                            location: post.location ?? '',
                          ),
                        ),
                      );
                    },
                  ),
                ));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
