import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicalbot/emergency.dart';
import 'menuMedicaments.dart';
import 'menuUtilisateurs.dart';
import 'history.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'ip.dart';
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

//------------------------------------------------------------------------------------------------http request area





Future<Album2> fetchAlbum(String C) async {
  final String jsonplaceholderred;
  getipglobal();
  print(ip + C);
  jsonplaceholderred = "http://" + ip + ":5000/getcapsule" + C;

  final response = await http.get(Uri.parse(jsonplaceholderred));
  final jsonresponse = json.decode(response.body);
  
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("loaded album");
    return Album2.fromJson(jsonresponse[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print("failed");
    throw Exception('Failed to load album');
    
  }
}

class Album2 {
  final int capsuleNumber;
  final String medicament1;
  final String medicament2;
  final String medicament3;
  final String datemedicament;
  final String username;
  final String usercolor;
  final String medicament1N;
  final String medicament2N;
  final String medicament3N;

  const Album2({
    required this.capsuleNumber,
    required this.medicament1,
    required this.medicament2,
    required this.medicament3,
    required this.datemedicament,
    required this.username,
    required this.usercolor,
    required this.medicament1N,
    required this.medicament2N,
    required this.medicament3N,
  });

  factory Album2.fromJson(Map<String, dynamic> json) {
    return Album2(
      capsuleNumber: json['capsuleNumber'],
      medicament1: json['medicament1'],
      medicament2: json['medicament2'],
      medicament3: json['medicament3'],
      datemedicament: json['datemedicament'],
      username: json['username'],
      usercolor: json['usercolor'],
      medicament1N: json['medicament1N'],
      medicament2N: json['medicament2N'],
      medicament3N: json['medicament3N'],
    );
  }
}

//------------------------------------------------------------------------------------------------http request area
bool shouldUseFirestoreEmulator = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // navigation bar color
    statusBarColor: Colors.transparent,
  ));
  
  

  
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //fontFamily: 'Dongle',

        primaryColor: Colors.white,
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black), //inside card
          headline2: TextStyle(
              fontSize: 35.0,
              fontStyle: FontStyle.normal,
              fontFamily: 'Dongle',
              color: Color(0xff625B71)), 
          headline5: TextStyle(
              fontSize: 35.0,
              fontStyle: FontStyle.normal,
              fontFamily: 'Dongle',
              color: Colors.white),//titles
          headline3: TextStyle(
              fontSize: 25.0,
              fontStyle: FontStyle.normal,
              fontFamily: 'Dongle',
              color: Color(0xffffffff)), //buttons
          bodyText1: TextStyle(fontSize: 14.0, fontFamily: 'Dongle'),
        ),
      ),
      home: MainMenu()));
}

const cardcolor = const Color(0xffdfe0ff);

// ignore: constant_identifier_names
const GrandTitle = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontFamily: 'Exo2',
    color: Color(0xff0060ac));
const colorBG = const Color(0xffFFFFFF); //background
//const colorBG= const Color(0xff373F47);
const colorTOP = Color(0xffBB86FC); //topbar
const colorbtnBlueGray = Color(0xff3f4ade); //button countour

class MainMenu extends StatefulWidget {
  @override
  _MainMenu createState() {
    return _MainMenu();
  }
}

class _MainMenu extends State<MainMenu> {
  Color CouleurIdentifier(String couleur) {
    switch (couleur) {
      case "red":
        return Colors.red;
        break;

      case "purple":
        return Colors.purple;
        break;
      case "yellow":
        return Colors.yellow;
        break;
      case "green":
        return Colors.green;
        break;
      case "orange":
        return Colors.orange;
        break;
      default:
        return Colors.blue;
        break;
    }
  }

  bool Comp(String nom) {
    if (nom == "")
    {
      
      return true;
    }
      
    else
      return false;
  }

  late Future<Album2> futureAlbum1;
  late Future<Album2> futureAlbum2;
 

  @override
  void initState() {
    super.initState();
    print("init");
    getipglobal(); 
    setState(() {
      futureAlbum1 = fetchAlbum("1");
      futureAlbum2 = fetchAlbum("2");
      
    });
  }

