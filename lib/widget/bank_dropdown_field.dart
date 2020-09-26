import 'package:berbera_2/models/profile.dart';
import 'package:flutter/material.dart';
//class BankDropDownField extends StatefulWidget{
//  @override
//  State<StatefulWidget> createState() => _BankDropDownFieldState();
//
//}
class BankDropDownField extends StatelessWidget {


  String selectedBank;
  Function onChanged;

  BankDropDownField({this.selectedBank,this.onChanged});

//  void onChanged(String newBank) {
//    setState(() => selectedBank = newBank);
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    return Padding(
//      padding: const EdgeInsets.symmetric(vertical: 8.0),
    return DropdownButtonFormField(
      isExpanded: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.00),
        ),
        hintText: "Bank Name",
      ),
      value: selectedBank,
      onChanged: (String newSelection) => onChanged(newSelection),
      items: BankName.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
    //);
  }
}
