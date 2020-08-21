import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:kantodex/service/custome_cards.dart';
import 'package:kantodex/service/pokedetails.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map data;
  List pokedata;
  List <String> num;
  void buildData() {
    data = ModalRoute.of(context).settings.arguments;
    pokedata = data['pokemon'];

  }

  TextStyle nameStyle = TextStyle(fontSize: 15 , fontWeight: FontWeight.w400, letterSpacing: 1.5);

  @override
  Widget build(BuildContext context) {
    buildData();

    return Scaffold(
        backgroundColor: Colors.red[400],
        body: SafeArea(
            child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(151, (i) {
            return Center(
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Hero(
                    child: PokeBox(
                        image: Image.network(
                            '${pokedata[i]['img']}'),
                      name: Text('${pokedata[i]['name']}',style: nameStyle,),
                    ),
                    tag: '${pokedata[i]['name']}',
                  ),
                ),
                onTap:(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PokeBio(
                          pokemon: pokedata[i],
                        ),
                    )
                  );
                }) ,
              ),
            );
          }),
            ),
        )
    );
  }
}
//
