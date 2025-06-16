import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(text)),
      );
  }

  static StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>> transformer<T>(
      T Function(Map<String, dynamic>) fromJson,
      ) {
    return StreamTransformer.fromHandlers(
      handleData: (QuerySnapshot<Map<String, dynamic>> data, EventSink<List<T>> sink) {
        final result = data.docs.map((doc) => fromJson(doc.data())).toList();
        sink.add(result);
      },
    );
  }
}