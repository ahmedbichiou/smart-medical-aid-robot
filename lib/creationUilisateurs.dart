import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:medicalbot/menuUtilisateurs.dart';
import 'package:medicalbot/ip.dart';
import 'package:http/http.dart' as http;

//selected color choices
String selectedchosen = "";
bool selectedpurple = false;
bool selectedgreen = false;
bool selectedred = false;
bool selectedyellow = false;
bool selectedorange = false;
String Data = "Pas de connection ";
String Data2 = "";

class UsersADD extends StatefulWidget {
  @override
  State<UsersADD> createState() => _UsersADD();
}

class _UsersADD extends State<UsersADD> {
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  String prenom = "";
  String nom = "";
  void asigndata() {
    setState(() {
      prenom = prenomController.text;
      nom = nomController.text;
    });
  }
  late Future<Album> futureAlbumred;
   late Future<Album> futureAlbumgreen;
    late Future<Album> futureAlbumorange;
     late Future<Album> futureAlbumpurple;
      late Future<Album> futureAlbumyellow;
  
   void initState() {
    super.initState();
   
   futureAlbumred = fetchAlbum("red");
   futureAlbumgreen = fetchAlbum("green");
   futureAlbumorange = fetchAlbum("orange");
   futureAlbumpurple = fetchAlbum("purple");
   futureAlbumyellow = fetchAlbum("yellow");
  }
void callback() {
   setState(() {
     Data = "connexion avec le serveur";
    
    Confirmed = false;
   selectedred = false;
   selectedgreen = false;
   selectedorange = false;
   selectedyellow = false;
   selectedpurple = false;
   selectedchosen = "";
   Data2="";
   Data="";
   Confirmed=false;
   
   });
    Navigator.pop(context);
  }
  void senddata() {
    setState(() {
      createAlbum(nom, prenom, selectedchosen);
    });
  }
bool Comp(String nom)
{
  if(nom =="")
  return true;
  else return false;
}
  void createAlbum(String nom, String prenom, String couleur) async {
    try {
      final response = await http.post(
        Uri.parse('http://'+ip+':5000/insertuserbycolor'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{"nom": nom, "prenom": prenom, "couleur": couleur}),
      );
      if (response.statusCode.toString() != "") {
        setState(() {
          Data2 = response.statusCode.toString();
        });
      }
    } catch (e) {
      print(e);
      Data2 = "NOT FOUND";
    }
  }

Future<Album> fetchAlbum(String C) async {
  final String jsonplaceholderred = "http://"+ip+":5000/getdata"+C;
  final response = await http.get(Uri.parse(jsonplaceholderred));
  final jsonresponse = json.decode(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(jsonresponse[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black));

    //colors
    const GrandTitle = TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        fontFamily: 'Exo2',
        color: Color(0xff0060ac));
    const semiGrandTitle = TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Dongle',
        color: Color(0xff625B71));
    const cardcolor = const Color(0xfff1efff);
    const colorchoicecard = const Color(0xfff0efff);
    const formcolor = const Color(0xffc1c1ff);
    const colorBG = const Color(0xffFFFFFF); //background
    const colorTOP = Color(0xffBB86FC); //topbar
    const colorbtnBlueGray = Color(0xff3f4ade); //button countour

