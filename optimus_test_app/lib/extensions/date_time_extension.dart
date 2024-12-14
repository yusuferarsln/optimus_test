import 'package:intl/intl.dart';

extension DateTimeExtensions on String {
  String parseLocalTime() {
    DateTime currentTime = DateTime.parse(this);
    return DateFormat('HH:mm').format(currentTime);
  }

  String getHour() {
    DateTime currentTime = DateTime.parse(this);
    return currentTime.hour.toString().padLeft(2, '0');
  }

  String getMinutes() {
    DateTime currentTime = DateTime.parse(this);
    return currentTime.minute.toString().padLeft(2, '0');
  }

  String formatTurkishDate() {
    DateTime dateTime = DateTime.parse(this);
    return DateFormat("d MMMM, EEEE", "tr_TR").format(dateTime);
  }

  String getGreeting() {
    DateTime currentTime = DateTime.parse(this);
    int hour = currentTime.hour;

    if (hour >= 6 && hour < 12) {
      return 'Günaydın';
    } else if (hour >= 12 && hour < 18) {
      return 'İyi Günler';
    } else if (hour >= 18 && hour < 21) {
      return 'İyi Akşamlar';
    } else {
      return 'İyi Geceler';
    }
  }

  String getZone() {
    List<String> parts = this.split('/');
    return parts.isNotEmpty ? parts[0] : '';
  }

  String getCity() {
    List<String> parts = this.split('/');
    return parts.length > 1 ? parts[1].replaceAll('_', ' ') : '';
  }

  String toFormattedDateString() {
    DateTime localTime = DateTime.parse(this);
    return DateFormat("MMMM d, yyyy", "tr_TR").format(localTime);
  }
}
