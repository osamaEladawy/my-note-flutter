import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final void Function(String)? onChanged;
  final int? maxLines;
  final bool valid;
  final TextEditingController? controller;
  const CustomTextFormField({super.key, this.hintText, this.labelText, this.onChanged, this.maxLines, required this.valid, this.controller});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height:valid  || valid == null ? 50 : 70,
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: (value){
          if(value!.isEmpty){
            return "this field must not be empty" ;
          }
        },
        decoration: InputDecoration(
          contentPadding:const EdgeInsets.only(left: 20),
          hintText: hintText,
          labelText: labelText,
          border:const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          filled: true,
          fillColor: Colors.grey[100],

        ),
        onChanged:onChanged
      ),
    );
  }
}
