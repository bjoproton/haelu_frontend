// External
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

// Internal
import './redux/state.dart';
import './screens/login.dart';
import './screens/patients.dart';
import './screens/home.dart';
import './color_schemes.dart';

late Store<AppState> store;

void main() {
  var state = AppState.initialState();
  store = Store<AppState>(initialState: state);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  State<StatefulWidget> createState()
  {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{

  @override
  Widget build(BuildContext context) => StoreProvider<AppState>(
    store: store,
    child: MaterialApp(
      title: 'Haelu',
      routes: {
        PatientsScreenConnector.routeName: (ctx) => PatientsScreenConnector(),
      },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        dialogBackgroundColor: darkColorScheme.background,
        scaffoldBackgroundColor: darkColorScheme.background,
        canvasColor: darkColorScheme.background,
        textTheme: Theme.of(context).textTheme.apply(
          displayColor: darkColorScheme.primary,
          bodyColor: darkColorScheme.onPrimary,
          fontFamily: 'FilsonSoft',
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: darkColorScheme.onPrimary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: darkColorScheme.onPrimary),
          ),
        ),

      ),
      themeMode: ThemeMode.dark,
      home: HomeScreenConnector(),
    ),
  );
}
