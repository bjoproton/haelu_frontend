// External
import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';

// Internal
import '../redux/state.dart';
import '../redux/actions.dart';
import '../widgets/newpage.dart';
import '../models/patient.dart';
import '../models/marker.dart';
import '../models/decisiontree.dart';
import '../models/decisiontreerun.dart';
import '../models/markerresult.dart';
import '../widgets/marker_results_table.dart';
import '../widgets/add_marker_result_table.dart';
import '../screens/patient_decision_trees.dart';
import '../widgets/navigation.dart';

class PatientDetailsScreenConnector extends StatelessWidget {
  final Patient patient;

  PatientDetailsScreenConnector({
      Key? key,
      required this.patient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      vm: () => Factory(this),
      builder: (BuildContext context, ViewModel vm) => PatientDetailsScreen(
        patient: patient,
        onAddMarkerResult: vm.onAddMarkerResult,
        patients: vm.patients,
        patientsInit: vm.patientsInit,
        markers: vm.markers,
        markersInit: vm.markersInit,
        decisionTrees: vm.decisionTrees,
        decisionTreesInit: vm.decisionTreesInit,
        onRunDecisionTree: vm.onRunDecisionTree,
        markerResults: vm.markerResults.where((i) => i.patient == patient).toList(),
        markerResultsInit: vm.markerResultsInit,
        decisionTreeRuns: vm.decisionTreeRuns.where((i) => i.patient == patient).toList(),
        decisionTreeRunsInit: vm.decisionTreeRunsInit,
      ),
    );
  }
}

class Factory extends VmFactory<AppState, PatientDetailsScreenConnector> {
  Factory(widget) : super(widget);

  @override
  ViewModel fromStore() => ViewModel(
    patients: state.patients,
    patientsInit: state.patientsInit,
    markers: state.markers,
    markersInit: state.markersInit,
    decisionTrees: state.decisionTrees,
    decisionTreesInit: state.decisionTreesInit,
    markerResults: state.markerResults,
    markerResultsInit: state.markerResultsInit,
    decisionTreeRuns: state.decisionTreeRuns,
    decisionTreeRunsInit: state.decisionTreeRunsInit,
    onAddMarkerResult: (Patient patient, Marker marker, String result) => dispatch(AddMarkerResultAction(patient, marker, result)),
    onRunDecisionTree: (Patient patient, DecisionTree decisionTree) => dispatch(RunDecisionTreeAction(patient, decisionTree)),
  );
}

class ViewModel extends Vm {
  final List<Patient> patients;
  final bool patientsInit;
  final List<Marker> markers;
  final bool markersInit;
  final List<DecisionTree> decisionTrees;
  final bool decisionTreesInit;
  final List<MarkerResult> markerResults;
  final bool markerResultsInit;
  final List<DecisionTreeRun> decisionTreeRuns;
  final bool decisionTreeRunsInit;
  final void Function(Patient, Marker, String) onAddMarkerResult;
  final void Function(Patient, DecisionTree) onRunDecisionTree;

  ViewModel({
    required this.patients,
    this.patientsInit = false,
    required this.markers,
    this.markersInit = false,
    required this.decisionTrees,
    this.decisionTreesInit = false,
    required this.markerResults,
    this.markerResultsInit = false,
    required this.decisionTreeRuns,
    this.decisionTreeRunsInit = false,
    required this.onAddMarkerResult,
    required this.onRunDecisionTree,
  }) : super(equals: [patients, patientsInit, markers, markersInit, decisionTrees, decisionTreesInit, markerResults, markerResultsInit, decisionTreeRuns, decisionTreeRunsInit]);
}

class PatientDetailsScreen extends StatelessWidget {
  final Patient patient;
  final List<Patient> patients;
  final bool patientsInit;
  final List<Marker> markers;
  final bool markersInit;
  final List<DecisionTree> decisionTrees;
  final bool decisionTreesInit;
  final List<MarkerResult> markerResults;
  final bool markerResultsInit;
    final List<DecisionTreeRun> decisionTreeRuns;
  final bool decisionTreeRunsInit;

  final void Function(Patient, Marker, String) onAddMarkerResult;
  final void Function(Patient, DecisionTree) onRunDecisionTree;

  PatientDetailsScreen({
    Key? key,
    required this.patient,
    this.patients = const [],
    this.patientsInit = false,
    this.markers = const [],
    this.markersInit = false,
    this.decisionTrees = const [],
    this.decisionTreesInit = false,
    this.markerResults = const [],
    this.markerResultsInit = false,
    this.decisionTreeRuns = const [],
    this.decisionTreeRunsInit = false,
    required this.onAddMarkerResult,
    required this.onRunDecisionTree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary);
    return PageWidget(
      title: 'Marker Results - ${patient.firstName} ${patient.lastName}',
      children: [
        Navigation(patient, 0),
        AddMarkerResultTable(patient: patient, markers: markers, onAddMarkerResult: onAddMarkerResult),
        Divider(),
        MarkerResultsTable(markerResults),
      ],
    );
  }
}
