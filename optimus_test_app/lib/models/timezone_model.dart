class TimeZoneModel {
  final List<String> timeZones;

  TimeZoneModel({required this.timeZones});

  // Factory constructor to create a TimeZoneModel from a JSON array
  factory TimeZoneModel.fromJson(List<dynamic> json) {
    return TimeZoneModel(
      timeZones:
          List<String>.from(json), // Cast the JSON list to a List<String>
    );
  }
}
