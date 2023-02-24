// External
import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import 'package:google_fonts/google_fonts.dart';

// Internal
import '../redux/state.dart';
import '../redux/actions.dart';
import '../widgets/text.dart';
import './patients.dart';
import './login.dart';


class HomeScreenConnector extends StatelessWidget {
  HomeScreenConnector({Key? key}) : super(key: key);
  static const routeName = 'home';
  
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      vm: () => Factory(this),
      builder: (BuildContext context, ViewModel vm) => HomeScreen(
        authToken: vm.authToken,
      ),
    );
  }
}

class Factory extends VmFactory<AppState, HomeScreenConnector> {
  Factory(widget) : super(widget);

  @override
  ViewModel fromStore() => ViewModel(
    authToken: state.authToken,
  );
}

class ViewModel extends Vm {
  final String? authToken;
  
  ViewModel({
      this.authToken,
  }) : super(equals: [authToken, ]);
}

class HomeScreen extends StatelessWidget {
  final String? authToken;

  HomeScreen({
      Key? key,
      this.authToken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (authToken != '' && authToken != null) {
      return PatientsScreenConnector();
    } else {
      return LoginScreenConnector();
    }
  }
}