  bool startup = true;
  Widget build(BuildContext context) {
    getipglobal(); 
    void callback2() {
      getipglobal();
      if (startup == true) {
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            futureAlbum1 = fetchAlbum("1");
            futureAlbum2 = fetchAlbum("2");
            
           
            startup = false;
          });
        });
      }
    }

    void refreshMAIN() {
      
      setState(() {
        print("refresh");
        getipglobal();        
        futureAlbum1 = fetchAlbum("1");
        futureAlbum2 = fetchAlbum("2");
       
      });
    }

    callback2();

    Widget Title = Padding(
        padding: EdgeInsets.fromLTRB(30, 30, 0, 10),
        child: Row(
          children: [
            //Text(ip),
            Container(
              width: 100,
              child: Text(
                "Capsules",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
           
              Container(
              height: 80,
              width: MediaQuery.of(context).size.width / 4,
              //color:Colors.grey,
            ),
              //color:Colors.grey,
           
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.fastLinearToSlowEaseIn,
                    type: PageTransitionType.rightToLeft,
                    child: medicamentMenu(refreshMAIN),
                  ),
                );
                refreshMAIN();
              },
              child: Card(
                
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // if you need this
                  side: const BorderSide(
                    color: colorbtnBlueGray,
                    width: 2,
                  ),
                ),
                elevation: 5,
                color: colorbtnBlueGray,
                child: Container(
                  height: 45,
                  width: 120,
                  //color:Colors.blue,
                  child: Row(children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Icon(
                        Icons.settings,
                        color: Color(0xffFFFFFF),
                        size: 20.0,
                      ),
                    ),
                    Text(
                      "Manage",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ));

    Widget TitleUser = Container(
        width: MediaQuery.of(context).size.width/2,
        padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
        child:  GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.fastLinearToSlowEaseIn,
                      type: PageTransitionType.rightToLeft,
                      child: Users(),
                    ),
                  );
                },
                child:Card(
          elevation: 10,
           shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // if you need this       
                  ),
          child: Row(
            children: [
               Container(
                height: 80,
                width: 10,
                //color:Colors.grey,
              ),
              
              Container(
                padding: EdgeInsets.only(left:10),
                width: 100,
                child: Text(
                  "Patients",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
             Container(
               width: 20,
             ),
               Container(
                    height: 45,
                    width: 50,
                    //color:Colors.blue,
                    child: Row(children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Icon(
                          Icons.settings,
                          color: Colors.black,
                          size: 30.0,
                        ),
                      ),
                    
                    ]),
                  ),
                
              
             
            ],
          ),
        )));
Widget HistoryCard = Container(
  width:MediaQuery.of(context).size.width/2,
        padding: EdgeInsets.fromLTRB(10,0, 10, 10),
        child: GestureDetector(
          onTap: (){
            Navigator.push(
                  context,
                  PageTransition(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.fastLinearToSlowEaseIn,
                    type: PageTransitionType.bottomToTop,
                    child: history(),
                  ),
                );
          },
          child: Card(
            
            elevation: 10,
             shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // if you need this       
                    ),
            child: Row(
              children: [
                 Container(
                  height: 80,
                  width: 10,
                  //color:Colors.grey,
                ),
                
                Container(
                  padding: EdgeInsets.only(left:10),
                  width: 100,
                  child: Text(
                    "History",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              Container(
               width: 10,
             ),
                Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Icon(
                          Icons.history,
                          color: Colors.black,
                          size: 30.0,
                        ),
                      ), 
              
              ],
            ),
          ),
        ));
Widget EmergencyCard = Container(
  width:MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(10,0, 10, 10),
        child: GestureDetector(
          onTap: (){
            Navigator.push(
                  context,
                  PageTransition(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.fastLinearToSlowEaseIn,
                    type: PageTransitionType.bottomToTop,
                    child: emergency(),
                  ),
                );
          },
          child: Card(
            color: Colors.redAccent,
            elevation: 10,
             shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),     
                    ),
            child: Row(
              children: [
                 Container(
                  height: 80,
                  width: 10,
                  //color:Colors.grey,
                ),
                
                Container(
                  padding: EdgeInsets.only(left:10),
                  width:MediaQuery.of(context).size.width/1.5,
                  child: Text(
                    "Emergency Capsules",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              Container(
               width: 30,
             ),
                Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Icon(
                          Icons.medical_services_outlined,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ), 
              
              ],
            ),
          ),
        ));
        void changestatefirebase (String capsuleNumber)
