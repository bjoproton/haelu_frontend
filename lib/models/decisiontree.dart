import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class DecisionTree with ChangeNotifier
{
  // {
  //   "id": 1,
  //   "name": "Sepsis V1",
  // }
  
  final int id;
  final String name;

  DecisionTree({
      required this.id,
      required this.name,
  });
}
