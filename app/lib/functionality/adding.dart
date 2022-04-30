import 'package:flutter/material.dart';

import 'function(adding).dart';


class Ask extends StatefulWidget {
  const Ask({ Key? key }) : super(key: key);

  @override
  _AskState createState() => _AskState();
}

class _AskState extends State<Ask> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ADD YOUR FRIEND'S BIRTHDAY",style: TextStyle(
              fontSize: 15  , 
              letterSpacing: 2
            ),),
            SizedBox(height: 20,),
            InkWell(
              onTap: () {
                addDialog(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: 80,
                height: 40,
                decoration:BoxDecoration(
                  color: Color.fromRGBO(85, 229, 185, 1),
                  borderRadius:  BorderRadius.circular(10)
                ),
                child: Text("ADD"),
              ),
            )
          ],
        )
      ),
      
    );
  }
}