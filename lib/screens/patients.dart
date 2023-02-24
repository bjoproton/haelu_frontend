// External
import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';

// Internal
import '../redux/state.dart';
import '../redux/actions.dart';
import '../widgets/patients_listview.dart';
import '../screens/patient_details.dart';
import '../models/patient.dart';
import '../widgets/newpage.dart';
import '../widgets/loading_spinner.dart';
import '../widgets/patients_table.dart';


class PatientsScreenConnector extends StatelessWidget {
  PatientsScreenConnector({Key? key}) : super(key: key);
  static const routeName = 'patients';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      vm: () => Factory(this),
      builder: (BuildContext context, ViewModel vm) => PatientsScreen(
        onIncrement: vm.onIncrement,
        onInit: vm.onInit,
        patients: vm.patients,
        patientsInit: vm.patientsInit,
      ),
    );
  }
}

class Factory extends VmFactory<AppState, PatientsScreenConnector> {
  Factory(widget) : super(widget);

  @override
  ViewModel fromStore() => ViewModel(
    patients: state.patients,
    patientsInit: state.patientsInit,
    onInit: () => dispatch(PatientsInitAction()),
    onIncrement: () => {}, 
  );
}

class ViewModel extends Vm {
  final List<Patient> patients;
  final bool patientsInit;
  final VoidCallback onIncrement;
  final VoidCallback onInit;

  ViewModel({
    required this.patients,
    this.patientsInit = false,
    required this.onIncrement,
    required this.onInit,
  }) : super(equals: [patients, patientsInit]);
}

class PatientsScreen extends StatelessWidget {
  final List<Patient> patients;
  final bool patientsInit;  
  final VoidCallback? onIncrement;
  final VoidCallback? onInit;

  PatientsScreen({
    Key? key,
    this.patients = const [],
    this.patientsInit = false,    
    this.onIncrement,
    this.onInit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (patientsInit) {
      onInit?.call();
    }
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return PageWidget(
          title: 'Patients',
          children: [
            PatientsTable(patients),
            // Container(
            //   height: constraints.maxHeight * 0.8,
            //   alignment: Alignment.center,
            //   child: patientsInit ? Column(
            //     children: <Widget>[
            //       LoadingSpinner(),
            //   ], ) : PatientsListView(patients),
            // ),
          ],
        );
      }
    );
  }
}
