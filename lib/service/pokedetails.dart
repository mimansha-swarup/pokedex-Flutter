import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:kantodex/service/detail_pages.dart';
import 'package:percent_indicator/percent_indicator.dart';

Color Colour = Color.fromRGBO(140, 100, 135, 1);

class PokeBio extends StatefulWidget {
  Map pokemon;

  PokeBio({this.pokemon});

  @override
  _PokeBioState createState() => _PokeBioState();
}

class _PokeBioState extends State<PokeBio> {
  int _current_index = 0;
  bool _speak = true;
  FlutterTts flutterTts = FlutterTts();

  textSpeech () async{

    await flutterTts.setLanguage('en-IN');
    await flutterTts.setSpeechRate(1);
    await flutterTts.setVolume(1);
    await flutterTts.setVoice('en-in-x-ahp#male_1-local');
    await flutterTts.setPitch(1.2);

  }


  @override
  Widget build(BuildContext context) {
    speak() async{
      await flutterTts.speak("${widget.pokemon['name']}. A ${widget.pokemon['type']} pokemon. ${widget.pokemon['about']}.");

    }
    stop() async{
      await flutterTts.stop();
    }
    textSpeech();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900].withAlpha(150),
        body: _current_index == 0
            ? CustomDetailspage()
            : AttackdDetails(pokemon: widget.pokemon, colour: Colour),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            BuildNavbar(Icons.assignment, 0),
            BuildNavbar(Icons.assessment, 1),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(

          mini: true,
          backgroundColor: Colour,
          child: _speak?Icon(Icons.volume_up ):Icon(Icons.volume_off ),
          onPressed: () {
            setState(() {
              _speak? speak():stop();
              _speak = _speak?false:true;

            });
          },
        ),
      ),
    );
  }

  Widget CustomDetailspage() {
    return CustomScrollView(
      slivers: <Widget>[
        customSliverBar(widget.pokemon['name'], widget.pokemon['num'],
            widget.pokemon['num']),
        SliverToBoxAdapter(
          child: InnerDetails(context, widget.pokemon),
        ), // inner details
      ],
    );
  }

  Widget BuildNavbar(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _current_index = index;
        });
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width / 2,
        decoration: index == _current_index
            ? (BoxDecoration(
                color: Colors.purple[200].withOpacity(.2),
                border: Border(bottom: BorderSide(width: 5.0, color: Colour))))
            : BoxDecoration(),
        child: Icon(
          icon,
          color: index == _current_index ? Colors.white : Colors.grey[600],
        ),
      ),
    );
  }
}

SliverAppBar customSliverBar(String name, String num, String imagelink) {
  return SliverAppBar(
    //backgroundColor: typecolor(pokemon['type'][0]),
    backgroundColor: Colour,

    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40), bottomLeft: Radius.circular(40))),
    floating: true,
    pinned: true,
    snap: true,
    elevation: 10,
    title: TApp(name, num),
    expandedHeight: 300,
    flexibleSpace: FlexibleSpaceBar(
      background: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Hero(tag: '$name', child: pokeImage(imagelink)),
      ),
    ),
  );
} //SliverAppBar

Image pokeImage(String imagelink) {
  return Image.asset(
    'images/$imagelink.png',
  );
}

Widget TApp(String name, String num) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Text(
            '$name',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: 1),
            textAlign: TextAlign.center,
          ),
          flex: 9,
        ),
        //
        Text(
          '#$num',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white.withAlpha(200),
              letterSpacing: 1),
        ),
      ],
    ),
  );
} //helping SliverAppBar

Widget InnerDetails(BuildContext context, Map pokemon) {
  final Column divider = Column(
    children: <Widget>[
      SizedBox(
        height: 10,
      ),
      Divider(
        color: Colors.grey[200].withOpacity(0.6),
        thickness: 0.4,
        indent: 80,
        endIndent: 80,
      ),
      SizedBox(
        height: 10,
      ),
    ],
  );

  return Container(
    //margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    padding: EdgeInsets.symmetric(vertical: 20),

    child: Column(
      children: <Widget>[
        wrapedBody(pokemon['type']), //type
        divider,
        pokeAbout(pokemon['about']), //about
        divider,
        HeightandWeight(pokemon['height'], pokemon['weight']), //height weight
        divider,
        StatsDisplay(context, pokemon['base']), // status bar graph
        divider,
        weaknesResistantCard('Weaknesses', pokemon['weaknesses']),
        divider,
        weaknesResistantCard('Resistant', pokemon['resistant']),
        divider,
        PrevoCard(pokemon['pre_evolution']),
        divider,
        NextevoCard(pokemon['next_evolution'])
      ],
    ),
  );
}

TextStyle subtopicStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontWeight: FontWeight.bold,
  letterSpacing: 1,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(2.0, 3),
      blurRadius: 3.0,
      color: Colors.white38,
    ),
  ],
);

Wrap pokeAbout(String about) {
  final TextStyle abouttextstyle = TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w600,
      letterSpacing: 1,
      fontStyle: FontStyle.italic,
      height: 1.8);
  return Wrap(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          about,
          style: abouttextstyle,
          textAlign: TextAlign.justify,
        ),
      ),
    ],
  );
} //about

Row HeightandWeight(String height, String weight) {
  TextStyle heightWeightTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 1,
  );

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Column(
        children: <Widget>[
          Text(
            height,
            style: subtopicStyle,
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            "Height",
            style: heightWeightTextStyle,
          ),
        ],
      ),
      Column(
        children: <Widget>[
          Text(
            weight,
            style: subtopicStyle,
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            "Weight",
            style: heightWeightTextStyle,
          ),
        ],
      )
    ],
  );
} //height and weight element

