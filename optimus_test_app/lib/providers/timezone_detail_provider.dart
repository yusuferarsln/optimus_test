import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optimus_test_app/models/single_timezone_model.dart';
import 'package:optimus_test_app/models/timezone_model.dart';
import 'package:optimus_test_app/services/api_service.dart';
import 'package:optimus_test_app/states/fetch_state.dart';

final timeZoneDetailProvider =
    StateNotifierProvider<_TZDetailNotifier, FetchState>(
  (ref) => _TZDetailNotifier(ref),
);

class _TZDetailNotifier extends StateNotifier<FetchState> {
  _TZDetailNotifier(this.ref) : super(Fetching());
  final Ref ref;

  void fetchZoneDetail(String zone) async {
    print("************* ZONE FETCH");
    try {
      state = Fetching();
      var tzres = await api.getTimezoneData(zone);
      if (tzres != null) {
        state = Fetched<SingleTimeZone>(tzres);
      }
    } catch (e) {
      print("fetching");
      state = FetchError(e);

      rethrow;
    }
  }
}
