import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:optimus_test_app/constants/app_colors.dart';
import 'package:optimus_test_app/extensions/content_extension.dart';
import 'package:optimus_test_app/extensions/date_time_extension.dart';
import 'package:optimus_test_app/models/single_timezone_model.dart';
import 'package:optimus_test_app/providers/single_timezone_provider.dart';
import 'package:optimus_test_app/providers/timezone_detail_provider.dart';
import 'package:optimus_test_app/states/fetch_state.dart';
import 'package:optimus_test_app/views/Home.dart';

class ZoneDetailView extends ConsumerStatefulWidget {
  final String timeZone;
  const ZoneDetailView({super.key, required this.timeZone});

  @override
  ConsumerState<ZoneDetailView> createState() => _ZoneDetailViewState();
}

class _ZoneDetailViewState extends ConsumerState<ZoneDetailView> {
  String toFormattedGMTString(
      String currentLocalTime, int currentUtcOffsetSeconds) {
    DateTime localTime = DateTime.parse(currentLocalTime);
    String dayOfWeek = DateFormat("EEEE", "tr_TR").format(localTime);

    int hours = currentUtcOffsetSeconds ~/ 3600;
    int minutes = (currentUtcOffsetSeconds % 3600) ~/ 60;
    String formattedOffset =
        "GMT ${hours >= 0 ? '+' : '-'}${hours.abs().toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";

    return "$dayOfWeek, $formattedOffset";
  }

  @override
  void initState() {
    print(widget.timeZone);
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref
          .read(timeZoneDetailProvider.notifier)
          .fetchZoneDetail(widget.timeZone);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    var stProvider = ref.watch(timeZoneDetailProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: colorScheme.primary,
        title: Text(
          'World Time',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
      ),
      body: Builder(builder: (context) {
        if (stProvider is Fetched<SingleTimeZone>) {
          var value = stProvider.value;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 23, right: 23),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: colorScheme.onSurfaceVariant,
                          border:
                              Border.all(color: colorScheme.outline, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(31.0),
                        child: Text(
                          value.currentLocalTime.getHour(),
                          style: TextStyle(fontSize: 79),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        ":",
                        style: TextStyle(fontSize: 79),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: colorScheme.onSurfaceVariant,
                          border:
                              Border.all(color: colorScheme.outline, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(31.0),
                        child: Center(
                          child: Text(
                            value.currentLocalTime.getMinutes(),
                            style: TextStyle(fontSize: 79),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                value.timeZone.getCity(),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                value.timeZone.getZone(),
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                value.currentLocalTime.toString().toFormattedDateString(),
                style: TextStyle(fontSize: 20),
              ),
              Text(toFormattedGMTString(value.currentLocalTime.toString(),
                  value.currentUtcOffset.seconds))
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
