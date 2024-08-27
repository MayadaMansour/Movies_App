import 'package:flutter/material.dart';

import '../../../utils/color_resource/color_resources.dart';

class TextFieldSearch extends StatelessWidget {
   TextEditingController controller;
   VoidCallback onSubmitted;
   VoidCallback onClear;
   TextFieldSearch({required this.controller,required this.onSubmitted, required this.onClear});
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: ColorResources.yellow,
      controller: controller,
      onSubmitted: (_) => onSubmitted(),
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Color.fromARGB(255, 146, 145, 145)),
        suffixIcon: IconButton(
            onPressed: () {
              onClear();},
            icon: Icon(Icons.clear)),
        prefixIcon: Icon(
          Icons.search_sharp,
          color: Colors.white,
          size: 25,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: Colors.yellow,
              width: 2,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(width: 1, color: Colors.white)),
      ),
    );

  }
}