    //text styles
    const TextStyle headline2 = TextStyle(
        fontSize: 35.0,
        fontStyle: FontStyle.normal,
        fontFamily: 'Dongle',
        color: Color(0xff625B71));
    const TextStyle headline2white = TextStyle(
        fontSize: 35.0,
        fontStyle: FontStyle.normal,
        fontFamily: 'Dongle',
        color: Color(0xffffffff));
    const TextStyle headline4 = TextStyle(
        fontSize: 25.0,
        fontStyle: FontStyle.normal,
        fontFamily: 'Dongle',
        color: Color(0xff625B71));
    const TextStyle headline3 = TextStyle(
        fontSize: 25.0,
        fontStyle: FontStyle.normal,
        fontFamily: 'Dongle',
        color: Color(0xffffffff));
    const TextStyle bodyText1 = TextStyle(
        fontSize: 25.0, fontFamily: 'Dongle', color: Color(0xff00006f));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: colorBG,
          body: Column(
            children: [
              Container(
                height: 40,
              ),
              Container(
                  //color: Colors.red,
                  child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: FloatingActionButton(
                      elevation: 10,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 20.0,
                      ),
                      backgroundColor: cardcolor,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                    ),
                  ),
                  Container(
                    width: 60,
                  ),
                  const Text(
                    'Medical Bot',
                    style: GrandTitle,
                  ),
                ],
              )),
              Container(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 15),
                child: Container(
                  height: 590,
                  width: 390,
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // if you need this
                      ),
                      elevation: 10,
                      color: cardcolor,
                      child: Column(
                        children: [
                          Container(
                            height: 20,
                          ),
                         const  Padding(
                            padding:  EdgeInsets.only(left: 20),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child:  Text(
                                  'Adding a Patient',
                                  style: semiGrandTitle,
                                )),
                          ),
                          //Container(height: 100,child:Icon(Icons.account_circle_outlined,size: 140,color: formcolor)),

                          Padding(
                            //nom
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: Container(
                              height: 70,
                              // color: Colors.red,
                              child: TextFormField(
                                controller: nomController,
                                decoration: InputDecoration(
                                  labelText: "Patient name",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            //prenom
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Container(
                              height: 70,
                              // color: Colors.red,
                              child: TextFormField(
                                controller: prenomController,
                                decoration: InputDecoration(
                                  labelText: "Patient last name",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            //empty place
                            height: 20,
                            // child:   Text(Data),//Text(" prenom : "+prenom + "/ nom : "+nom +"/ color : "+ selectedchosen),
                            //color: Colors.red,
                          ),
                          Padding(
                            //color choice stored in selectedchosen
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 20),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15), // if you need this
                                side: const BorderSide(
                                  color: formcolor,
                                  width: 1,
                                ),
                              ),
                              color: cardcolor,
                              child: Column(
                                children: [
                                  Padding(
                                    //couleur headline
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        height: 33,
                                        width: 100,
                                        //color:Colors.red,
                                        child:
                                            Text("Color ", style: headline2),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // couleur sets
                                    padding: EdgeInsets.only(left: 20),
                                    height: 90,
                                    //color:Colors.red,
                                    child: Row(
                                      //colors

                                      children: [
                                        FutureBuilder<Album>(//red
              future: futureAlbumred,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bool condition=false;
                   condition=Comp(snapshot.data!.nom);
                  return condition?   Padding(
                    padding: const EdgeInsets.only(left:5.0),
                    child: GestureDetector(
                                            //red
                                            onTap: () {
                                              setState(() {
                                                selectedred = true;
                                                selectedgreen = false;
                                                selectedorange = false;
                                                selectedyellow = false;
                                                selectedpurple = false;
                                                selectedchosen = "red";
                                              });
                                            },
                                            child: Center(
                                              child: AnimatedContainer(
                                                width: 40,
                                                height: 40,
                                                alignment: Alignment.center,
                                                decoration: selectedred
                                                    ? BoxDecoration(
                                                        color: Colors.red,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: Colors.blue,
                                                            width: 3),
                                                      )
                                                    : BoxDecoration(
                                                        color: Colors.red,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: cardcolor,
                                                            width: 3),
                                                      ),
                                                duration:
                                                    const Duration(seconds: 2),
                                                curve:
                                                    Curves.fastLinearToSlowEaseIn,
                                                child: selectedred
                                                    ? Icon(Icons.check,
                                                        color: Colors.white)
                                                    : null,
                                              ),
                                            ),
                                          ),
                  ):Container();
                } else if (snapshot.hasError) {
                  return Container();
                }
           
                // By default, show a loading spinner.
                return Container();
              },
                     ),
                                      
                                     
                                       FutureBuilder<Album>(//green
              future: futureAlbumgreen,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bool condition=false;
                   condition=Comp(snapshot.data!.nom);
                  return condition?Padding(
                    padding: const EdgeInsets.only(left:5),
                    child: GestureDetector(
                                            //green
                                            onTap: () {
                                              setState(() {
                                                selectedgreen = true;
                                                selectedred = false;
                                                selectedyellow = false;
                                                selectedorange = false;
                                                selectedpurple = false;
                                                selectedchosen = "green";
                                              });
                                            },
                                            child: Center(
                                              child: AnimatedContainer(
                                                width: 40,
                                                height: 40,
                                                alignment:
                                                    AlignmentDirectional.center,
                                                decoration: selectedgreen
                                                    ? BoxDecoration(
                                                        color: Colors.green,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: Colors.blue,
                                                            width: 3),
                                                      )
                                                    : BoxDecoration(
                                                        color: Colors.green,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: cardcolor,
                                                            width: 3),
                                                      ),
                                                duration:
                                                    const Duration(seconds: 2),
                                                curve:
                                                    Curves.fastLinearToSlowEaseIn,
                                                child: selectedgreen
                                                    ? Icon(Icons.check,
                                                        color: Colors.white)
                                                    : null,
                                              ),
                                            ),
                                          ),
                  ):Container();
                } else if (snapshot.hasError) {
                  return Container();
                }
           
                // By default, show a loading spinner.
                return Container();
              },
                     ), 
                                       FutureBuilder<Album>(//purple
              future: futureAlbumpurple,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bool condition=false;
                   condition=Comp(snapshot.data!.nom);
                  return condition? GestureDetector(
                                          //purple
                                          onTap: () {
                                            setState(() {
                                              selectedpurple = true;
                                              selectedgreen = false;
                                              selectedorange = false;
                                              selectedred = false;
                                              selectedyellow = false;
                                              selectedchosen = "purple";
                                            });
                                          },
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left:5),
                                              child: AnimatedContainer(
                                                width: 40,
                                                height: 40,
                                                alignment:
                                                    AlignmentDirectional.center,
                                                decoration: selectedpurple
                                                    ? BoxDecoration(
                                                        color: Colors.purple,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: Colors.blue,
                                                            width: 3),
                                                      )
                                                    : BoxDecoration(
                                                        color: Colors.purple,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: cardcolor,
                                                            width: 3),
                                                      ),
                                                duration:
                                                    const Duration(seconds: 2),
                                                curve:
                                                    Curves.fastLinearToSlowEaseIn,
                                                child: selectedpurple
                                                    ? Icon(Icons.check,
                                                        color: Colors.white)
                                                    : null,
                                              ),
                                            ),
                                          ),
                                        ):Container();
                } else if (snapshot.hasError) {
                  return Container();
                }
           
                // By default, show a loading spinner.
                return Container();
              },
                     ),
                                        
                                      FutureBuilder<Album>(//yellow
              future: futureAlbumyellow,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bool condition=false;
                   condition=Comp(snapshot.data!.nom);
                  return condition? Padding(
                    padding: const EdgeInsets.only(left:5.0),
                    child: GestureDetector(
                                            //yellow
                                            onTap: () {
                                              setState(() {
                                                selectedyellow = true;
                                                selectedgreen = false;
                                                selectedorange = false;
                                                selectedred = false;
                                                selectedpurple = false;
                                                selectedchosen = "yellow";
                                              });
                                            },
                                            child: Center(
                                              child: AnimatedContainer(
                                                width: 40,
                                                height: 40,
                                                alignment:
                                                    AlignmentDirectional.center,
                                                decoration: selectedyellow
                                                    ? BoxDecoration(
                                                        color: Colors.yellow,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: Colors.blue,
                                                            width: 3),
                                                      )
                                                    : BoxDecoration(
                                                        color: Colors.yellow,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: cardcolor,
                                                            width: 3),
                                                      ),
                                                duration:
                                                    const Duration(seconds: 2),
                                                curve:
                                                    Curves.fastLinearToSlowEaseIn,
                                                child: selectedyellow
                                                    ? Icon(Icons.check,
                                                        color: Colors.white)
                                                    : null,
                                              ),
                                            ),
                                          ),
                  ):Container();
                } else if (snapshot.hasError) {
                  return Container();
                }
           
                // By default, show a loading spinner.
                return Container();
              },
                     ),
                                         FutureBuilder<Album>(//orange
              future: futureAlbumorange,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bool condition=false;
                   condition=Comp(snapshot.data!.nom);
                  return condition?  Padding(
                    padding: const EdgeInsets.only(left:5),
                    child: GestureDetector(
                                            //orange
                                            onTap: () {
                                              setState(() {
                                                selectedorange = true;
                                                selectedyellow = false;
                                                selectedgreen = false;
                                                selectedred = false;
                                                selectedpurple = false;
                                                selectedchosen = "orange";
                                              });
                                            },
                                            child: Center(
                                              child: AnimatedContainer(
                                                width: 40,
                                                height: 40,
                                                alignment:
                                                    AlignmentDirectional.center,
                                                decoration: selectedorange
                                                    ? BoxDecoration(
                                                        color: Colors.orange,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: Colors.blue,
                                                            width: 3),
                                                      )
                                                    : BoxDecoration(
                                                        color: Colors.orange,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: cardcolor,
                                                            width: 3),
                                                      ),
                                                duration:
                                                    const Duration(seconds: 2),
                                                curve:
                                                    Curves.fastLinearToSlowEaseIn,
                                                child: selectedorange
                                                    ? Icon(Icons.check,
                                                        color: Colors.white)
                                                    : null,
                                              ),
                                            ),
                                          ),
                  ):Container();
                } else if (snapshot.hasError) {
                  return Container();
                }
           
                // By default, show a loading spinner.
                return Container();
              },
                     ),
                                       
                                       
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Container(
                            //empty place
                            height: 50,
                            // child:   Text(Data),//Text(" prenom : "+prenom + "/ nom : "+nom +"/ color : "+ selectedchosen),
                            //color: Colors.red,
                          ),

                          Padding(
                            //buttons
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  //retourner
                                  onTap: () {
                                    Navigator.pop(context);
                                  },

                                  child: Card(
                                      //retourner
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            15), // if you need this
                                      ),
                                      elevation: 5,
                                      color: cardcolor,
                                      child: Container(
                                          height: 50,
                                          width: 150,
                                          child: Center(
                                              child: Text("Return",
                                                  style: headline2)))),
                                ),
                                Container(
                                  //dead space
                                  height: 50,
                                  width: 20,
                                ),
                                GestureDetector(
                                  //cree button
                                  onTap: () {
                                    asigndata();

                                    senddata();

                                    showModalBottomSheet<void>(
                                     
                                      useRootNavigator: true,
                                      isDismissible: false,
                                      elevation: 1,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return changer(callback);
                                      },
                                    );

                                  },
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 8,
                                      color: colorbtnBlueGray,
                                      child: Container(
                                          height: 50,
                                          width: 150,
                                          child: Center(
                                              child: Text("Create",
                                                  style: headline2white)))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool Confirmed = false;