async {
   await Firebase.initializeApp();

CollectionReference Capsules = FirebaseFirestore.instance.collection('Capsules');

 


Future<void> updateUser() {
  return Capsules
    .doc('Capsule '+capsuleNumber)
    .update({'deploy': true})
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));
}
updateUser();
  
}

bool comparestring(String med)
{
  if(med == "Not assigned")
  {
return false;
  }
  else{
    return true;
  }
}
 Widget capsule(capsuleNumber,capsulecontent) {        
   return Card(
     
      shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),),
                elevation: 10,
     child: Column(
       
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
      
        children: [
          
        Container(
            alignment: Alignment.topLeft,
            height: 100,
            width: 200,
            //color:Colors.black ,
            padding: const EdgeInsets.all(8.0),
          child:    Text(capsuleNumber, style: headline2blackgrand2)
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(capsulecontent, style :Theme.of(context).textTheme.headline2),
          ),
          Container(
            height: 40,
            //color: Colors.blue,
           
          ),
          
          
              comparestring(capsulecontent)? 
              Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: GestureDetector(
                   onTap: (){
                 changestatefirebase(capsuleNumber);
                  Future.delayed(const Duration(seconds: 4), () {
          setState(() {
            
          });
        });
                            },
              child:Card(
                
                   shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),),
                  elevation: 1,
                  color:cardcolor,
                  child:Container(
                  height: 50,
                  child: Center(child: 
                  Text("Deliver", style :Theme.of(context).textTheme.headline2)
                 )
                  
                  
                  
                  ))),
               )
               :Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: GestureDetector(
                   onTap: (){
                 Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.scale,
                                    alignment: Alignment.topLeft,
                                    child: ipchanger(refreshMAIN)));
            final snackBar = SnackBar(
             backgroundColor: colorBG,
          content: Container(
           
            height: 130,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                   decoration: new BoxDecoration(
                     
        
        shape: BoxShape.circle,
      ),
    child: Icon(Icons.block,color: Colors.red,size:60),
      height: 70,
      width: 70,
                ),
                Container(height: 20,),
                Text('Set  connectivity mode to Online to add content to capulse ',style: TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontFamily: 'Exo2',
    color: Color(0xff625B71),),),
              ],
            ),),
          duration: Duration(seconds: 1),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
   
                            },
              child:Card(
                   shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),),
                  elevation: 1,
                  color:cardcolor,
                  child:Container(
                  height: 50,
                  child: Center(child: 
                  Text("Add content", style :Theme.of(context).textTheme.headline2)
                 )
                  
                  
                  
                  ))),
               ),
        ],
      ),
   );}
   void initalise() async {
await Firebase.initializeApp();
   }
Widget firebasedatacapsule(String capsulenumber,String documentId)  {
   initalise();
   CollectionReference users = FirebaseFirestore.instance.collection('Capsules');
  return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
         return capsule(capsulenumber,"Not assigned");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return capsule(capsulenumber,"Not assigned");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          if( data['medication'] == "")
          {
            return capsule(capsulenumber,"Not assigned");
          }
          else
          {
            return  capsule(capsulenumber,data['medication']);
          }
          }
           
        

        return capsule(capsulenumber,"Not assigned");
      },
    );
}

        



         var size = MediaQuery.of(context).size;
 final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
