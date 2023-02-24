// External
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Internal
import '../widgets/patient_card.dart';
import '../models/patient.dart';

class PatientsListView extends StatelessWidget
{
  final List<Patient> patients;
  PatientsListView(this.patients);

  @override
  Widget build(BuildContext context)
  {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: 300,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: patients.length,
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: patients[i],
              child: PatientCard(patients[i]),
            ),
          )
        );
      }
    );
  }
}