Card weaknesResistantCard(String Htext, List factors) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    color: Colors.grey.withAlpha(40),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text(
            Htext,
            style: subtopicStyle,
          ),
          SizedBox(
            height: 20,
          ),
          wrapedBody(factors),
        ],
      ),
    ),
  );
} //weakness and resistant card display

Card SmallCard(String text, Color colour) {
  return Card(
    elevation: 5,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        text,
        style: TextStyle(fontSize: 17, color: Colors.white),
      ),
    ),
    color: colour,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
  );
} // ppokemon name in next and previous evolution

Widget typeCardCustom(String text, Color colour) {
  return Card(
    elevation: 5,
    child: Container(
      width: 110,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          text,
          style: TextStyle(fontSize: 17, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    color: colour,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
  );
} //return color of type

Wrap wrapedBody(var type) {
  return Wrap(
    children: <Widget>[
      for (var i in type) typeCardCustom(i, typecolor(i)),
    ],
    spacing: 20,
    alignment: WrapAlignment.spaceEvenly,
    runSpacing: 20,
  );
} // wraping type of card

Row statDisplay(
    BuildContext context, String stats, int value, Color colour, int divvalue) {
  TextStyle statstextstyle = TextStyle(
      color: Colors.white,
      fontSize: 13,
      fontWeight: FontWeight.w600,
      letterSpacing: 1);
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Expanded(
        flex: 2,
        child: Text(stats, style: statstextstyle),
      ),
      Expanded(
          flex: 9,
          child: LinearPercentIndicator(
            width: MediaQuery.of(context).size.width - 150,
            animation: true,
            progressColor: colour,
            percent: value / divvalue,
            animationDuration: 2000,
            lineHeight: 10,
          )),
      Expanded(
        flex: 1,
        child: Text('$value', style: statstextstyle),
      ),
    ],
  );
} //function for stat

Widget StatsDisplay(BuildContext context, Map stat) {
  SizedBox spaceingbox = SizedBox(
    height: 20,
  );
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    color: Colors.grey.withAlpha(100),
    elevation: 5,
    child: Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      //margin: EdgeInsets.symmetric(horizontal: 5),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Stats',
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1),
          ),
          spaceingbox,
          statDisplay(context, 'HP', stat['hp'], Colors.red, 260), //hp
          spaceingbox,
          statDisplay(
              context, 'Attack', stat['attack'], Colors.yellow, 160), //attack
          spaceingbox,
          statDisplay(
              context, 'Defense', stat['defense'], Colors.blue, 200), //defence
          spaceingbox,
          statDisplay(context, 'Sp. Att.', stat['sp_attack'], Colors.green,
              160), //sp_attack
          spaceingbox,
          statDisplay(context, 'Sp. Def.', stat['sp_defense'], Colors.orange,
              160), //sp_defense
          spaceingbox,
          statDisplay(context, 'Speed', stat['speed'], Colors.purple, 160), //hp
          spaceingbox,
        ],
      ),
    ),
  );
} // displaying stats

Widget NextevoCard(var NextEvolution) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    margin: EdgeInsets.all(10),
    color: Colors.grey.withAlpha(90),
    child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: <Widget>[
          Text(
            'Next Evolution',
            style: subtopicStyle,
          ),
          SizedBox(
            height: 20,
          ),
          NextEvolution == null
              ? Text(
                  'This is Final Form, No Next Evolution',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 100, 255, 1), fontSize: 15),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    for (var i in NextEvolution)
                      SmallCard(i['name'], Color.fromRGBO(10, 150, 10, 1))
                  ],
                ),
        ],
      ),
    ),
  );
} // displayiing next evo card

Widget PrevoCard(var PreEvolution) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))),
    margin: EdgeInsets.all(10),
    color: Colors.grey.withAlpha(90),
    child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: <Widget>[
          Text(
            'Previous Evolution',
            style: subtopicStyle,
          ),
          SizedBox(
            height: 20,
          ),
          PreEvolution == null
              ? Text('This is Initial Form, No Previous Evolution',
                  style: TextStyle(
                      color: Color.fromRGBO(255, 100, 0, 1), fontSize: 15))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    for (var i in PreEvolution)
                      SmallCard(i['name'], Color.fromRGBO(250, 10, 10, 1))
                  ],
                ),
        ],
      ),
    ),
  );
}

Color typecolor(String type) {
  if (type == 'Fire')
    return Colors.deepOrange;
  else if (type == 'Grass')
    return Colors.green;
  else if (type == 'Water')
    return Colors.blue;
  else if (type == 'Bug')
    return Colors.lightGreen[400];
  else if (type == 'Electric')
    return Colors.yellowAccent;
  else if (type == 'Dragon')
    return Colors.deepPurpleAccent[700];
  else if (type == 'Ice')
    return Colors.cyan[300];
  else if (type == 'Flying')
    return Colors.blueAccent[100];
  else if (type == 'Ghost')
    return Colors.deepPurple;
  else if (type == 'Poison')
    return Colors.purple;
  else if (type == 'Fighting')
    return Colors.red[600];
  else if (type == 'Normal')
    return Colors.grey[500];
  else if (type == 'Ground')
    return Colors.brown[400];
  else if (type == 'Rock')
    return Colors.brown[600];
  else if (type == 'Psychic')
    return Colors.pink[400];
  else if (type == 'Steel')
    return Colors.blueAccent;
  else if (type == 'Fairy')
    return Colors.pink[200];
  else if (type == 'Dark')
    return Colors.black;
  else
    return Colors.transparent;
}
