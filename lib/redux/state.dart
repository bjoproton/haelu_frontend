// Internal
import '../models/patient.dart';
import '../models/markerresult.dart';
import '../models/marker.dart';
import '../models/decisiontree.dart';
import '../models/decisiontreerun.dart';

// @immutable
class AppState {
  // Auth
  final String? authToken;

  // Patients
  final List<Patient> patients;
  final bool patientsInit;

  // MarkerResults
  final List<MarkerResult> markerResults;
  final bool markerResultsInit;

  // Markers
  final List<Marker> markers;
  final bool markersInit;

  // DecisionTrees
  final List<DecisionTree> decisionTrees;
  final bool decisionTreesInit;

  // DecisionTreeRuns
  final List<DecisionTreeRun> decisionTreeRuns;
  final bool decisionTreeRunsInit;  

  AppState({
      this.authToken,
      required this.patients,
      required this.patientsInit,
      required this.markerResults,
      required this.markerResultsInit,
      required this.markers,
      required this.markersInit,
      required this.decisionTrees,
      required this.decisionTreesInit,
      required this.decisionTreeRuns,
      required this.decisionTreeRunsInit,
  });

  AppState copy({
      String? authToken,
      List<Patient>? patients,
      bool patientsInit = false,
      List<MarkerResult>? markerResults,
      bool markerResultsInit = false,
      List<Marker>? markers,
      bool markersInit = false,
      List<DecisionTree>? decisionTrees,
      bool decisionTreesInit = false,
      List<DecisionTreeRun>? decisionTreeRuns,
      bool decisionTreeRunsInit = false,      
  }) => AppState(
    authToken: authToken ?? this.authToken,
    patients: patients ?? this.patients,
    patientsInit: patientsInit ?? this.patientsInit,
    markerResults: markerResults ?? this.markerResults,
    markerResultsInit: markerResultsInit ?? this.markerResultsInit,
    markers: markers ?? this.markers,
    markersInit: markersInit ?? this.markersInit,
    decisionTrees: decisionTrees ?? this.decisionTrees,
    decisionTreesInit: decisionTreesInit ?? this.decisionTreesInit,
    decisionTreeRuns: decisionTreeRuns ?? this.decisionTreeRuns,
    decisionTreeRunsInit: decisionTreeRunsInit ?? this.decisionTreeRunsInit,    
  );

  static AppState initialState() => AppState(
    authToken: null,
    patients: [],
    patientsInit: true,
    markerResults: [],
    markerResultsInit: true,
    markers: [],
    markersInit: true,
    decisionTrees: [],
    decisionTreesInit: true,
    decisionTreeRuns: [],
    decisionTreeRunsInit: true,    
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          authToken == other.authToken &&
          patients == other.patients &&
          patientsInit == other.patientsInit &&
          markerResults == other.markerResults &&
          markerResultsInit == other.markerResultsInit &&
          markers == other.markers &&
          markersInit == other.markersInit &&
          decisionTrees == other.decisionTrees &&
          decisionTreesInit == other.decisionTreesInit &&
          decisionTreeRuns == other.decisionTreeRuns &&
          decisionTreeRunsInit == other.decisionTreeRunsInit;          

  @override
  int get hashCode => authToken.hashCode ^ patients.hashCode ^ patientsInit.hashCode ^ markerResults.hashCode ^ markerResultsInit.hashCode ^ markers.hashCode ^ markersInit.hashCode ^ decisionTrees.hashCode ^ decisionTreesInit.hashCode ^ decisionTreeRuns.hashCode ^ decisionTreeRunsInit.hashCode;
}
