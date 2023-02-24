import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import './decisiontree.dart';
import './patient.dart';

class DecisionTreeRun with ChangeNotifier
{
  // {
  //   "id": 1,
  //   "patient": "31",
  //   "decision_tree": 25,
  //   "result": "Red Flag"
  // }
  
  final int id;
  final Patient patient;
  final DecisionTree decisionTree;
  final String result;
  final String datetime;

  DecisionTreeRun({
      required this.id,
      required this.patient,
      required this.decisionTree,
      required this.result,
      required this.datetime,
      
  });
}
