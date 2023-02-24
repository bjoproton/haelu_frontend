// External
import 'dart:convert';
import 'dart:io';
import 'package:async_redux/async_redux.dart';
import 'package:http/http.dart' as http;

// Internal
import './state.dart';
import '../models/patient.dart';
import '../models/marker.dart';
import '../models/decisiontree.dart';
import '../models/decisiontreerun.dart';
import '../models/markerresult.dart';

// const String urlStub = 'http://192.168.1.161:8000';
// const String urlStub = 'http://3.250.31.1:80';
const String urlStub = 'http://haelu.obriensoftware.net:8000';
// const String urlStub = 'http://127.0.0.1:8000';

Future<String> loginToAPI(String username, String password) async {
  String authToken = '';
  String url = urlStub + '/auth/login/';
  
  var body = json.encode({
      "username": username,
      "password": password
  });
  Map<String,String> headers = {
    'Content-type' : 'application/json', 
    'Accept': 'application/json',
  };
  
  final response = await http.post(Uri.parse(url), body: body, headers: headers);
  final responseJson = json.decode(response.body);
  print(responseJson);
  authToken = responseJson['token'];
  return authToken;
}

Future<void> addMarkerResultAPI(AppState state, int patient, int marker, String result) async {
  String url = urlStub + '/markers/results';
  
  var body = json.encode({
      "patient": patient,
      "marker": marker,
      "result": result,
  });

  Map<String,String> headers = {
    'Content-type' : 'application/json', 
    'Accept': 'application/json',
    'Authorization': 'token ${state.authToken}',    
  };
  print(body);
  final response = await http.post(Uri.parse(url), body: body, headers: headers);
  final responseJson = json.decode(response.body);
}

Future<void> runDecisionTreeAPI(AppState state, int patient, int decisionTree) async {
  String url = urlStub + '/decisions/decisiontrees/run' ;
  
  var body = json.encode({
      "patient": patient,
      "decision_tree": decisionTree,
  });

  Map<String,String> headers = {
    'Content-type' : 'application/json', 
    'Accept': 'application/json',
    'Authorization': 'token ${state.authToken}',    
  };
  print(body);
  final response = await http.post(Uri.parse(url), body: body, headers: headers);
  // final responseJson = json.decode(response.body);
}


Future<List<Patient>> getPatientsFromAPI(AppState state) async {
  final List<Patient> loadedPatients = [];
  String url = urlStub + '/patients/patients';
  
  try {
    Map<String,String> headers = {
      'Content-type' : 'application/json', 
      'Accept': 'application/json',
      'Authorization': 'token ${state.authToken}',
    };
    
    final response = await http.get(Uri.parse(url), headers: headers);
    final results = json.decode(response.body);
    print(results);
    for (final r in results) {
      loadedPatients.add(Patient.fromJson(r));
    }
  } catch (error) {
    throw (error);
  }
  return loadedPatients;
}

Future<List<Marker>> getMarkersFromAPI(AppState state) async {
  final List<Marker> loadedMarkers = [];
  String url = urlStub + '/markers/markers';
  try {
    Map<String,String> headers = {
      'Content-type' : 'application/json', 
      'Accept': 'application/json',
      'Authorization': 'token ${state.authToken}',
    };
    
    final response = await http.get(Uri.parse(url), headers: headers);
    final results = json.decode(response.body);

    print(results);
    for (final r in results) {
      loadedMarkers.add(
        Marker(
          id: r['id'],
          name: r['name'],
          valueType: r['value_type'],
      ));
    }
  } catch (error) {
    throw (error);
  }
  return loadedMarkers;
}

Future<List<DecisionTree>> getDecisionTreesFromAPI(AppState state) async {
  final List<DecisionTree> loadedDecisionTrees = [];
  String url = urlStub + '/decisions/decisiontrees';
  try {
    Map<String,String> headers = {
      'Content-type' : 'application/json', 
      'Accept': 'application/json',
      'Authorization': 'token ${state.authToken}',
    };
    
    final response = await http.get(Uri.parse(url), headers: headers);
    final results = json.decode(response.body);

    print(results);
    for (final r in results) {
      loadedDecisionTrees.add(
        DecisionTree(
          id: r['id'],
          name: r['name'],
      ));
    }
  } catch (error) {
    throw (error);
  }
  return loadedDecisionTrees;
}

