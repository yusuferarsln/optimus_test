import 'dart:async'; // Import Timer
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optimus_test_app/models/single_timezone_model.dart';
import 'package:optimus_test_app/models/timezone_model.dart';
import 'package:optimus_test_app/services/api_service.dart';
import 'package:optimus_test_app/states/fetch_state.dart';

final singleTimeZoneProvider =
    StateNotifierProvider<_STimeZoneNotifier, FetchState>(
  (ref) => _STimeZoneNotifier(ref),
);

class _STimeZoneNotifier extends StateNotifier<FetchState> {
  _STimeZoneNotifier(this.ref) : super(Fetching()) {
    _startPeriodicFetch();
  }
  var res;

  final Ref ref;
  Timer? _timer;

  void fetch() async {
    print("************* ZONE FETCH");
    try {
      if (state is Fetched<SingleTimeZone>) {
        var tzres = await api.getTimezoneData(res);
        if (tzres != null) {
          state = Fetched<SingleTimeZone>(tzres);
        }
        return;
      }

      state = Fetching();
      res = await api.getTimezoneFromIP();
      var tzres = await api.getTimezoneData(res);
      if (tzres != null) {
        state = Fetched<SingleTimeZone>(tzres);
      }
    } catch (e) {
      print("fetching");
      state = FetchError(e);

      rethrow;
    }
  }

  void _startPeriodicFetch() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      fetch();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
