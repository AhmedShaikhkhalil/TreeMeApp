

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:treeme/core/utils/services/storage.dart';

class YourStreamService {
  final StreamController<int> _deliveredCountController = StreamController<int>.broadcast();
  Stream<int> get deliveredCountStream => _deliveredCountController.stream;

  StreamSubscription? _subscription; // Added subscription variable

  void startListeningToDeliveredCount(Stream<QuerySnapshot<Map<String, dynamic>>> data) {
    if (_subscription == null || _subscription!.isPaused) {
      _subscription?.cancel(); // Cancel the previous subscription if it exists

      _subscription = data.listen((snapshot) {
        int count = 0;

        for (var e in snapshot.docs) {
          if (e != null) {
            String status = e.data().toString().contains('status') ? e.get(
                'status') : 'no';
            if (status == 'sent' &&
                e['authorId'] != Storage().firebaseUID) {
              count++;
            }
          }
        }

        if (!_deliveredCountController.isClosed) {
          _deliveredCountController.add(count);
        }
      });
    }
  }

  void dispose() {
    _subscription?.cancel(); // Cancel the subscription when disposing
    _deliveredCountController.close();
  }
}

class DateStreamService {

  final StreamController<DateTime> _updatedAtController = StreamController<DateTime>.broadcast();
  Stream<DateTime> get updatedAtStream => _updatedAtController.stream;

  void startListeningToUpdatedAt(Stream<QuerySnapshot<Map<String, dynamic>>> data) {
    if (!_updatedAtController.isClosed) {
      data.listen((snapshot) {
        DateTime? latestUpdatedAt;

        for (var e in snapshot.docs) {
          if (e != null) {
            dynamic updatedAtData = e.get('updatedAt'); // Get the value of 'updatedAt' field
            if (updatedAtData != null && updatedAtData is Timestamp) {
              DateTime updatedAt = updatedAtData.toDate();
              if (latestUpdatedAt == null || updatedAt.isAfter(latestUpdatedAt)) {
                latestUpdatedAt = updatedAt;
              }
            }
          }
        }

        if (latestUpdatedAt != null) {
          _updatedAtController.add(latestUpdatedAt);
        }
      });
    }
  }

  void dispose() {
    _updatedAtController.close();
  }
}
