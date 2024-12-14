import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optimus_test_app/constants/app_colors.dart';
import 'package:optimus_test_app/extensions/content_extension.dart';
import 'package:optimus_test_app/models/timezone_model.dart';
import 'package:optimus_test_app/providers/single_timezone_provider.dart';
import 'package:optimus_test_app/providers/timezone_provider.dart';
import 'package:optimus_test_app/states/fetch_state.dart';
import 'package:optimus_test_app/views/ZoneDetail.dart';
import 'package:optimus_test_app/widgets/CustomAppBar.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(singleTimeZoneProvider.notifier).fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    var timeZoneP = ref.watch(timeZoneProvider);
    final isDarkMode = colorScheme.brightness == Brightness.dark;
    List<String> filteredTimeZones = timeZoneP is Fetched<TimeZoneModel>
        ? timeZoneP.value.timeZones
            .where((zone) =>
                zone.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList()
        : [];

    return Scaffold(
      appBar: CustomAppBarMainWidget(
        searchController: _searchController,
        onSearchChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Builder(builder: (context) {
            if (timeZoneP is Fetched<TimeZoneModel>) {
              var value = timeZoneP.value;
              return Container(
                height: context.height * 0.64,
                child: ListView.builder(
                    itemCount: filteredTimeZones.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.go(ZoneDetailView(
                              timeZone: filteredTimeZones[index]));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 33, left: 33, bottom: 10),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: double.infinity,
                                height: context.height * 0.075,
                                decoration: BoxDecoration(
                                  color: colorScheme.primary,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      filteredTimeZones[index],
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: -10,
                                top: 15,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: colorScheme.primary,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          color: colorScheme.surface,
                                          width: 4)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: colorScheme.onPrimary,
                                      size: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ],
      ),
    );
  }
}
