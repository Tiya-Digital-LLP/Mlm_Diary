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
      return '${time.day}-${time.month}-${time.year}';
    }
  }
}
