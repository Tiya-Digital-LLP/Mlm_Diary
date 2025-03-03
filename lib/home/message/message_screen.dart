import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/home/message/chat_card.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/message/controller/message_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_search_input.dart';
import 'package:mlmdiary/widgets/custom_shimmer_loader/custom_shimmer_followers.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final MessageController messageController = Get.put(MessageController());

  @override
  void initState() {
    messageController.fetchMyChat();
    super.initState();
  }

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
          style: textStyleW700(
            size.width * 0.048,
            AppColors.blackText,
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
                          // ignore: deprecated_member_use
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
                  if (messageController.isLoading.value) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: 1,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return const ChatShimmerLoader(
                              width: 175, height: 100);
                        },
                      ),
                    );
                  }

                  if (messageController.chatList.isEmpty) {
                    return Center(
                      child: Text(
                        'Chat not found',
                        style: textStyleW600(
                          size.width * 0.030,
                          AppColors.blackText,
                          isMetropolis: true,
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
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: 1,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return const ChatShimmerLoader(
                                    width: 175, height: 100);
                              },
                            ),
                          );
                        }
                        final post = messageController.chatList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          child: GestureDetector(
                            onTap: () async {
                              final arguments = {
                                'chatId': post.chatId,
                                'toId': post.toid.toString(),
                                'userName': post.username,
                                'userImage': post.imageUrl,
                              };
                              if (kDebugMode) {
                                print("Arguments: $arguments");
                              }
                              Get.toNamed(
                                Routes.messagedetailscreen,
                                arguments: arguments,
                              );
                              await messageController
                                  .fetchMyChatDetail(post.chatId.toString());
                            },
                            child: ChatCard(
                              userImage: post.imageUrl ?? '',
                              userName: post.username ?? 'Unknown',
                              postCaption: post.msg ?? '',
                              chatId: post.chatId.toString(),
                              controller: messageController,
                              datetime: post.createdAt ?? '',
                              readStatus: post.readStatus ?? 0,
                              countUnread: post.countOfEnread ?? 0,
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