Future<List<DecisionTreeRun>> getDecisionTreeRunsFromAPI(AppState state) async {
  final List<DecisionTreeRun> loadedDecisionTreeRuns = [];
  String url = urlStub + '/decisions/decisiontrees/runs';
  try {
    Map<String,String> headers = {
      'Content-type' : 'application/json', 
      'Accept': 'application/json',
      'Authorization': 'token ${state.authToken}',
    };
    
    final response = await http.get(Uri.parse(url), headers: headers);
    final results = json.decode(response.body);

    print(results);
    for (final r in results) {
      loadedDecisionTreeRuns.add(
        DecisionTreeRun(
          id: r['id'],
          patient: state.patients.firstWhere((patient) => patient.id == r['patient']),
          decisionTree: state.decisionTrees.firstWhere((decisionTree) => decisionTree.id == r['decision_tree']),
          result: r['result'],
          datetime: r['datetime'],
      ));
    }
  } catch (error) {
    throw (error);
  }
  return loadedDecisionTreeRuns;
}

Future<List<MarkerResult>> getMarkerResultsFromAPI(AppState state) async {
  final List<MarkerResult> loadedMarkerResults = [];
  String url = urlStub + '/markers/results';
  try {

    Map<String,String> headers = {
      'Content-type' : 'application/json', 
      'Accept': 'application/json',
      'Authorization': 'token ${state.authToken}',
    };

    final response = await http.get(Uri.parse(url), headers: headers);
    final results = json.decode(response.body);
    print(results);
    for (final r in results) {
      loadedMarkerResults.add(
        MarkerResult(
          id: r['id'],
          patient: state.patients.firstWhere((patient) => patient.id == r['patient']),
          marker: state.markers.firstWhere((marker) => marker.id == r['marker']),
          result: r['result'],
          datetime: r['datetime'],
      ));
    }
  } catch (error) {
    throw (error);
  }
  return loadedMarkerResults;
}


class LoginAction extends ReduxAction<AppState> {
  final String username;
  final String password;
  LoginAction(this.username, this.password);
  
  @override
  Future<AppState> reduce() async {
    String authToken = '';
    authToken = await loginToAPI(username, password);
    return state.copy(authToken: authToken);
  }

  void after() => dispatch(MarkersInitAction());
}


class AddMarkerResultAction extends ReduxAction<AppState> {
  final Patient patient;
  final Marker marker;
  final String result;
  
  AddMarkerResultAction(this.patient, this.marker, this.result);
  
  @override
  Future<AppState> reduce() async {
    print("Calling addMarkerResultAPI(state, ${patient.id}, ${marker.name}, ${result})");
    await addMarkerResultAPI(state, patient.id, marker.id, result);
    return state.copy();
  }

  void after() => dispatch(MarkerResultsInitAction());
}

class RunDecisionTreeAction extends ReduxAction<AppState> {
  final Patient patient;
  final DecisionTree decisionTree;
  
  RunDecisionTreeAction(this.patient, this.decisionTree);
  
  @override
  Future<AppState> reduce() async {
    print("Calling runDecisionTreeAPI(state, ${patient.id}, ${decisionTree.name})");
    await runDecisionTreeAPI(state, patient.id, decisionTree.id);
    return state.copy();
  }

  void after() => dispatch(MarkerResultsInitAction());
}


class PatientsInitAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    List<Patient> _loadedPatients = [];
    print("PatientsInitAction");
    _loadedPatients = await getPatientsFromAPI(state);
    return state.copy(patientsInit: false, patients: _loadedPatients);
  }

  void after() => dispatch(MarkerResultsInitAction());
}

class MarkersInitAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    List<Marker> _loadedMarkers = [];
    print("MarkerssInitAction");
    _loadedMarkers = await getMarkersFromAPI(state);
    return state.copy(markersInit: false, markers: _loadedMarkers);
  }

  void after() => dispatch(PatientsInitAction());
}

class DecisionTreesInitAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    List<DecisionTree> _loadedDecisionTrees = [];
    print("DecisionTreesInitAction");
    _loadedDecisionTrees = await getDecisionTreesFromAPI(state);
    return state.copy(decisionTreesInit: false, decisionTrees: _loadedDecisionTrees);
  }

  void after() => dispatch(DecisionTreeRunsInitAction());
}

class MarkerResultsInitAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    List<MarkerResult> _loadedMarkerResults = [];
    print("MarkerResultsInitAction");
    _loadedMarkerResults = await getMarkerResultsFromAPI(state);
    return state.copy(markerResultsInit: false, markerResults: _loadedMarkerResults);
  }

  void after() => dispatch(DecisionTreesInitAction());  
}

class DecisionTreeRunsInitAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    List<DecisionTreeRun> _loadedDecisionTreeRuns = [];
    print("DecisionTreeRunsInitAction");
    _loadedDecisionTreeRuns = await getDecisionTreeRunsFromAPI(state);
    return state.copy(decisionTreeRunsInit: false, decisionTreeRuns: _loadedDecisionTreeRuns);
  }

  void after() => {}; // dispatch(MarkerResultsInitAction());
}

