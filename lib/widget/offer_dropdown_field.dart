import 'package:berbera_2/models/profile.dart';
import 'package:flutter/material.dart';

class OfferDropDownField extends StatelessWidget {


  String selectedOffer;
  Function onChanged;

  OfferDropDownField({this.selectedOffer,this.onChanged});

List<String> offers = ['discount','others'];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return DropdownButtonFormField(
      isExpanded: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Offer Type',

      ),
      value: selectedOffer,
      onChanged: (String newSelection) => onChanged(newSelection),
      items: offers.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );

  }
}