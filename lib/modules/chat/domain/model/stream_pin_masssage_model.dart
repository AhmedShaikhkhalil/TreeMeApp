import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class MessageStreamService {
  StreamController<List<String>> _messageListController =
  StreamController<List<String>>.broadcast();
  Stream<List<String>> get messageListStream => _messageListController.stream;

  StreamSubscription? _subscription; // Subscription to manage the Firestore listener

  void startListeningToMessages(String id) {
    if (_subscription == null || _subscription!.isPaused) {
      _subscription?.cancel(); // Cancel the previous subscription if it exists

      _subscription = FirebaseChatCore.instance
          .getFirebaseFirestore()
          .collection('EventApp/$id/messages')
          .where('remoteId', isEqualTo: 'Pin') // Apply the filter here
          .snapshots()
          .listen((snapshot) {
        List<String> messageUris = [];

        for (var doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data();
          String uri = data['uri'];
          messageUris.add(uri);
        }

        _messageListController.add(messageUris);
      });
    }
  }

  void dispose() {
    _subscription?.cancel(); // Cancel the subscription when disposing
    _messageListController.close();
  }
}
