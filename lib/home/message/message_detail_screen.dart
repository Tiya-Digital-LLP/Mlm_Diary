import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/message/controller/message_controller.dart';
import 'package:mlmdiary/menu/controller/profile_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/routes/app_pages.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';
import 'package:mlmdiary/widgets/loader/custom_lottie_animation.dart';
import 'package:mlmdiary/widgets/logout_dialog/custom_logout_dialog.dart';

class MessageDetailsScreen extends StatefulWidget {
  const MessageDetailsScreen({super.key});

  @override
  State<MessageDetailsScreen> createState() => _MessageDetailsScreenState();
}

class _MessageDetailsScreenState extends State<MessageDetailsScreen> {
  final MessageController messageController = Get.put(MessageController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  final ProfileController profileController = Get.put(ProfileController());
  late PostTimeFormatter postTimeFormatter;
  dynamic post;
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    post = Get.arguments;
    if (post != null && post.chatId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        messageController.fetchMyChatDetail(post.chatId.toString());
      });
      postTimeFormatter = PostTimeFormatter();

      _startFetchingNewMessages();
    }
  }

  // Timer function to fetch new messages
  void _startFetchingNewMessages() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (messageController.chatdetailsList.isNotEmpty) {
        messageController.fetchMyChatDetail(post.chatId.toString());
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: SvgPicture.asset(Assets.svgBack),
          onPressed: () {
            Get.back();
            messageController.fetchMyChat();
          },
        ),
        title: InkWell(
          onTap: () async {
            Get.toNamed(
              Routes.userprofilescreen,
              arguments: {
                'user_id': post.fromid,
              },
            );
            await userProfileController.fetchUserAllPost(
              1,
              post.fromid.toString(),
            );
          },
          child: Row(
            children: [
              if (post != null && post.imageUrl != null)
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: post.imageUrl,
                    height: 30.0,
                    width: 30.0,
                    fit: BoxFit.cover,
                  ),
                ),
              10.sbw,
              Text(
                post.username ?? 'Unknown',
                style: textStyleW700(16, Colors.black),
              ),
            ],
          ),
        ),
        actions: [
          PopupMenuButton<int>(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onSelected: (value) {
              if (value == 1) {
                LogoutDialog.show(context, () async {
                  messageController.deleteChat(chatId: post.chatId.toString());
                });
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Container(
                  padding: EdgeInsets.zero,
                  child: const Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text("Delete Chat"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    Assets.imagesBg,
                    fit: BoxFit.cover,
                  ),
                ),
                // Show the loader if data is being fetched
                Obx(() {
                  return messageController.isLoading.value
                      ? Center(
                          child: CustomLottieAnimation(
                            child: Lottie.asset(
                              Assets.lottieLottie,
                            ),
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 16,
                          ),
                          reverse: true,
                          itemCount: messageController.chatdetailsList.length,
                          itemBuilder: (_, index) {
                            final message =
                                messageController.chatdetailsList[index];
                            final isSender = message.fromid.toString() ==
                                profileController.userId.toString();
                            final userImage = isSender
                                ? profileController.userImage
                                : post.imageUrl;

                            return Align(
                              alignment: isSender
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: isSender
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (!isSender)
                                    ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: userImage ?? '',
                                        height: 30.0,
                                        width: 30.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  Flexible(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: isSender
                                            ? AppColors.primaryColor
                                            // ignore: deprecated_member_use
                                            : AppColors.grey.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: isSender
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            message.msg ?? '',
                                            style: textStyleW400(
                                                14, AppColors.white),
                                          ),
                                          5.sbh,
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                postTimeFormatter
                                                    .formatPostTime(
                                                        message.updatedAt!),
                                                style: textStyleW400(
                                                  12,
                                                  AppColors.white
                                                      // ignore: deprecated_member_use
                                                      .withOpacity(0.7),
                                                ),
                                              ),
                                              6.sbw,
                                              Icon(
                                                message.readStatus == 0
                                                    ? Icons.check
                                                    : Icons.done_all,
                                                size: 16,
                                                color: AppColors.white,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (isSender)
                                    ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: userImage ?? '',
                                        height: 30.0,
                                        width: 30.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        );
                }),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                10.sbw,
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.searchbar,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextField(
                      controller: messageController.msg.value,
                      decoration: const InputDecoration(
                        hintText: 'Write a message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    messageController.sendChat(
                      toId: post.toid.toString(),
                      chatId: post.chatId ?? '',
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