Widget EmergencyCardDisabled = Container(
  width:MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(10,0, 10, 10),
        child:  Card(
            color: Colors.white,
            elevation: 10,
             shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // if you need this       
                    ),
            child: Container(
              height:  size.height / 1.8,
              child: Column(
                children: [
                  Row(
                    children: [
                       Container(
                        height: 80,
                        width: 10,
                        //color:Colors.grey,
                      ),
                      
                      Container(
                        padding: EdgeInsets.only(left:10),
                        width:MediaQuery.of(context).size.width/1.5,
                        child: Text(
                          "Emergency Capsules",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                    Container(
                     width: 30,
                   ),
                      Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Icon(
                                Icons.medical_services_outlined,
                                color: Colors.black,
                                size: 30.0,
                              ),
                            ), 
                    
                    ],
                  ),
                Expanded(
                  child: GridView.count(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    scrollDirection: Axis.vertical,
                    childAspectRatio: (itemWidth / itemHeight),
                    children: [
                     firebasedatacapsule("3","Capsule 3"),
                     firebasedatacapsule("4","Capsule 4"),  
                          
                                       
                                     
                     
                  
                          
                                       
                                  
                    ])),
                ],
              ),
            ),
          ),
        );
    return Scaffold(
        backgroundColor: colorBG,
        body: Column(
          children: [
            Container(
              height: 40,
            ),
            // Text(ip),
            Row(
              //title : medical bot

              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: FloatingActionButton(
                          heroTag: "back",
                          elevation: 1,
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.scale,
                                    alignment: Alignment.topLeft,
                                    child: ipchanger(refreshMAIN)));
                          },
                          child: const Icon(
                            Icons.settings,
                            color: Colors.black,
                          ),
                          backgroundColor: cardcolor,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                        ),
                      ),
                    ],
                  ),
                ),
                 Container(
                  width: MediaQuery.of(context).size.width /13,
                 ),
                const Text(
                  'Medical Bot',
                  style: GrandTitle,
                ),
                
                
        
              ],
            ),
           if(status == false) Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10,0,10,0),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // if you need this       
                    ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start, 
                        children: [
                          Container(
                            height: 100,
                            //width: 200,
                            //color:Colors.red,
                            child: Title,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height/2,
                            width: MediaQuery.of(context).size.width,
                            //color:Colors.blue,
                            child: ListView(
                              
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                children: [
                                  
                                  FutureBuilder<Album2>(
                                    future: futureAlbum1,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        Color couleur =
                                            CouleurIdentifier(snapshot.data!.usercolor);
                                            
                                        if (Comp(snapshot.data!.username) == false) {
                                          return CardImproved(
                                              snapshot.data!.username,
                                              couleur,
                                              snapshot.data!.datemedicament,
                                              snapshot.data!.medicament1,
                                              snapshot.data!.medicament2,
                                              snapshot.data!.medicament3);
                                        } else {
                                          return Container();
                                        }
                                      } else if (snapshot.hasError) {
                                        return Column(
                                          children: [
                                            Container(
                                              width:
                                                  MediaQuery.of(context).size.height /
                                                      10,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5,
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: 120,
                                                    height: 120,
                                                    //color:Colors.red,
                                                    alignment:
                                                        AlignmentDirectional.center,
                    
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 5,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5,
                                                ),
                                                Center(
                                                  child: Container(
                                                    width: 200,
                                                    height: 40,
                                                    //color:Colors.red,
                                                    alignment:
                                                        AlignmentDirectional.center,
                    
                                                    child: Text(
                                                      "No connection",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      }
                    
                                      // By default, show a loading spinner.
                                      return Column(
                                        children: [
                                          Container(
                                            width:
                                                MediaQuery.of(context).size.height / 10,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width:
                                                    MediaQuery.of(context).size.width /
                                                        5,
                                              ),
                                              Center(
                                                child: Container(
                                                  width: 120,
                                                  height: 120,
                                                  //color:Colors.red,
                                                  alignment:
                                                      AlignmentDirectional.center,
                    
                                                  child: CircularProgressIndicator(
                                                    strokeWidth: 5,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width:
                                                    MediaQuery.of(context).size.width /
                                                        5,
                                              ),
                                              Center(
                                                child: Container(
                                                  width: 200,
                                                  height: 40,
                                                  //color:Colors.red,
                                                  alignment:
                                                      AlignmentDirectional.center,
                    
                                                  child: Text(
                                                    "Pas de connection",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline2,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  Container(
                                    height: 5.0,
                                    width: 10,
                                  ),
                                  FutureBuilder<Album2>(
                                    future: futureAlbum2,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        Color couleur =
                                            CouleurIdentifier(snapshot.data!.usercolor);
                                        if (Comp(snapshot.data!.username) == false) {
                                          return CardImproved(
                                              snapshot.data!.username,
                                              couleur,
                                              snapshot.data!.datemedicament,
                                              snapshot.data!.medicament1,
                                              snapshot.data!.medicament2,
                                              snapshot.data!.medicament3);
                                        } else {
                                          return Container();
                                        }
                                      } else if (snapshot.hasError) {
                                        return Container();
                                      }
                    
                                      // By default, show a loading spinner.
                                      return Container();
                                    },
                                  ),
                                  Container(
                                    height: 5.0,
                                    width: 10,
                                  ),
                                 
                                  
                                ]),
                          ),
                          Container(height: 30,)
                        ],
                      ),
                    ),
                  ),
                
                    //color:Colors.purple,
                    Padding(
                      padding: const EdgeInsets.only(top:10.0),
                      child: Row(
                        children: [
                          TitleUser,
                          HistoryCard,
                        ],
                      ),
                    ),
                   /* true == local
                    false == online */
                 EmergencyCard,

                ],
              ),
            ),
            if(status == true) Column(
              children: [
                Container(
                  height: 30,
                ),
                EmergencyCardDisabled,
              ],
            ),
          ],
        ));
  }
}

