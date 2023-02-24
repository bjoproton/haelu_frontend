import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import './patient.dart';
import './marker.dart';

class MarkerResult with ChangeNotifier
{
  // {
  //   "id": 1,
  //   "patient": 1,
  //   "marker": 1,
  //   "result": "25",
  //   "datetime": "2023-02-22T13:54:54.558322Z"
  // },

  
  final int id;
  final Patient patient;
  final Marker marker;
  final String result;
  final String datetime;

  MarkerResult({
      required this.id,
      required this.patient,
      required this.marker,
      required this.result,
      required this.datetime,
  });
}
