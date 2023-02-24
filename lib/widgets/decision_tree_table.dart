import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../models/decisiontree.dart';
import '../models/decisiontreerun.dart';


class DecisionTreeTable extends StatelessWidget
{
  final Patient patient;
  final List<DecisionTree> decisionTrees;
  final List<DecisionTreeRun> decisionTreeRuns;
  final void Function(Patient, DecisionTree)? onRunDecisionTree;
  
  DecisionTreeTable({
      required this.patient,
      required this.decisionTrees,
      required this.decisionTreeRuns,
      this.onRunDecisionTree,
  });
  
  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          Text(
            'Run Analysis',
            style: TextStyle(fontSize: 30.0, color: Theme.of(context).colorScheme.secondary),
          ),          
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(children: [
                  Text("NAME", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                  Text("EXECUTE", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
              ]),
              TableRow(children: [
                  Text(""),
                  Text(""),
              ]),
              for (int i=0; i<decisionTrees.length; i++)
              TableRow(children: [
                  Text("${decisionTrees[i].name}", style: TextStyle(fontSize: 15.0), textAlign: TextAlign.center),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Material(
                      elevation: 20.0,
                      shadowColor: Colors.black,
                      color: Theme.of(context).colorScheme.primary,
                      surfaceTintColor: Colors.grey,
                      child: ListTile(
                        horizontalTitleGap: 1,
                        contentPadding:EdgeInsets.only(left: 5, top: 0, bottom: 0, right: 0),
                        leading: Icon(
                          Icons.directions_run,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        title: Text(
                            MediaQuery.of(context).size.width > 300 ? "Run Analysis" : "",
                            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        onTap: () {
                          onRunDecisionTree?.call(patient, decisionTrees[i]);
                        },
                      ),
                    ),
                  ),
              ]),
            ],
          ),
          Divider(),
          Text(
            'Historic Analyses',
            style: TextStyle(fontSize: 30.0, color: Theme.of(context).colorScheme.secondary),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Table(
              border: TableBorder(horizontalInside: BorderSide(width: 1, color: Theme.of(context).colorScheme.onPrimary, style: BorderStyle.solid)),
              children: [
                TableRow(children: [
                    Text("NAME", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                    Text("RESULT", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                    Text("DATETIME", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                    
                ]),
                TableRow(children: [
                    Text(""),
                    Text(""),
                    Text(""),
                ]),
                for (int i=0; i<decisionTreeRuns.length; i++)
                TableRow(children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 5, top: 5),                    
                    child: Text("${decisionTreeRuns[i].decisionTree.name}", style: TextStyle(fontSize: 15.0), textAlign: TextAlign.center),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5, top: 5),
                    child: Text("${decisionTreeRuns[i].result}", style: TextStyle(fontSize: 15.0), textAlign: TextAlign.center),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5, top: 5),
                    child: Text("${decisionTreeRuns[i].datetime}", style: TextStyle(fontSize: 15.0), textAlign: TextAlign.center),
                  ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
