import 'package:flutter/material.dart';
import 'package:kantodex/service/pokedetails.dart';

class AttackdDetails extends StatelessWidget {
  Map pokemon;
  Color colour;
  AttackdDetails({this.pokemon, this.colour});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withAlpha(10),
      appBar: AppBar(
        title: TApp(pokemon['name'], pokemon['num']),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40))),
        backgroundColor: colour,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(1),
              height: 250,
              width: 250,
              child: pokeImage(pokemon['num']),
            ),
            divider,
            HeadingBuilder('Fast Attacks', Colors.orange),
            myTable(pokemon['fast_attack']),
            SizedBox(height: 10,),
            divider,
            SizedBox(height: 10,),
            HeadingBuilder('Special Attacks', Colors.blue),
            myTable(pokemon['special_attack']),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView myTable(List attacks) {
    return SingleChildScrollView(
      child: DataTable(
        dataRowHeight: 60,
        sortColumnIndex: 2,
        sortAscending: true,
        columnSpacing: 10,
        columns: [
          dataColumn('Name', false, 'Name of the Attack'),
          dataColumn('Type', false, 'Type of Attack'),
          dataColumn('Damage', true, 'power of Damage'),

        ],
        rows: [
          for (var i in attacks)
            DataRow(
              cells: [
                dataCell('${i['name']}', Colors.orangeAccent),
                DataCell(buildCard('${i['type']}', typecolor(i['type']),
                    EdgeInsets.symmetric(horizontal: 2, vertical: 10)),

                ),
                dataCell('${i['damage']}', Colors.red)
              ],

            )
        ],
      ),
    );
  }

  Padding HeadingBuilder(String heading, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: Card(
        elevation: 5,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                heading,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                          color: Colors.grey[800],
                          offset: Offset(1, 4),
                          blurRadius: 5)
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataColumn dataColumn(String text, bool isNum, String tooltip) {
    return DataColumn(
        numeric: isNum,
        tooltip: tooltip,
        label: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
          textAlign: TextAlign.center,
        ));
  }

  DataCell dataCell(String value, Color colour) {
    return DataCell(
      Text(
        '$value',
        style: TextStyle(
            color: colour,
            fontSize: 15,
            letterSpacing: 1,
            fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );
  }
}

final Column divider = Column(
  children: <Widget>[
    SizedBox(
      height: 10,
    ),
    Divider(
      color: Colors.grey[200].withOpacity(0.7),
      thickness: 0.4,
      indent: 40,
      endIndent: 40,
    ),
    SizedBox(
      height: 10,
    ),
  ],
);

Widget buildCard(String text, Color colour, EdgeInsets padding) {
  return Card(
    elevation: 5,
    child: Container(
      padding: padding,
      width: 100,
      child: Text(
        text,
        style: TextStyle(fontSize: 17, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    ),
    color: colour,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
  );
}
