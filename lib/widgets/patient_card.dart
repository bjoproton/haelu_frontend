//External
import 'package:flutter/material.dart';

// Internal
import '../models/patient.dart';
import '../screens/patient_details.dart';
import '../screens/patient_decision_trees.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  PatientCard(this.patient);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => PatientDetailsScreenConnector(
                patient: patient),
            ),
          );
        },
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            patient.firstName,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Container(
                          child: Text(
                            " ",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),                      
                        Container(
                          child: Text(
                            patient.lastName,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),                      
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