class changer extends StatefulWidget {
  Function callback;
  changer(this.callback);

  @override
  State<changer> createState() => _changer();
}

class _changer extends State<changer> {
//text styles
  TextStyle headline2 = TextStyle(
      fontSize: 35.0,
      fontStyle: FontStyle.normal,
      fontFamily: 'Dongle',
      color: Color(0xff625B71));
  TextStyle headline2white = TextStyle(
      fontSize: 35.0,
      fontStyle: FontStyle.normal,
      fontFamily: 'Dongle',
      color: Color(0xffffffff));
  TextStyle headline4 = TextStyle(
      fontSize: 25.0,
      fontStyle: FontStyle.normal,
      fontFamily: 'Dongle',
      color: Color(0xff625B71));
  TextStyle headline3 = TextStyle(
      fontSize: 25.0,
      fontStyle: FontStyle.normal,
      fontFamily: 'Dongle',
      color: Color(0xffffffff));
  TextStyle bodyText1 =
      TextStyle(fontSize: 25.0, fontFamily: 'Dongle', color: Color(0xff00006f));

  void asigndata() {
    switch (Data2) {
      case "101":
        Data = "Name";
        break;
      case "102":
        Data = "Last Name";
        break;
      case "103":
        Data = "Color";
        break;
      case "201":
        Data = "Name and Last Name";
        break;
      case "202":
        Data = "Name and color";
        break;
      case "203":
        Data = "Last Name and Color";
        break;
      case "301":
        Data = "Name , Last Name and Color";
        break;
      case "NOT FOUND":
        Data = "No connection to Robot";
        break;
      case "200":
        Data = "Patient added";
        break;
      default:
        Data = "No connection to Robot";
    }
  }

