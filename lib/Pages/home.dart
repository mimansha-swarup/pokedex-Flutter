import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kantodex/service/custome_cards.dart';
import 'package:kantodex/service/pokedetails.dart';
import 'package:kantodex/Pages/loading.dart';
//import 'package:cached_network_image/cached_network_image.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List pokedata;

  void buildData() async {
   // print('getting data');
    String data = await DefaultAssetBundle.of(context).loadString("jsonfile/pokemonnew.json");
    final jsonresult = json.decode(data);
    //print(jsonresult);
    //print('here');
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      pokedata = jsonresult['pokemon'];
    });
  }

  @override
  void initState() {
    super.initState();

    buildData();
  }

  TextStyle nameStyle =
      TextStyle(fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 1.5, );

  @override
  Widget build(BuildContext context) {
    Color bg = Colors.grey[800].withRed(190);
    return pokedata == null
        ? Loading()
        : Scaffold(
            backgroundColor: bg,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'PokeDex',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.grey[600],
                      offset: Offset(0.2, 0.5),
                      blurRadius: 3,
                    ),
                  ],
                ),
              ),
              backgroundColor: bg,
              elevation: 0,
            ),
            drawer: Drawer(),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.5),
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(151, (i) {
                    return Center(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Hero(
                            child: PokeBox(
                              image:Image.asset('images/${pokedata[i]['num']}.png' ),
                              num: Text('#${pokedata[i]['num']}',textAlign: TextAlign.end,),
                              name: Text(
                                '${pokedata[i]['name']}',
                                style: nameStyle, softWrap: true,
                              ),
                            ),
                            tag: '${pokedata[i]['name']}',
                            transitionOnUserGestures: true,
                          ),
                        ),
                        onTap: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PokeBio(
                                  pokemon: pokedata[i],
                                ),
                              ));
                        }),
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
  }
}
