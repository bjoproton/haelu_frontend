import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../screens/patient_details.dart';
import '../screens/patient_decision_trees.dart';

class PatientsTable extends StatelessWidget
{
  final List<Patient> patients;
  PatientsTable(this.patients);

  
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
                  Text("", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left),
                  Text("", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                  //Text("", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
              ]),
              TableRow(children: [
                  Text(""),
                  Text(""),
                  //Text(""),
              ]),
              for (int i=0; i<this.patients.length; i++)
              TableRow(children: [
                  Text("${patients[i].firstName} ${patients[i].lastName}", style: TextStyle(fontSize: 15.0), textAlign: TextAlign.left),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Material(
                          elevation: 20.0,
                          shadowColor: Colors.black,
                          color: Theme.of(context).colorScheme.primary,
                          surfaceTintColor: Colors.grey,
                          child: ListTile(
                            horizontalTitleGap: 1,
                            contentPadding:EdgeInsets.only(left: 5, top: 0, bottom: 0, right: 0),                                                        
                            leading: Icon(Icons.insights),                            
                            title: Text(
                                MediaQuery.of(context).size.width > 300 ? "Results" : "",
                                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                            onTap: () {
                              Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (context) => PatientDetailsScreenConnector(
                                    patient: patients[i]),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Material(
                          elevation: 20.0,
                          shadowColor: Colors.black,
                          color: Theme.of(context).colorScheme.primary,
                          surfaceTintColor: Colors.grey,
                          child: ListTile(
                            horizontalTitleGap: 1,
                            contentPadding:EdgeInsets.only(left: 5, top: 0, bottom: 0, right: 0),                            
                            leading: Icon(Icons.flag),
                            title: Text(
                                MediaQuery.of(context).size.width > 300 ? "Analysis" : "",
                                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                              ),
                            onTap: () {
                              Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (context) => PatientDecisionTreesScreenConnector(
                                    patient: patients[i]),
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
        ],
      ),
    );
  }
}
