import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class Marker with ChangeNotifier
{
  // {
  //   "id": 1,
  //   "name": "age",
  //   "value_type": 1
  // }
  
  final int id;
  final String name;
  final int valueType;

  Marker({
      required this.id,
      required this.name,
      required this.valueType,
  });
}
