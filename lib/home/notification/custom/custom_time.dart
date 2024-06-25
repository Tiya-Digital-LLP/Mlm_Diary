class CustomTime {
  String formatPostTime(String postTime) {
    // Parse the input format "09 Feb 2023 4:00 PM"
    DateTime time = DateTime.parse(postTime);

    // Format the output as "09 Feb 2023 4:00 PM"
    String formattedTime =
        '${_twoDigits(time.day)} ${_monthAbbreviation(time.month)} ${time.year} ${_formatTime(time.hour, time.minute)}';

    return formattedTime;
  }

  String _twoDigits(int n) {
    if (n >= 10) {
      return '$n';
    }
    return '0$n';
  }

  String _monthAbbreviation(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  String _formatTime(int hour, int minute) {
    String period = (hour < 12) ? 'AM' : 'PM';
    int hour12 = (hour > 12) ? hour - 12 : hour;
    if (hour12 == 0) {
      hour12 = 12;
    }
    return '${_twoDigits(hour12)}:${_twoDigits(minute)} $period';
  }
}
