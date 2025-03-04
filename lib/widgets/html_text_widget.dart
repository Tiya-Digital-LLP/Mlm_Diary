import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/text_style.dart';

class HtmlTextWidget extends StatelessWidget {
  final String htmlData;

  const HtmlTextWidget({super.key, required this.htmlData});

  String _extractPlainText(String html) {
    return html_parser.parse(html).body?.text ?? "";
  }

  String _getMiddleLines(String text) {
    List<String> lines = text.trim().split('\n');

    if (lines.length < 3) {
      return text;
    }

    List<String> middleLines = lines.sublist(1, lines.length - 1);

    return middleLines.join(' ').trim();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    String plainText = _extractPlainText(htmlData);
    String middleText = _getMiddleLines(plainText);

    return Container(
      width: double.infinity,
      alignment: Alignment.topLeft,
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          middleText,
          maxLines: 3,
          textAlign: TextAlign.start,
          style: textStyleW400(
            size.width * 0.030,
            AppColors.blackText,
          ),
        ),
      ),
    );
  }
}
