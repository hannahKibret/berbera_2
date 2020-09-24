import 'package:berbera_2/models/profile.dart';
import 'package:berbera_2/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
//class LocationDropDownField extends StatefulWidget{
//  @override
//  State<StatefulWidget> createState() => _LocationDropDownFieldState();
//
//}
class LocationDropDownField extends StatelessWidget{


   String selectedLocation;
   Function onChanged;
   LocationDropDownField({this.selectedLocation,this.onChanged});

// void onChanged(String newLocation){
//   setState(()=> selectedLocation = newLocation);
//
// }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    return Padding(
//      padding: const EdgeInsets.symmetric(vertical: 8.0),
     return DropdownButtonFormField(
        isExpanded: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Store Location",
        ),
        value: selectedLocation,
        onChanged: (String newSelection) => onChanged(newSelection),
        items:StoreLocations.map((String value){
          return DropdownMenuItem<String>(
            value:value,
            child:Text(value),
          );
        }).toList(),
      );
    //);
  }





}