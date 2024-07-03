import 'package:intl/intl.dart';

class PostTimeFormatter {
  String formatPostTime(String postTime) {
    DateTime now = DateTime.now();
    DateTime time = DateTime.parse(postTime);
    Duration difference = now.difference(time);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes} min ago';
      }
      return '${difference.inHours} hour ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      // Format the date to show the day, month name, and year
      String formattedDate = DateFormat('d MMM, yyyy').format(time);
      return formattedDate;
    }
  }
}
