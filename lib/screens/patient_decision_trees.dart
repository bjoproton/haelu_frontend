// External
import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';

// Internal
import '../redux/state.dart';
import '../redux/actions.dart';
import '../widgets/newpage.dart';
import '../models/patient.dart';
import '../widgets/decision_tree_table.dart';
import '../widgets/navigation.dart';
import '../models/decisiontree.dart';
import '../models/decisiontreerun.dart';

class PatientDecisionTreesScreenConnector extends StatelessWidget {
  final Patient patient;

  PatientDecisionTreesScreenConnector({
      Key? key,
      required this.patient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      vm: () => Factory(this),
      builder: (BuildContext context, ViewModel vm) => PatientDecisionTreesScreen(
        patient: patient,
        patients: vm.patients,
        patientsInit: vm.patientsInit,
        decisionTrees: vm.decisionTrees,
        decisionTreesInit: vm.decisionTreesInit,
        onRunDecisionTree: vm.onRunDecisionTree,
        decisionTreeRuns: vm.decisionTreeRuns.where((i) => i.patient == patient).toList(),
        decisionTreeRunsInit: vm.decisionTreeRunsInit,
      ),
    );
  }
}

class Factory extends VmFactory<AppState, PatientDecisionTreesScreenConnector> {
  Factory(widget) : super(widget);

  @override
  ViewModel fromStore() => ViewModel(
    patients: state.patients,
    patientsInit: state.patientsInit,
    decisionTrees: state.decisionTrees,
    decisionTreesInit: state.decisionTreesInit,
    decisionTreeRuns: state.decisionTreeRuns,
    decisionTreeRunsInit: state.decisionTreeRunsInit,
    onRunDecisionTree: (Patient patient, DecisionTree decisionTree) => dispatch(RunDecisionTreeAction(patient, decisionTree)),
  );
}

class ViewModel extends Vm {
  final List<Patient> patients;
  final bool patientsInit;
  final List<DecisionTree> decisionTrees;
  final bool decisionTreesInit;
  final List<DecisionTreeRun> decisionTreeRuns;
  final bool decisionTreeRunsInit;
  final void Function(Patient, DecisionTree) onRunDecisionTree;

  ViewModel({
    required this.patients,
    this.patientsInit = false,
    required this.decisionTrees,
    this.decisionTreesInit = false,
    required this.decisionTreeRuns,
    this.decisionTreeRunsInit = false,
    required this.onRunDecisionTree,
  }) : super(equals: [patients, patientsInit, decisionTrees, decisionTreesInit, decisionTreeRuns, decisionTreeRunsInit]);
}

class PatientDecisionTreesScreen extends StatelessWidget {
  final Patient patient;
  final List<Patient> patients;
  final bool patientsInit;
  final List<DecisionTree> decisionTrees;
  final bool decisionTreesInit;
  final List<DecisionTreeRun> decisionTreeRuns;
  final bool decisionTreeRunsInit;

  final void Function(Patient, DecisionTree) onRunDecisionTree;

  PatientDecisionTreesScreen({
    Key? key,
    required this.patient,
    this.patients = const [],
    this.patientsInit = false,
    this.decisionTrees = const [],
    this.decisionTreesInit = false,
    this.decisionTreeRuns = const [],
    this.decisionTreeRunsInit = false,
    required this.onRunDecisionTree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWidget(     
      title: 'Analysis - ${patient.firstName} ${patient.lastName}',
      children: [
        Navigation(patient, 1),
        DecisionTreeTable(patient: patient, decisionTrees: decisionTrees, decisionTreeRuns: decisionTreeRuns, onRunDecisionTree: onRunDecisionTree),
      ],
    );
  }
}