class CardImproved extends StatelessWidget {
  final String user;
  final Color usercolor;
  final String date;
  final String nommed1;
  final String nommed2;
  final String nommed3;
  var page;

  CardImproved(this.user, this.usercolor, this.date, this.nommed1, this.nommed2,
      this.nommed3);
  @override
  Widget build(BuildContext context) {
    int long = date.length;
    String dateNew = date.substring(13, long);
    const colorBG = Colors.black;
    const colorTOP = const Color(0xff1B1C1E);
    const TextStyle headline2 = TextStyle(
        fontSize: 40.0,
        fontStyle: FontStyle.normal,
        fontFamily: 'Dongle',
        color: Color(0xff1B1C1E));
    const TextStyle headline3 = TextStyle(
        fontSize: 30.0,
        fontStyle: FontStyle.normal,
        fontFamily: 'Dongle',
        color: Color(0xff1B1C1E));
    const TextStyle bodyText1 = TextStyle(fontSize: 14.0, fontFamily: 'Dongle');
    const medicament = Color(0xff00006f);

    Widget dateRow = Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 50),
              child: Text("Medication date", style: headline3),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // if you need this
              ),
              color: usercolor,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  dateNew,
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ));
    Widget contentRow = Row(
      children: [
        VerticalDivider(
          color: usercolor,
          thickness: 1,
        ),
        Container(
            //color: Colors.green,
            height: 300,
            width: 250,
            child: Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                child: ListView(
                  children: [
                    Container(
                      height: 30,
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Patient",
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Dongle',
                                color: medicament)),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(user, style: headline2),
                      ),
                    ),
                    //medicament1
                    Container(
                      height: 30,
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Medication 1",
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Dongle',
                                color: medicament)),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(nommed1, style: headline2),
                      ),
                    ),
                    //medicament2
                    //const  Divider(color: Colors.black,),
                    if(nommed2 != "") Container(
                      height: 30,
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Medication 2",
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Dongle',
                                color: medicament)),
                      ),
                    ),
                   if(nommed2 != "") Container(
                      height: 40,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(nommed2, style: headline2),
                      ),
                    ),
                    //medicament3
                    //const  Divider( color: Colors.black),
                     if(nommed3 != "") Container(
                      height: 30,
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Medication 3",
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Dongle',
                                color: medicament)),
                      ),
                    ),
                     if(nommed3 != "") Container(
                      height: 40,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(nommed3, style: headline2),
                      ),
                    ),
                  ],
                ))),
      ],
    );

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // if you need this
          side: const BorderSide(
            color: Colors.white10,
            width: 1,
          ),
        ),
        color: cardcolor,
        elevation: 10,
        child: Container(
          height: 400,
          width: 280,
          
          child: Column(
            children: [
              Container(
                  //color: Colors.red,
                  height: 50,
                  width: 280,
                  child: dateRow),
              Divider(color: Colors.black),
              Container(
                  //color: Colors.white,
                  height: 280,
                  width: 280,
                  child: contentRow),
            ],
          ),
        ));
  }
}
