import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatTimestamp(Timestamp timestamp) {
  var format = DateFormat('d MMM y');
  var date =
      DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
  return format.format(date);
}

String formatMilllis(int millis) {
  var format = DateFormat('d MMM y');
  var date = DateTime.fromMillisecondsSinceEpoch(millis);
  return format.format(date);
}
