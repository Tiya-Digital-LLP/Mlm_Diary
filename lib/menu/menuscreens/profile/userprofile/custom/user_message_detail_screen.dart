import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mlmdiary/generated/assets.dart';
import 'package:mlmdiary/home/message/controller/message_controller.dart';
import 'package:mlmdiary/menu/menuscreens/profile/userprofile/controller/user_profile_controller.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/extension_classes.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_dateandtime.dart';

class UserMessageDetailScreen extends StatefulWidget {
  const UserMessageDetailScreen({super.key});

  @override
  State<UserMessageDetailScreen> createState() =>
      _UserMessageDetailScreenState();
}

class _UserMessageDetailScreenState extends State<UserMessageDetailScreen> {
  final MessageController messageController = Get.put(MessageController());
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  late PostTimeFormatter postTimeFormatter;
  dynamic post;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    post = Get.arguments;
    postTimeFormatter = PostTimeFormatter();

    // Fetch chat details if chatId is not null
    if (post != null && post['chatId'] != null) {
      messageController.fetchMyChatDetail(post['chatId'].toString());
    }

    // Scroll to the bottom when the chat details are fetched
    messageController.chatdetailsList.listen((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
              child: SvgPicture.asset(
                Assets.svgBack,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (post != null && post['imageUrl'] != null) ...[
                    ClipOval(
                      child: Image.network(
                        post['imageUrl'],
                        height: 30.0,
                        width: 30.0,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    10.sbw,
                  ],
                  Text(
                    post['username'] ?? 'Unknown',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.05,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
                Obx(
                  () => ListView.builder(
                    controller: _scrollController,
                    itemCount: messageController.chatdetailsList.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      final message = messageController.chatdetailsList[index];
                      final isSender = message.fromid == post['fromid'];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: isSender
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            if (!isSender &&
                                post != null &&
                                post['imageUrl'] != null) ...[
                              ClipOval(
                                child: Image.network(
                                  post['imageUrl'],
                                  height: 30.0,
                                  width: 30.0,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              10.sbw,
                            ],
                            Column(
                              crossAxisAlignment: isSender
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isSender
                                        ? AppColors.primaryColor
                                        : AppColors.primaryColor
                                            .withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: isSender
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message.msg ?? '',
                                        style: TextStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                      5.sbh,
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            postTimeFormatter.formatPostTime(
                                                message.updatedAt!),
                                            style: textStyleW400(
                                              size.width * 0.03,
                                              AppColors.white.withOpacity(0.7),
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
                              ],
                            ),
                            if (isSender) ...[
                              10.sbw,
                              ClipOval(
                                child: Image.asset(
                                  Assets.imagesIcon,
                                  height: 30,
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            color: AppColors.white,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: SvgPicture.asset(
                        Assets.svgPlusIcon,
                        height: 40,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.searchbar,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextField(
                              controller: messageController.msg.value,
                              decoration: const InputDecoration(
                                hintText: 'Write your answer here',
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {},
                            ),
                          ),
                        ),
                      ),
                    ),
                    8.sbw,
                    Obx(() {
                      return IconButton(
                        icon: SvgPicture.asset(
                          Assets.svgSend,
                          // ignore: deprecated_member_use
                          color: AppColors.primaryColor,
                          height: size.width * 0.07,
                        ),
                        onPressed: messageController.isLoading.value
                            ? null
                            : () async {
                                await messageController.sendChat(
                                  toId: post['toid'].toString(),
                                  chatId: post['chatId']?.toString(),
                                );

                                // Clear the message input field after sending the message
                                messageController.msg.value.clear();
                              },
                      );
                    }),
                    12.sbw,
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
