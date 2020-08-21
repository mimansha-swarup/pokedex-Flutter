import 'package:flutter/material.dart';

class PokeBio extends StatelessWidget {
  final Map pokemon;
  PokeBio({this.pokemon});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Hero(
        tag:'${pokemon['name']}',
        child: Container(
          color: Color.fromRGBO(210, 150, 231, 1),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 50,
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Positioned(
                  height: MediaQuery.of(context).size.height ,
                  width: MediaQuery.of(context).size.width - 20,
                  left: 10,
                  top: MediaQuery.of(context).size.height * 0.1,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 70,
                        ),

                        Text(
                          '${pokemon['num']}  ${pokemon['name']}',
                          style: TextStyle(
                            fontSize: 27,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('Height: ${pokemon['height']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: .5)),
                            Text('Weight: ${pokemon['weight']}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: .8)),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Types',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.7,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            for (var i in pokemon['type'])
                              SmallCard(text: i,colour: typecolor(i))
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Previous Evolutions',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.7,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),


                        //previous Evolution
                        pokemon['prev_evolution'] != null?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            for (var i in pokemon['prev_evolution'])
                              SmallCard(text: i['name'],colour: Color.fromRGBO(255, 153, 109, 1)),
                          ],
                        )
                            :Text('This Is Initial Form', style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold), ),

                        SizedBox(
                          height: 40,
                        ),

                        Text(
                          'Next Evolutions',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.7,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        //next evolution
                        pokemon['next_evolution'] != null?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                              for (var i in pokemon['next_evolution'])
                                SmallCard(text: i['name'],colour: Color.fromRGBO(110, 155, 108, 1))
                          ],
                        )
                        :Text('This Is Final Form', style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold), ),

                      ],
                    ),
                  ),
                ),
                Image.network(pokemon['img'],),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SmallCard extends StatelessWidget {
  String text;
  Color colour;
  SmallCard({this.text, this.colour});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(text,
          style: TextStyle(fontSize: 17, color: Colors.white),
        ),
      ),
      color: colour,
      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.all(Radius.circular(25)),
      ),
    );
  }
}
Color typecolor(String type){
  if (type=='Fire') return Colors.orange;
  else if (type=='Grass') return Colors.green;
  else if (type=='Water') return Colors.blue[800];
  else if (type=='Bug') return Colors.lightGreen;
  else if (type=='Electric') return Colors.yellow;
  else if (type=='Dragon') return Colors.cyanAccent;
  else if (type=='Ice') return Colors.cyan;
  else if (type=='Flying') return Colors.blueGrey[600];
  else if (type=='Ghost') return Colors.deepPurple;
  else if (type=='Poison') return Colors.purple;
  else if (type=='Fighting') return Colors.deepOrange;
  else if (type=='Normal') return Colors.grey[600];
  else if (type=='Ground') return Colors.brown[300];
  else if (type=='Rock') return Colors.brown[600];
  else if (type=='Psychic') return Colors.pink;
  else if (type=='Steel') return Colors.blueAccent;
  else if (type=='Fairy') return Colors.pinkAccent;
  else if (type=='Dark') return Colors.black;
  else return Colors.transparent;


}

