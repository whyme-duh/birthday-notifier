import 'package:app/functionality/function(adding).dart';
import 'package:app/widget.dart/appbar.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AgeFinder extends StatefulWidget {
  const AgeFinder({Key? key}) : super(key: key);

  @override
  _AgeFinderState createState() => _AgeFinderState();
}

class _AgeFinderState extends State<AgeFinder> {
  var DateController = MaskTextInputFormatter(
      mask: '####-##-##', filter: {"#": RegExp(r'[0-9]')});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
          appBar: AppBar(),
          Icons: Icon(Icons.add),
          func: () {
            addDialog(context);
          },
          Heading: Text("AGE FINDER")),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Form(
          key: _formKey,
          child: TextFormField(
            validator: (val) {
              if (val!.isEmpty) {
                return "The field cant be empty";
              }
            },
            keyboardType: TextInputType.number,
            inputFormatters: [DateController],
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "DOB",
              labelText: "Enter DOB",
            ),
          ),
        ),
      ),
    );
  }
}