  void buildingslider() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });
  }

  void checkvalidity() {
    if (Data == "Patient added") {
      setState(() {
        Confirmed = true;
      });
    } else {
      setState(() {
        Confirmed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    asigndata();
    buildingslider();

    checkvalidity();
    
    
    return Container(
        height: 260,
        color: colorBG,
        child: Column(
          children: [
           
           
              Container(height: 10,),
            AnimatedContainer(
              width: 120,
              height: 120,
              alignment: AlignmentDirectional.center,
              
              decoration: Confirmed
                  ? BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: cardcolor, width: 1))
                  : BoxDecoration(
                      color: colorBG,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.orange, width: 10),
                    ),
              duration: const Duration(seconds: 2),
              curve: Curves.fastLinearToSlowEaseIn,
              child: Confirmed
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 60,
                    )
                  : const Icon(Icons.timelapse, color: Colors.orange, size: 60),
            ),
            Container(
              height: 20,
            ),
            Text(Data, style: headline2),
          Confirmed? GestureDetector(
             onTap:(){
                Navigator.pop(context);
                 this.widget.callback();
             },
             child:
             
             Row(
               children: [
                 Container(width: MediaQuery.of(context).size.width/1.65,),
                 Card(
                                          //retourner
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                20), // if you need this
                                          ),
                                          elevation: 5,
                                          color: colorbtnBlueGray,
                                          child: Container(
                                              height: 43,
                                              width: 130,
                                              child: Center(
                                                  child: Text("Menu",
                                                      style: headline2white)))),
               ],
             ),):
GestureDetector(
             onTap:(){
                Navigator.pop(context);
             },
             child:
             
             Row(
               children: [
                 Container(width: MediaQuery.of(context).size.width/1.65,),
                 Card(
                                          //retourner
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                15), // if you need this
                                          ),
                                          elevation: 5,
                                          color: cardcolor,
                                          child: Container(
                                              height: 43,
                                              width: 130,
                                              child: Center(
                                                  child: Text("Return",
                                                      style: headline2)))),
               ],
             ),),
          
          ],
        ));
  
  
  }
}
