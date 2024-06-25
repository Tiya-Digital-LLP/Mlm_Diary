import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/home/message/chat_card.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/message/controller/message_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';

class Message extends StatelessWidget {
  final MessageController messageController = Get.put(MessageController());

  Message({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.all(size.height * 0.012),
          child: Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: SvgPicture.asset(Assets.svgBack),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Message',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: size.width * 0.048,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    child: CustomSearchInput(
                      controller: messageController.searchController,
                      onSubmitted: (value) {
                        WidgetsBinding.instance.focusManager.primaryFocus
                            ?.unfocus();
                        messageController.fetchMyChat();
                      },
                      onChanged: (value) {
                        if (value.isEmpty) {
                          WidgetsBinding.instance.focusManager.primaryFocus;
                          messageController.fetchMyChat();
                        }
                      },
                    ),
                  ),
                ),
                Obx(() {
                  if (messageController.isLoading.value &&
                      messageController.chatList.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (messageController.chatList.isEmpty) {
                    return const Center(
                      child: Text(
                        'Chat not found',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }
                  return Container(
                    color: AppColors.background,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: messageController.chatList.length +
                          (messageController.isLoading.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == messageController.chatList.length) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final post = messageController.chatList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          child: Dismissible(
                            direction: DismissDirection.endToStart,
                            resizeDuration: const Duration(seconds: 1),
                            key: UniqueKey(),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              child: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onDismissed: (direction) {
                              messageController.chatList.removeAt(index);
                            },
                            child: GestureDetector(
                              onTap: () async {
                                await messageController
                                    .fetchMyChatDetail(post.chatId.toString());
                                Get.toNamed(Routes.messagedetailscreen,
                                    arguments: post);
                              },
                              child: ChatCard(
                                userImage: post.userImage ?? '',
                                userName: post.username ?? 'Unknown',
                                postCaption: post.msg ?? '',
                                chatId: post.chatId.toString(),
                                controller: messageController,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
