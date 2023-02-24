import 'package:flutter/material.dart';
import '../models/markerresult.dart';
import '../models/marker.dart';
import '../models/patient.dart';

class AddMarkerResultTable extends StatefulWidget
{
  final void Function(Patient, Marker, String)? onAddMarkerResult;
  final Patient patient;
  final List<Marker> markers;
  TextEditingController _addMarkerStringController = TextEditingController();
  Marker? addMarkerValue;
  String? addMarkerString;
  String? addMarkerStringBool;
  String? addMarkerStringText;
  
  AddMarkerResultTable({
      required this.patient,
      required this.markers,
      this.onAddMarkerResult,
  })
  {
    this.addMarkerValue = this.markers[0];
    this.addMarkerString = "";
    this.addMarkerStringBool = "True";
    this.addMarkerStringText = "";
    this._addMarkerStringController = TextEditingController(text: '');
  }

  @override
  _AddMarkerResultTableState createState() => _AddMarkerResultTableState(patient: patient, markers: markers, onAddMarkerResult: onAddMarkerResult);
}

class _AddMarkerResultTableState extends State<AddMarkerResultTable>
{
  final void Function(Patient, Marker, String)? onAddMarkerResult;
  final Patient patient;
  final List<Marker> markers;
  TextEditingController _addMarkerStringController = TextEditingController();
  Marker? addMarkerValue;
  String? addMarkerString;
  String? addMarkerStringBool;
  String? addMarkerStringText;
  
  _AddMarkerResultTableState({
      required this.patient,
      required this.markers,
      this.onAddMarkerResult,
  })
  {
    this.addMarkerValue = this.markers[0];
    this.addMarkerString = "";
    this.addMarkerStringBool = "True";
    this.addMarkerStringText = "";
    this._addMarkerStringController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context)
  {
    final ButtonStyle style = ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimary);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          // Text(
          //   'Add Marker Results',
          //   style: Theme.of(context).textTheme.titleLarge,
          // ),
          Table(
            children: [
              TableRow(children: [
                  Text("Add Result", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left),
                  Text("", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left),
                  Text("", style: TextStyle(fontSize: 20.0), textAlign: TextAlign.left),
              ]),
              TableRow(children: [
                  DropdownButton<Marker>(
                    value: addMarkerValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                    dropdownColor: Theme.of(context).colorScheme.primary,
                    underline: Container(
                      height: 0,
                    ),
                    onChanged: (Marker? value) {
                      // This is called when the user selects an item.
                      setState(() {
                          addMarkerValue = value;
                      });
                    },
                    items: markers.map((Marker marker) {
                        return DropdownMenuItem<Marker>(
                          value: marker,
                          child: Text("${marker.name}"),
                        );
                    }).toList(),
                  ),
                  (addMarkerValue?.valueType == 0) ?
                  Center(
                    child: Container(
                      width: 100,
                      child: DropdownButton<String>(
                        value: addMarkerStringBool,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                        dropdownColor: Theme.of(context).colorScheme.primary,
                        underline: Container(
                          height: 0,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                              addMarkerStringBool = value;
                          });
                        },
                        items: ["True", "False"].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text("${value}"),
                            );
                        }).toList(),
                      ),
                    ),
                  )
                  :
                  Center(
                    child: Container(
                      width: 100,
                      child: TextFormField(
                        controller: _addMarkerStringController,
                        decoration: InputDecoration(
                          hintText: "",
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child:
                    Container(
                      width: 100,
                      child: ElevatedButton(
                        style: style,
                        child: Center(
                          child: Text("Add", textAlign: TextAlign.center),
                        ),
                        onPressed: () {
                          setState(() {
                              addMarkerStringText = _addMarkerStringController.text.trim();
                              if (addMarkerValue?.valueType == 0) {
                                // Use the boolean value
                                addMarkerString = addMarkerStringBool;
                              }
                              else {
                                // Use the text value
                                addMarkerString = addMarkerStringText;
                              }
                              
                          });
                          onAddMarkerResult?.call(patient, addMarkerValue as Marker, addMarkerString as String);
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
