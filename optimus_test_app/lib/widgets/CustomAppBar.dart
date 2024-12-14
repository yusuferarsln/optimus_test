import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:optimus_test_app/constants/app_colors.dart';
import 'package:optimus_test_app/extensions/content_extension.dart';
import 'package:optimus_test_app/extensions/date_time_extension.dart';
import 'package:optimus_test_app/models/single_timezone_model.dart';
import 'package:optimus_test_app/providers/single_timezone_provider.dart';
import 'package:optimus_test_app/states/fetch_state.dart';

class CustomAppBarMainWidget extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;

  const CustomAppBarMainWidget({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  ConsumerState<CustomAppBarMainWidget> createState() =>
      _CustomAppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(250);
}

class _CustomAppBarWidgetState extends ConsumerState<CustomAppBarMainWidget> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final isDarkMode = colorScheme.brightness == Brightness.dark;

    var stzProvider = ref.watch(singleTimeZoneProvider);
    return Builder(builder: (context) {
      final colorScheme = Theme.of(context).colorScheme;

      if (stzProvider is Fetched<SingleTimeZone>) {
        var value = stzProvider.value;
        return Container(
          height: widget.preferredSize.height,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                height: widget.preferredSize.height * 0.9,
                padding: const EdgeInsets.symmetric(horizontal: 33),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.currentLocalTime.toString().getGreeting() +
                              ", Özgür!",
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              value.currentLocalTime
                                  .toString()
                                  .parseLocalTime(),
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          value.currentLocalTime.toString().formatTurkishDate(),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Image.asset(isDarkMode
                        ? "assets/images/WhiteStar.png"
                        : "assets/images/Star.png")
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 30,
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    width: context.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: widget.searchController,
                              onChanged: widget.onSearchChanged,
                              decoration: InputDecoration(
                                hintText: 'Arama',
                                hintStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              style: TextStyle(color: Colors.black),
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
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
