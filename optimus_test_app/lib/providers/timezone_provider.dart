import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optimus_test_app/models/timezone_model.dart';
import 'package:optimus_test_app/services/api_service.dart';
import 'package:optimus_test_app/states/fetch_state.dart';

final timeZoneProvider = StateNotifierProvider<_TimeZoneNotifier, FetchState>(
  (ref) => _TimeZoneNotifier(ref),
);

class _TimeZoneNotifier extends StateNotifier<FetchState> {
  _TimeZoneNotifier(this.ref) : super(Fetching()) {
    fetch();
  }
  final Ref ref;

  void fetch() async {
    print("************* ZONE FETCH");
    try {
      state = Fetching();
      var res = await api.fetchAvailableTimezones();
      if (res != null) {
        state = Fetched<TimeZoneModel>(res);
      }
    } catch (e) {
      print("fetching");
      state = FetchError(e);

      rethrow;
    }
  }
}
