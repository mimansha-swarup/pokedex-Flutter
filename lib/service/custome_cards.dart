import 'package:flutter/material.dart';

class PokeBox extends StatelessWidget {
  Image image;
  Text name;
  PokeBox({this.image, this.name});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      elevation: 5,

      child: Padding(padding: EdgeInsets.all(7),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              name,
              SizedBox(height: 10,),
              image,


            ],
          ),
        ),
      ),


    );
  }
}
