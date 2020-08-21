import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:kantodex/Animation/rotate_image.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {



  void gotoHome() async {

    Response response =await get('https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json');
    Map data =jsonDecode(response.body);


    await Future.delayed(Duration(seconds: 8));
    Navigator.pushReplacementNamed(context, '/home', arguments: data);
  }

  @override
  void initState()  {
    super.initState();

    gotoHome();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.red[300],
              Colors.red[400],
              Colors.red[600],
              Colors.red[700],
              Colors.red[600],
            ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            PokeLoad(),
            SizedBox(
              height: 30,
            ),
            Text(
              'Loading...',
              style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70),
            )
          ],
        ),
      ),
    );
  }
}

class PokeLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SpinKitDualRing(
            size: 100,
            color: Colors.grey[200],
            lineWidth: 3,
          ),
          SpinKitPulse(
            size: 110,
            color: Colors.amberAccent,
            duration: Duration(seconds: 3),
          ),
          RotateImage(),
        ],
      ),
    );
  }
}
//fromRGBO(150, 30, 0, 1)
