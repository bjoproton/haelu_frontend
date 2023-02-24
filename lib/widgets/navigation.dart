import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../screens/patient_details.dart';
import '../screens/patient_decision_trees.dart';

class Navigation extends StatelessWidget
{
  final Patient patient;
  final int index;
  Navigation(this.patient, this.index);

  @override
  Widget build(BuildContext context)
  {
    final ButtonStyle style = ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary);
    return Padding(     
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 2, left: 2),
                    child: Material(
                      elevation: 20.0,
                      shadowColor: Colors.black,
                      color: Theme.of(context).colorScheme.primary,
                      surfaceTintColor: index == 0 ? Colors.black : Colors.grey,
                      child: ListTile(
                        horizontalTitleGap: 1,
                        contentPadding:EdgeInsets.only(left: 5, top: 0, bottom: 0, right: 0),
                        leading: Icon(
                          Icons.insights,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        title: Text(
                            MediaQuery.of(context).size.width > 300 ? "Results" : "",
                            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => PatientDetailsScreenConnector(
                                patient: patient),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 2, left: 2),
                    child: Material(
                      elevation: 20.0,
                      shadowColor: Colors.black,
                      color: Theme.of(context).colorScheme.primary,
                      surfaceTintColor: index == 1 ? Colors.black : Colors.grey,
                      child: ListTile(
                        horizontalTitleGap: 1,
                        contentPadding:EdgeInsets.only(left: 5, top: 0, bottom: 0, right: 0),
                        leading: Icon(
                          Icons.flag,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),                    
                        title: Text(
                            MediaQuery.of(context).size.width > 300 ? "Analysis" : "",
                            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => PatientDecisionTreesScreenConnector(
                                patient: patient),
                            ),
                          );
                        }
                      ),
                    ),
                  ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
