import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_app_calories/widget/CustomText.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool switchValue = false;
  Color color;
  Color color2;
  double age;
  double size = 0.0;
  DateTime date = new DateTime.now();
  double weight;
  String freq;
  double base;
  double sport;

  @override
  void initState() {
    super.initState();
    changeColor();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: new Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              backgroundColor: color,
            ),
            body: new SingleChildScrollView(
              padding: EdgeInsets.all(15.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new CustomText('Remplissez tous les champs pour obtenir votre besoin journalier en calories', color: Colors.black, factor: 1.2),
                  new Container(
                      height: MediaQuery.of(context).size.height / 1.4,
                      child : new Card(
                          margin: EdgeInsets.all(17.0),
                          elevation: 13.0,
                          child: new Container(
                              child: new Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: new Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        new Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            new CustomText('Femme', color: Colors.pink, factor: 1.25),
                                            new Switch(
                                                value: switchValue,
                                                activeTrackColor: Colors.blue,
                                                inactiveTrackColor: Colors.pink,
                                                inactiveThumbColor: Colors.pink,
                                                onChanged: (bool b) {
                                                  setState(() {
                                                    switchValue = b;
                                                  });
                                                  changeColor();
                                                }),
                                            new CustomText('Homme', color: Colors.blue, factor: 1.25)
                                          ],
                                        ),
                                        new Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              new ElevatedButton(
                                                child: new CustomText((age==null ? 'Entrez votre age' : 'Votre age est de ${age.toStringAsFixed(0)} ans'), factor: 1.25),
                                                onPressed: showDate,
                                                style: new ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all(color),
                                                    padding: MaterialStateProperty.all(EdgeInsets.only(top:15.0, bottom:15.0, left:20.0, right:20.0))
                                                ),
                                              )
                                            ]
                                        ),
                                        new Container(
                                            padding: EdgeInsets.all(10.0),
                                            child: new CustomText('Votre taille est de: ${size.toStringAsFixed(0)} cm', color: Colors.black, factor: 1.25)
                                        ),
                                        new Row(
                                          children: <Widget>[
                                            new Container(
                                                width: MediaQuery.of(context).size.width - 84,
                                                child: new Slider(
                                                    value: size,
                                                    min: 0.0,
                                                    max: 230.0,
                                                    activeColor: color,
                                                    inactiveColor: color2,
                                                    onChanged: (double d) {
                                                      setState(() {
                                                        size = d;
                                                      });
                                                    }
                                                )
                                            )
                                          ],
                                        ),
                                        new TextField(
                                          keyboardType: TextInputType.number,
                                          onChanged: (String data) {
                                            setState(() {
                                              weight = double.tryParse(data);
                                            });
                                          },
                                          decoration: new InputDecoration(
                                            labelText: 'Entrez votre poids (en kilogrammes)',
                                          ),
                                        ),
                                        new Container(
                                          height: 20.0,
                                        ),
                                        new Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              new CustomText('Quelle est votre activité sportive ?', color: color, factor: 1.25),
                                            ]
                                        ),
                                        new Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            new Radio(
                                                value: 'Faible',
                                                fillColor: MaterialStateProperty.all(color),
                                                groupValue: freq,
                                                onChanged: (String data) {
                                                  setState(() {
                                                    freq = data;
                                                  });
                                                }
                                            ),
                                            new Radio(
                                                value: 'Modéré',
                                                fillColor: MaterialStateProperty.all(color),
                                                groupValue: freq,
                                                onChanged: (String data) {
                                                  setState(() {
                                                    freq = data;
                                                  });
                                                }
                                            ),
                                            new Radio(
                                                value: 'Forte',
                                                fillColor: MaterialStateProperty.all(color),
                                                groupValue: freq,
                                                onChanged: (String data) {
                                                  setState(() {
                                                    freq = data;
                                                  });
                                                }
                                            ),
                                          ],
                                        ),
                                        new Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              new CustomText('Faible', color: color, factor: 1.25),
                                              new CustomText('Modéré', color: color, factor: 1.25),
                                              new CustomText('Forte', color: color, factor: 1.25),
                                            ]
                                        )
                                      ]
                                  )
                              )
                          )
                      )
                  ),
                  new ElevatedButton(
                    onPressed: () => calcul(),
                    child: new CustomText('Calculer', factor: 1.25),
                    style: new ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(color),
                        padding: MaterialStateProperty.all(EdgeInsets.only(top:10.0, bottom:10.0, left:20.0, right:20.0))
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
  Future<Null> showDate() async {
    DateTime choice = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(1901),
        lastDate: new DateTime.now()
    );
    if(choice != null) {
      var diff = new DateTime.now().difference(choice);
      var days = diff.inDays;
      var years = (days / 365);
      setState(() {
        age = years;
      });
    }
  }

  void changeColor() {
    if(switchValue) {
      setState(() {
        color = Colors.blue;
        color2 = Colors.lightBlueAccent;
      });
    } else {
      setState(() {
        color = Colors.pink;
        color2 = Colors.pink[200];
      });
    }
  }

  void calcul() {
    (switchValue)? base = 66.4730 + (13.7516 * weight) + (5.0033 * size) - (6.7550 * age) : base = 655.0955 + (9.5634 * weight) + (1.8496 * size) - (4.6756 * age);
    switch(freq) {
      case 'Faible': {
        sport = base * 1.2;
        break;
      }
      case 'Modéré': {
        sport = base * 1.2;
        break;
      }
      case 'Forte': {
        sport = base * 1.2;
        break;
      }
    }
    showAlert();
  }

  Future<Null> showAlert() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new SimpleDialog(
              contentPadding: EdgeInsets.all(15.0),
              children: <Widget>[
                new Container(
                    height: MediaQuery.of(context).size.height / 4.0,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new CustomText('Votre besoin en calories', color: color, factor: 1.1),
                        new Container(height: 20.0),
                        new CustomText('Votre besoin calorique journalier de base est : \n ${base.toStringAsFixed(0)}', color: Colors.black, factor: 1.1),
                        new Container(height: 20.0),
                        new CustomText("Votre besoin calorique journalier avec l'activité sportive est : \n ${sport.toStringAsFixed(0)}", color: Colors.black, factor: 1.1)
                      ],
                    )
                ),
                new ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: new CustomText('OK', color: Colors.white, factor: 1.25),
                  style: new ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(color),
                      padding: MaterialStateProperty.all(EdgeInsets.only(top:10.0, bottom:10.0))
                  ),
                )
              ]
          );
        }
    );
  }
}