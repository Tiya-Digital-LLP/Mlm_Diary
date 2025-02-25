import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/text_style.dart';

class CommentInputWidget extends StatefulWidget {
  final int maxCharacters;
  final TextEditingController textController;
  final VoidCallback onSend;
  final RxBool isLoading;
  final FocusNode focusNode;
  final RxString? hintText;

  const CommentInputWidget({
    super.key,
    required this.maxCharacters,
    required this.textController,
    required this.onSend,
    required this.isLoading,
    required this.focusNode,
    this.hintText, // NEW: Pass hint text dynamically
  });

  @override
  // ignore: library_private_types_in_public_api
  _CommentInputWidgetState createState() => _CommentInputWidgetState();
}

class _CommentInputWidgetState extends State<CommentInputWidget> {
  bool isLimitExceeded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${widget.maxCharacters - widget.textController.text.length} characters left',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.searchbar,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color:
                              isLimitExceeded ? Colors.red : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Obx(() => TextField(
                                      controller: widget.textController,
                                      maxLines: 5,
                                      maxLength: widget.maxCharacters,
                                      focusNode: widget.focusNode,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        hintText: widget.hintText?.value ??
                                            "Write your comment...",
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                        counterText: '',
                                      ),
                                      onChanged: (text) {
                                        setState(() {
                                          isLimitExceeded = text.length >=
                                              widget.maxCharacters;
                                        });

                                        if (isLimitExceeded) {
                                          showToasterrorborder(
                                              "Character limit exceeded",
                                              context);
                                        }
                                      },
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: widget.onSend,
                                child: Obx(
                                  () => Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primaryColor,
                                      boxShadow: [customBoxShadow()],
                                    ),
                                    child: widget.isLoading.value
                                        ? const CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                          )
                                        : const Icon(
                                            Icons.send_rounded,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
