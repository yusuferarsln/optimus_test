class SingleTimeZone {
  final String timeZone;
  final String currentLocalTime;
  final UtcOffset currentUtcOffset;
  final UtcOffset standardUtcOffset;
  final bool hasDayLightSaving;
  final bool isDayLightSavingActive;

  SingleTimeZone({
    required this.timeZone,
    required this.currentLocalTime,
    required this.currentUtcOffset,
    required this.standardUtcOffset,
    required this.hasDayLightSaving,
    required this.isDayLightSavingActive,
  });

  factory SingleTimeZone.fromJson(Map<String, dynamic> json) {
    return SingleTimeZone(
      timeZone: json['timeZone'],
      currentLocalTime: json['currentLocalTime'],
      currentUtcOffset: UtcOffset.fromJson(json['currentUtcOffset']),
      standardUtcOffset: UtcOffset.fromJson(json['standardUtcOffset']),
      hasDayLightSaving: json['hasDayLightSaving'],
      isDayLightSavingActive: json['isDayLightSavingActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timeZone': timeZone,
      'currentLocalTime': currentLocalTime,
      'currentUtcOffset': currentUtcOffset.toJson(),
      'standardUtcOffset': standardUtcOffset.toJson(),
      'hasDayLightSaving': hasDayLightSaving,
      'isDayLightSavingActive': isDayLightSavingActive,
    };
  }
}

class UtcOffset {
  final int seconds;
  final int milliseconds;
  final int ticks;
  final int nanoseconds;

  UtcOffset({
    required this.seconds,
    required this.milliseconds,
    required this.ticks,
    required this.nanoseconds,
  });

  factory UtcOffset.fromJson(Map<String, dynamic> json) {
    return UtcOffset(
      seconds: json['seconds'],
      milliseconds: json['milliseconds'],
      ticks: json['ticks'],
      nanoseconds: json['nanoseconds'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'seconds': seconds,
      'milliseconds': milliseconds,
      'ticks': ticks,
      'nanoseconds': nanoseconds,
    };
  }
}

class DaylightSavingTime {
  final String dstName;
  final UtcOffset dstOffsetToUtc;
  final UtcOffset dstOffsetToStandardTime;
  final String dstStart;
  final String dstEnd;
  final DurationDetails dstDuration;

  DaylightSavingTime({
    required this.dstName,
    required this.dstOffsetToUtc,
    required this.dstOffsetToStandardTime,
    required this.dstStart,
    required this.dstEnd,
    required this.dstDuration,
  });

  factory DaylightSavingTime.fromJson(Map<String, dynamic> json) {
    return DaylightSavingTime(
      dstName: json['dstName'],
      dstOffsetToUtc: UtcOffset.fromJson(json['dstOffsetToUtc']),
      dstOffsetToStandardTime:
          UtcOffset.fromJson(json['dstOffsetToStandardTime']),
      dstStart: json['dstStart'],
      dstEnd: json['dstEnd'],
      dstDuration: DurationDetails.fromJson(json['dstDuration']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dstName': dstName,
      'dstOffsetToUtc': dstOffsetToUtc.toJson(),
      'dstOffsetToStandardTime': dstOffsetToStandardTime.toJson(),
      'dstStart': dstStart,
      'dstEnd': dstEnd,
      'dstDuration': dstDuration.toJson(),
    };
  }
}

class DurationDetails {
  final int days;
  final int totalHours;
  final int totalMinutes;
  final int totalSeconds;
  final int totalMilliseconds;
  final int totalTicks;
  final int totalNanoseconds;

  DurationDetails({
    required this.days,
    required this.totalHours,
    required this.totalMinutes,
    required this.totalSeconds,
    required this.totalMilliseconds,
    required this.totalTicks,
    required this.totalNanoseconds,
  });

  factory DurationDetails.fromJson(Map<String, dynamic> json) {
    return DurationDetails(
      days: json['days'],
      totalHours: json['totalHours'],
      totalMinutes: json['totalMinutes'],
      totalSeconds: json['totalSeconds'],
      totalMilliseconds: json['totalMilliseconds'],
      totalTicks: json['totalTicks'],
      totalNanoseconds: json['totalNanoseconds'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'days': days,
      'totalHours': totalHours,
      'totalMinutes': totalMinutes,
      'totalSeconds': totalSeconds,
      'totalMilliseconds': totalMilliseconds,
      'totalTicks': totalTicks,
      'totalNanoseconds': totalNanoseconds,
    };
  }
}
