import 'package:flutter/material.dart';
import '../models/markerresult.dart';
import '../models/marker.dart';
import '../models/patient.dart';
import 'package:flutter/services.dart';

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
          Text(
            'Add Results',
            style: TextStyle(fontSize: 30.0, color: Theme.of(context).colorScheme.secondary),
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,            
            children: [
              TableRow(children: [
                  Center(
                    child: Container(
                      width: 150,
                      child: DropdownButtonFormField<Marker>(
                        isExpanded: true,
                        value: addMarkerValue,
                        icon: const Icon(Icons.arrow_downward),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 5.0, right: 5, bottom: 0),
                        ),
                        elevation: 16,
                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                        dropdownColor: Theme.of(context).colorScheme.primary,
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
                    ),
                  ),
                  (addMarkerValue?.valueType == 0) ?
                  Center(
                    child: Container(
                      width: 150,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: addMarkerStringBool,
                        icon: const Icon(Icons.arrow_downward),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 5.0, right: 5, bottom: 0),
                        ),                        
                        elevation: 16,
                        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                        dropdownColor: Theme.of(context).colorScheme.primary,
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
                      width: 150,
                      child: TextFormField(
                        controller: _addMarkerStringController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          hintText: "Enter value",
                          contentPadding: EdgeInsets.only(left: 5.0, right: 5, bottom: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // TableRow(children: [
              //     Text(""),
              //     Text(""),
              //     Center(
              //       child: Padding(
              //         padding: const EdgeInsets.all(0),
              //         child: Material(
              //           elevation: 20.0,
              //           shadowColor: Colors.black,
              //           color: Theme.of(context).colorScheme.primary,
              //           surfaceTintColor: Colors.grey,
              //           child: ListTile(
              //             leading: Icon(
              //               Icons.add_circle,
              //               color: Theme.of(context).colorScheme.onPrimary,
              //             ),
              //             title: Transform.translate(
              //               offset: Offset(-16, 0),
              //               child: Text(
              //                 MediaQuery.of(context).size.width > 300 ? "Add Result" : "",
              //                 style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              //               ),
              //             ),
              //             onTap: () {
              //               setState(() {
              //                   addMarkerStringText = _addMarkerStringController.text.trim();
              //                   if (addMarkerValue?.valueType == 0) {
              //                     // Use the boolean value
              //                     addMarkerString = addMarkerStringBool;
              //                   }
              //                   else {
              //                     // Use the text value
              //                     addMarkerString = addMarkerStringText;
              //                   }
              //               });
              //               onAddMarkerResult?.call(patient, addMarkerValue as Marker, addMarkerString as String);
              //             },
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],         
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            width: 150,
            child: Material(
              elevation: 20.0,
              shadowColor: Colors.black,
              color: Theme.of(context).colorScheme.primary,
              surfaceTintColor: Colors.grey,
              child: ListTile(
                horizontalTitleGap: 1,
                contentPadding:EdgeInsets.only(left: 5, top: 0, bottom: 0, right: 0),
                leading: Icon(
                  Icons.add_circle,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                title: Text(
                    MediaQuery.of(context).size.width > 150 ? "Add Result" : "",
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                onTap: () {
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
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
