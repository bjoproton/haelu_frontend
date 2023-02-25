import 'package:flutter/material.dart';
import '../models/markerresult.dart';
import '../models/marker.dart';

class MarkerResultsTable extends StatelessWidget
{
  final List<MarkerResult> markerResults;
  MarkerResultsTable(this.markerResults);

  
  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            'Historic Results',
            style: TextStyle(fontSize: 30.0, color: Theme.of(context).colorScheme.secondary),
          ),
          Table(
            border: TableBorder(horizontalInside: BorderSide(width: 1, color: Theme.of(context).colorScheme.onPrimary, style: BorderStyle.solid)),
            children: [
              TableRow(children: [
                  Text("MARKER", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left),
                  Text("RESULT", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left),
                  Text("DATE", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left),
              ]),
              TableRow(children: [
                  Text(""),
                  Text(""),
                  Text(""),
              ]),
              for (int i=0; i<this.markerResults.length; i++)
              TableRow(children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 5, top: 5),
                    child: Text("${markerResults[i].marker.name}", style: TextStyle(fontSize: 15.0), textAlign: TextAlign.left),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5, top: 5),
                    child: Text("${markerResults[i].result}", style: TextStyle(fontSize: 15.0), textAlign: TextAlign.left),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5, top: 5),
                    child: Text("${markerResults[i].datetime}", style: TextStyle(fontSize: 15.0), textAlign: TextAlign.left),
                  ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
