// External
import 'package:flutter/material.dart';

// Internal
import '../screens/patients.dart';
// import '../screens/markerresults.dart';

class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          children: <Widget>[
            SizedBox(height: 75),          
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                'Patients',
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(PatientsScreenConnector.routeName);
              }
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
