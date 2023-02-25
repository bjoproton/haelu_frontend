// External
import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import 'package:google_fonts/google_fonts.dart';

// Internal
import '../redux/state.dart';
import '../redux/actions.dart';
import '../widgets/text.dart';
import './home.dart';


class LoginScreenConnector extends StatelessWidget {
  LoginScreenConnector({Key? key}) : super(key: key);
  static const routeName = 'login';

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      vm: () => Factory(this),
      builder: (BuildContext context, ViewModel vm) => LoginScreen(
        authToken: vm.authToken,
        onLoginAttempt: vm.onLoginAttempt,
      ),
    );
  }
}

class Factory extends VmFactory<AppState, LoginScreenConnector> {
  Factory(widget) : super(widget);

  @override
  ViewModel fromStore() => ViewModel(
    authToken: state.authToken,
    onLoginAttempt: (String username, String password) => dispatch(LoginAction(username, password)),
  );
}

class ViewModel extends Vm {
  final String? authToken;
  final void Function(String, String) onLoginAttempt;

  ViewModel({
      this.authToken,
      required this.onLoginAttempt,
  }) : super(equals: [authToken, ]);
}

class LoginScreen extends StatelessWidget {
  final String? authToken;
  final void Function(String, String)? onLoginAttempt;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginScreen({
      Key? key,
      this.authToken,
      this.onLoginAttempt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: 300,
          decoration: BoxDecoration(
            color: Color(0xFF2fc4c4),
            image: DecorationImage(
              image: AssetImage(
                "assets/img/logo.png",
              ),
              scale: constraints.maxWidth < 600 ? 1 : 1,
              fit: BoxFit.none,
            ),
          ),
          child: Container(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              body: Center(
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      width: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextFormField(
                            cursorHeight: 20,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Theme.of(context).colorScheme.onPrimary,
                            textCapitalization: TextCapitalization.none,
                            controller: _usernameController,
                            decoration: InputDecoration(
                              hintText: 'Username',
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            cursorHeight: 20,
                            cursorColor: Theme.of(context).colorScheme.onPrimary,
                            textCapitalization: TextCapitalization.none,                            
                            controller: _passwordController,
                            decoration: InputDecoration(
                              hintText: 'Password',
                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 150,
                            child:
                            ElevatedButton(
                              style: style,
                              child: Center(
                                child: Text("Sign In"),
                              ),
                              onPressed: () => onLoginAttempt?.call(
                                _usernameController.text.trim(),
                                _passwordController.text.trim(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
