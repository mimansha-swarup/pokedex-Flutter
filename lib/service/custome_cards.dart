//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class PokeBox extends StatelessWidget {
  Image image;
  Text name;
  Text num;
  PokeBox({this.image, this.name,this.num});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(255, 255, 180, .7),
      //fromRGBO(255, 255, 205, .95),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      elevation: 5,

      child: Padding(padding: EdgeInsets.all(1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              Align(
                child: Padding(
                  padding: const EdgeInsets.only(right:8.0),
                  child: num,
                ),
                alignment: Alignment.bottomRight,

              ),
              Container(
                height: 90,
                width: 90,
                child: image,),
              name,


            ],
          ),
        ),
      ),


    );
  }
}
