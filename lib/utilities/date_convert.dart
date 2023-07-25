
class DateConvert {
  static Duration parseTimeStringToDuration(String timeString) {
    String minutesString = timeString.substring(2, timeString.length - 1);
    int minutes = int.parse(minutesString);
    return Duration(minutes: minutes);
  }

  static String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;

    String formattedDuration = hours > 0
        ? '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}'
        : '00:${minutes.toString().padLeft(2, '0')}';

    return formattedDuration;
  }
}