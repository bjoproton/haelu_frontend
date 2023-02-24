//External
import 'package:flutter/material.dart';

// Internal
import '../models/patient.dart';
import '../models/marker.dart';
import '../models/decisiontree.dart';
import '../models/decisiontreerun.dart';
import '../models/markerresult.dart';
import '../screens/patients.dart';
import '../screens/patient_details.dart';
import '../widgets/marker_results_table.dart';
import '../widgets/add_marker_result_table.dart';

class PatientCardDetail extends StatefulWidget {
  final Patient patient;
  final List<Marker> markers;
  final List<MarkerResult> markerResults;
  final List<DecisionTree> decisionTrees;
  final List<DecisionTreeRun> decisionTreeRuns;
  final void Function(Patient, Marker, String)? onAddMarkerResult;
  final void Function(Patient, DecisionTree)? onRunDecisionTree;
  TextEditingController _addMarkerStringController = TextEditingController();
  Marker? addMarkerValue;
  String? addMarkerString;
  String? addMarkerStringBool;
  String? addMarkerStringText;
  DecisionTree? runDecisionTree;

  PatientCardDetail({
      required this.patient,
      required this.markers,
      required this.markerResults,
      required this.decisionTrees,
      required this.decisionTreeRuns,
      this.onAddMarkerResult,
      this.onRunDecisionTree,
  })
  {
    this.addMarkerValue = this.markers[0];
    this.addMarkerString = "";
    this.addMarkerStringBool = "True";
    this.addMarkerStringText = "";
    this._addMarkerStringController = TextEditingController(text: '');
  }

  @override
  _PatientCardDetailState createState() => _PatientCardDetailState(patient: patient, markers: markers, decisionTrees: decisionTrees, markerResults: markerResults, onAddMarkerResult: onAddMarkerResult, onRunDecisionTree: onRunDecisionTree, decisionTreeRuns: decisionTreeRuns);
}

class _PatientCardDetailState extends State<PatientCardDetail> {
  final Patient patient;
  final List<Marker> markers;
  final List<MarkerResult> markerResults;
  final List<DecisionTree> decisionTrees;
  final List<DecisionTreeRun> decisionTreeRuns;
  final void Function(Patient, Marker, String)? onAddMarkerResult;
  final void Function(Patient, DecisionTree)? onRunDecisionTree;
  TextEditingController _addMarkerStringController = TextEditingController();
  Marker? addMarkerValue;
  String? addMarkerString;
  String? addMarkerStringBool;
  String? addMarkerStringText;

  _PatientCardDetailState({
      required this.patient,
      required this.markers,
      required this.markerResults,
      required this.decisionTrees,
      required this.decisionTreeRuns,
      this.onAddMarkerResult,
      this.onRunDecisionTree,
  })
  {
    this.addMarkerValue = this.markers[0];
    this.addMarkerString = "";
    this.addMarkerStringBool = "True";
    this.addMarkerStringText = "";
    this._addMarkerStringController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary);
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              constraints: BoxConstraints(
                minHeight: 400,
                maxWidth: 500,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MarkerResultsTable(markerResults),
                  AddMarkerResultTable(patient: patient, markers: markers, onAddMarkerResult: onAddMarkerResult),
                  Text(
                    'Run Decision Tree',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Table(
                      children: [
                        TableRow(children: [
                            Text("NAME", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                            Text("EXECUTE", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                        ]),
                        TableRow(children: [
                            Text(""),
                            Text(""),
                        ]),
                        for (int i=0; i<decisionTrees.length; i++)
                        TableRow(children: [
                            Text("${decisionTrees[i].name}", style: TextStyle(fontSize: 15.0), textAlign: TextAlign.center),
                            Container(
                              width: 50,
                              child: ElevatedButton(
                                style: style,
                                child: Center(
                                  child: Text("Run", textAlign: TextAlign.center),
                                ),
                                onPressed: () {
                                  onRunDecisionTree?.call(patient, decisionTrees[i]);
                                  //setState(() {});
                                  // Navigator.push(context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => PatientDetailsScreenConnector(
                                  //       patient: patient),
                                  //   ),
                                  // );
                                }
                                //             setState(() {
                                //                 addMarkerStringText = _addMarkerStringController.text.trim();
                                //                 if (addMarkerValue?.valueType == 0) {
                                //         // Use the boolean value
                                //         addMarkerString = addMarkerStringBool;
                                //       }
                                //       else {
                                //         // Use the text value
                                //         addMarkerString = addMarkerStringText;
                                //       }

                                //   });
                                //
                                // }
                              ),
                            ),
                            // Text("", style: TextStyle(fontSize: 15.0), textAlign: TextAlign.center),
                        ]),
                      ],
                    ),
                  ),
                  Text(
                    'Previous Decision Tree Runs',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Table(
                      children: [
                        TableRow(children: [
                            Text("NAME", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                            Text("RESULT", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                        ]),
                        TableRow(children: [
                            Text(""),
                            Text(""),
                        ]),
                        for (int i=0; i<decisionTreeRuns.length; i++)
                        TableRow(children: [
                            Text("${decisionTreeRuns[i].decisionTree.name}", style: TextStyle(fontSize: 15.0), textAlign: TextAlign.center),
                            Text("${decisionTreeRuns[i].result}", style: TextStyle(fontSize: 15.0), textAlign: TextAlign.center),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
