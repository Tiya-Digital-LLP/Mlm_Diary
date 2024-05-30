import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/classified/controller/add_classified_controller.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/classified/classified_card.dart';
import 'package:mlmdiary/widgets/custom_app_bar.dart';

class ClassifiedScreen extends StatefulWidget {
  const ClassifiedScreen({super.key});

  @override
  State<ClassifiedScreen> createState() => _ClassifiedScreenState();
}

class _ClassifiedScreenState extends State<ClassifiedScreen> {
  final ClasifiedController controller = Get.put(ClasifiedController());

  @override
  void initState() {
    super.initState();
    controller.getClassified();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        size: MediaQuery.of(context).size,
        titleText: 'MLM Classified',
        onTap: () {},
      ),
      body: Container(
        color: AppColors.background,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.classifiedList.isEmpty) {
            return Center(
              child: Text(
                controller.isLoading.value ? 'Loading...' : 'Data not found',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.zero,
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.classifiedList.length,
            itemBuilder: (context, index) {
              final post = controller.classifiedList[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      Routes.mlmclassifieddetail,
                      arguments: controller.classifiedList[index],
                    );
                  },
                  child: ClassifiedCard(
                    userImage: post.imagePath ?? '',
                    userName: post.title ?? '',
                    postTitle: post.description ?? '',
                  ),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Get.toNamed(Routes.addclassified);
        },
        child: Ink(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              Assets.svgPlusIcon,
            ),
          ),
        ),
      ),
    );
  }
}
