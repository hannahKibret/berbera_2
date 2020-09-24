import 'package:berbera_2/models/profile.dart';
import 'package:flutter/material.dart';
//class CategoryDropDownField extends StatefulWidget{
//  @override
//  State<StatefulWidget> createState() => _CategoryDropDownFieldState();
//
//}
class CategoryDropDownField extends StatelessWidget {


  String selectedCategory;
  Function onChanged;

  CategoryDropDownField({this.selectedCategory,this.onChanged});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    return Padding(
//      padding: const EdgeInsets.symmetric(vertical: 8.0),
    return DropdownButtonFormField(
      isExpanded: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Category",
      ),
      value: selectedCategory,
      onChanged: (String newSelection) => onChanged(newSelection),
      items: Categories.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
    //);
  }
}





