import 'package:flutter/material.dart';
import 'package:medicalbot/ip.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:medicalbot/creationRendezvous.dart';
import 'package:animations/animations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:quiver/testing/src/time/time.dart';


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
const TextStyle headline2little = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    fontFamily: 'Exo2',
    color: Color(0xff625B71));
const TextStyle headline2grand = TextStyle(
    fontSize: 25.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontFamily: 'Exo2',
    color: Color(0xff625B71));

//text styles
const TextStyle headline2petit = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontFamily: 'Exo2',
    color: Color(0xff625B71));
const TextStyle headline2 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontFamily: 'Exo2',
    color: Color(0xff625B71));
const TextStyle headline2white = TextStyle(
    fontSize: 25.0,
    fontStyle: FontStyle.normal,
    fontFamily: 'Dongle',
    color: Color(0xffffffff));
const TextStyle headline2whitepetit = TextStyle(
    fontSize: 20.0,
    fontStyle: FontStyle.normal,
    fontFamily: 'Dongle',
    color: Color(0xffffffff));    
const TextStyle headline2whitegrand = TextStyle(
    fontSize: 50.0,
    fontStyle: FontStyle.normal,
    fontFamily: 'Dongle',
    color: Color(0xffffffff));
const TextStyle headline2whitemoyen = TextStyle(
    fontSize: 30.0,
    fontStyle: FontStyle.normal,
    fontFamily: 'Dongle',
    color: Color(0xffffffff));
const TextStyle headline2whitegrand2 = TextStyle(
    fontSize: 70.0,
    fontStyle: FontStyle.normal,
    fontFamily: 'Exo2',
    color: Color(0xffffffff));
const TextStyle headline2blackgrand2 = TextStyle(
    fontSize: 70.0,
    fontStyle: FontStyle.normal,
    fontFamily: 'Exo2',
    color: Color(0xff000000));
const TextStyle headline2blackgrand1 = TextStyle(
    fontSize: 50.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontFamily: 'Exo2',
    color: Color(0xff0060ac));  
const GrandTitle = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontFamily: 'Exo2',
    color: Color(0xff625B71));
const GrandTitleblue = TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontFamily: 'Exo2',
    color: Color(0xff0060ac));
const TextStyle headline3 = TextStyle(
    fontSize: 25.0,
    fontStyle: FontStyle.normal,
    fontFamily: 'Dongle',
    color: Color(0xffffffff));


//------------------------------------------------------------------------------------------------http request area




Future<Album2> fetchAlbum(String C) async {
    final String jsonplaceholderred = "http://" + ip + ":5000/getcapsule"+C;
    final response = await http.get(Uri.parse(jsonplaceholderred));
    final jsonresponse = json.decode(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album2.fromJson(jsonresponse[0]);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

class Album2 {
final  int  capsuleNumber ;
final String medicament1 ;
final String medicament2 ;
final String medicament3 ;
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
class medicamentMenu extends StatefulWidget {
  Function refreshMAIN;
  medicamentMenu(this.refreshMAIN);
  @override
  State<medicamentMenu> createState() => _medicamentMenu();
}

class _medicamentMenu extends State<medicamentMenu> {
 
  late Future<Album2> futureAlbum1;
  late Future<Album2> futureAlbum2;
  late Future<Album2> futureAlbum3;
  late Future<Album2> futureAlbum4;
 
  void initState() {
    super.initState();

    futureAlbum1 = fetchAlbum("1");
    futureAlbum2 = fetchAlbum("2");
    futureAlbum3 = fetchAlbum("3");
    futureAlbum4 = fetchAlbum("4");
    
  }
void refresh()
{
  setState(() {
     futureAlbum1 = fetchAlbum("1");
    futureAlbum2 = fetchAlbum("2");
    futureAlbum3 = fetchAlbum("3");
    futureAlbum4 = fetchAlbum("4");
  });
 
}
  Widget MedicamentCardinsideconfirmation(
      String numeromed, String Value, String number) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 10,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
                                      color: Colors.white10,
                                      width: 1,
                                      ),
          borderRadius: BorderRadius.circular(15), // if you need this
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              height: 95,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(numeromed, style: headline2grand),
                  Container(height: 10),
                  RichText(
                    text: TextSpan(
                      style: headline3,
                      children: <TextSpan>[
                        TextSpan(text: 'Type Medicament :  ', style: headline2),
                        TextSpan(text: Value, style: headline2little),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: headline3,
                      children: <TextSpan>[
                        TextSpan(text: 'Number ', style: headline2),
                        TextSpan(text: number, style: headline2little),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
 ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  Widget build(BuildContext context) {


void deleteAlbum(String capsuleNumber) async {
      try {
        final response = await http.post(
          Uri.parse('http://' + ip + ':5000/deletecapsuleNumber'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
           
          'capsuleNumber':capsuleNumber
          }),
        );
        if (response.statusCode.toString() != "") {
         Navigator.pop(context);
          setState(() {
           
          });

        }
      } catch (e) {
       
      }
    }
    
    Widget medicamentcard(String med)
    {
      return Container(
        height: 30,width: 95,child:
      Card(
       color:Colors.transparent,
         shape : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // if you need this
                      side: const BorderSide(
                                      color: Colors.white,
                                      width: 1,
                                      ),
                                            ),
        elevation: 0,
        child:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(med,style:headline2whitepetit)),
          ),
       
      ));
    }
    bool identifyvide(String identifier)
    {
if(identifier == "")
{
  return false;
}
else return true;
    }
     Widget capsule(String numero, String nomutilisateur, Color couleur,
      String date, String med1, String med2, String med3) {
          bool ident = identifyvide(nomutilisateur);
    return Column(
     
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
    
      children: [
        
      Container(
          alignment: Alignment.topLeft,
          height: 100,
          width: 200,
          //color:Colors.black ,
          padding: const EdgeInsets.all(8.0),
        child:    ident?  Text(numero, style: headline2whitegrand2):Text(numero, style: headline2blackgrand2)
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(nomutilisateur, style: headline2whitemoyen),
        ),
        Container(
          height: 40,
          //color: Colors.blue,
         
        ),
        
        Container(
          height: 50,
         
          child:ListView(
            physics:BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              if(med1!="")medicamentcard(med1),
              if(med2!="") medicamentcard(med2),  
               if(med3!="") medicamentcard(med3),  
            ],)
        ),
        
        Center(
          child: Container(
            width: 170,
            child: Divider(
              thickness: 1,
              color: Colors.white,
            ),   
          ),
        ),
      Center(child: Text(date,style:headline2whitemoyen)),
       
      ],
    );
  }
  bool Comp(String nom)
{
  if(nom =="")
  return true;
  else return false;
}

  Color CouleurIdentifier(String couleur)
{
 switch(couleur) { 
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
//--------------------------------------------------------------------------------------------capsule Expanded
 void deletestatus(
        String capsuleNumber) async {
      try {
        final response = await http.post(
          Uri.parse('http://' + ip + ':5000/deletestatus'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'number': capsuleNumber,
           
          }),
        );
        if (response.statusCode.toString() != "") {
        
        }
      } catch (e) {
   
      }
    }
Widget Tempdeployment(String temp,Color couleur)
{
  return Card(
 elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // if you need this
        ),
child:Container(
  height: 210,
  child:Column(
    children: 
      [
        const  SizedBox(height: 10,),
           SizedBox(
                height: 30,
                child:Text("Time",style:headline2)
              ),
 const SizedBox( height: 10,),
        Container(
            decoration: BoxDecoration(
                  color: couleur,
                  shape: BoxShape.circle
                ),
          height: 140,
          width: 140,
          child:Center(child: Text(temp,style:headline2whitegrand))),
      
    ],),),
  );

}
 DateTime convertstringdatetime(String temp )
{
  
DateTime   time = DateFormat('yyyyy-MM-dd - HH:mm').parse(temp);
return time;
}
  Widget capsuleExpanded(String numero, Color couleur,String nomutilisateur,String couleurSTR,String med1,String med2,String med3,String nmed1,String nmed2,String nmed3,String temp) {
   int pos=temp.indexOf(" - ");
  int long =temp.length;
 String tempNew = temp.substring(13,long); 
   DateTime time  = convertstringdatetime(temp);
    return Scaffold(
      floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          openCloseDial: isDialOpen,
          backgroundColor: couleur,
          overlayColor: Colors.grey,
          overlayOpacity: 0.5,
          spacing: 15,
          spaceBetweenChildren: 15,
          closeManually: true,
          children: [
            
            SpeedDialChild(
              child: Icon(Icons.delete),
              label: 'Supprimer',
                onTap: (){
                deleteAlbum(numero);
                //Navigator.pop(context);
                deletestatus(numero);
                refresh();
                }
            ),
           
          ],
        ),
      body: Column(
        children: [
         Container(height: 30,),
           Container(
             height: 70,
             child: Row(
                    //Capsule numero

                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: FloatingActionButton(
                          heroTag: "back",
                          elevation: 10,
                          onPressed: () {
                           widget.refreshMAIN();
                            Navigator.pop(context);
                             
                          },
                          child:  Icon(
                            Icons.arrow_back_ios_new,
                            color: couleur,
                            size: 20.0,
                          ),
                          backgroundColor: cardcolor,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                        ),
                      ),
                      Container(
                        width: 80,
                      ),
                       Text(
                        "Capsule $numero",
                        style:TextStyle(
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontFamily: 'Exo2',
    color: couleur),
    
                      ),
                    ],
                  ),
           ),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [ 
                                 
                Container(height: 30,),
           //temp  headline     
           Padding(
                                
                                padding: const EdgeInsets.only(left:10,bottom: 20),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                    height: 40,
                                    //width:380,
                                    //color: Colors.blue,
                                    child: Text("Delivery Time",
                                        style: semiGrandTitle)),
                              ),
          //temp elements
         
          Row(
            children: [
          Container(
                
                width:MediaQuery.of(context).size.width/2,
                child: CountdownTimerDemo(time,couleur)),
                 Container(
                
                width:MediaQuery.of(context).size.width/2,
                child: Tempdeployment(tempNew,couleur)),
            ],
          ),
         //Utilisateur headline  
          Padding(
                          //Choix Utilisateur
                          padding: const EdgeInsets.only(bottom: 10,top: 10,left: 10),
                          child: Container(
                            alignment: Alignment.centerLeft,
                              height: 40,
                              //width:380,
                              //color: Colors.blue,
                              child: Text("Patient ",
                                  style: semiGrandTitle)),
                        ),    
         //utilisateur card
         Padding(
           padding: const EdgeInsets.only(left:10,right:10),
           child: Card(
             elevation: 10,
              shape: RoundedRectangleBorder(
       
            borderRadius: BorderRadius.circular(15), // if you need this
        ),
             child: Container(
               height: 100,
               child: Row(children: [
               Container(
                 height: 30,
                 width: 250,
                 //color:Colors.red,
                 padding: EdgeInsets.only(left:20),
                 child: Text(nomutilisateur,style:headline2)),
            Container(width:MediaQuery.of(context).size.width/8 ,),
               Icon( Icons.account_circle_rounded ,
                                    color: couleur,
                                   size: 76.0,
                                        ),
           ],),
             ),),
         ),    
         //medicament headline   
          Padding(
                          //Choix medicament
                          padding: const EdgeInsets.only(bottom: 5,top: 10,left: 10),
                          child: Container(
                            alignment: Alignment.centerLeft,
                              height: 40,
                              //width:380,
                              //color: Colors.blue,
                              child: Text("Medications ",
                                  style: semiGrandTitle)),
                        ), 
            MedicamentCardinsideconfirmation(" medicament 1", med1, nmed1),
        if(med2 != "")  MedicamentCardinsideconfirmation(" medicament 1", med2, nmed2),
        if(med3 != "")    MedicamentCardinsideconfirmation(" medicament 1", med3, nmed3),  
              ],
           
            
            
            ),
          ),
        ],
      ),
    );
  }
//--------------------------------------------------------------------------------------------capsule Expanded      
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
           
            body: Column(
              children: [
                Container(
                  height: 50,
                ),
                Row(
                  //title : medical bot

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: FloatingActionButton(
                        heroTag: "back",
                        elevation: 1,
                        onPressed: () {
                          //widget.refreshMAIN();
                          Navigator.pop(context);
                           widget.refreshMAIN();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 20.0,
                        ),
                      backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/4,
                    ),
                    const Text(
                      'Timed capsules',
                      style: GrandTitle,
                    ),
                  ],
                ),
                Container(
                  height: 10,
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

                      FutureBuilder<Album2>(
           
            future: futureAlbum1,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                bool condition = false;
                condition = Comp(snapshot.data!.username);
                Color usercouleur = CouleurIdentifier(snapshot.data!.usercolor);
                return condition
                    ?  OpenContainer(
                          transitionDuration: Duration(milliseconds: 500),
                          closedElevation: 10,
                          closedShape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // if you need this
                          ),
                          closedBuilder: (context, action) {
                            return capsule("1", "",Colors.orange,
                                "0", "", "", "");
                          },
                          openBuilder: (context, action) {
                         
                 return   RendezADD("1",refresh);
                
                          })
                    : OpenContainer(
                          transitionDuration: Duration(milliseconds: 500),
                          closedColor: usercouleur,
                          closedElevation: 10,
                          openElevation: 10,
                          closedShape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // if you need this
                          ),
                          closedBuilder: (context, action) {
                            return capsule("1", snapshot.data!.username, usercouleur,
                                snapshot.data!.datemedicament, snapshot.data!.medicament1,snapshot.data!.medicament2,snapshot.data!.medicament3);
                          },
                          openBuilder: (context, action) {
                            return capsuleExpanded("1", usercouleur,snapshot.data!.username,snapshot.data!.usercolor,snapshot.data!.medicament1,snapshot.data!.medicament2,snapshot.data!.medicament3,snapshot.data!.medicament1N,snapshot.data!.medicament2N,snapshot.data!.medicament3N,snapshot.data!.datemedicament);
                          });
              } else if (snapshot.hasError) {
                return OpenContainer(
                          transitionDuration: Duration(milliseconds: 500),
                          closedElevation: 10,
                          closedShape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // if you need this
                          ),
                          closedBuilder: (context, action) {
                            return capsule("1", "",Colors.orange,
                                "0", "", "", "");
                          },
                          openBuilder: (context, action) {
                         
                 return   RendezADD("1",refresh);
                
                          });
              }

              // By default, show a loading spinner.
              return OpenContainer(
                          transitionDuration: Duration(milliseconds: 500),
                          closedElevation: 10,
                          closedShape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // if you need this
                          ),
                          closedBuilder: (context, action) {
                            return capsule("1", "",Colors.orange,
                                "0", "", "", "");
                          },
                          openBuilder: (context, action) {
                         
                 return   RendezADD("1",refresh);
                
                          });
            },
          ),
//---------------------------------------------------------->>capsule 2                       
                        FutureBuilder<Album2>(
            future: futureAlbum2,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                bool condition = false;
                condition = Comp(snapshot.data!.username);
                 Color usercouleur = CouleurIdentifier(snapshot.data!.usercolor);
                return condition
                    ?  OpenContainer(
                          transitionDuration: Duration(milliseconds: 500),
                          closedElevation: 10,
                          closedShape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // if you need this
                          ),
                          closedBuilder: (context, action) {
                            return capsule("2", "",Colors.orange,
                                "0", "", "", "");
                          },
                          openBuilder: (context, action) {
                         
                 return   RendezADD("2",refresh);
                
                          })
                    : OpenContainer(
                          transitionDuration: Duration(milliseconds: 500),
                          closedColor: usercouleur,
                          closedElevation: 10,
                          openElevation: 10,
                          closedShape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // if you need this
                          ),
                          closedBuilder: (context, action) {
                            return capsule("2", snapshot.data!.username,usercouleur,
                                snapshot.data!.datemedicament, snapshot.data!.medicament1,snapshot.data!.medicament2,snapshot.data!.medicament3);
                          },
                          openBuilder: (context, action) {
                            return capsuleExpanded("2", usercouleur,snapshot.data!.username,snapshot.data!.usercolor,snapshot.data!.medicament1,snapshot.data!.medicament2,snapshot.data!.medicament3,snapshot.data!.medicament1N,snapshot.data!.medicament2N,snapshot.data!.medicament3N,snapshot.data!.datemedicament);
                          });
              } else if (snapshot.hasError) {
                return OpenContainer(
                          transitionDuration: Duration(milliseconds: 500),
                          closedElevation: 10,
                          closedShape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // if you need this
                          ),
                          closedBuilder: (context, action) {
                            return capsule("2", "",Colors.orange,
                                "0", "", "", "");
                          },
                          openBuilder: (context, action) {
                         
                 return   RendezADD("2",refresh);
                
                          });
              }

              // By default, show a loading spinner.
              return OpenContainer(
                          transitionDuration: Duration(milliseconds: 500),
                          closedElevation: 10,
                          closedShape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // if you need this
                          ),
                          closedBuilder: (context, action) {
                            return capsule("2", "",Colors.orange,
                                "0", "", "", "");
                          },
                          openBuilder: (context, action) {
                         
                 return   RendezADD("2",refresh);
                
                          });
            },
          ),
                   
                    ],
                  ),
                )
              ],
            )));
  }
}



class CountdownTimerDemo extends StatefulWidget {
  DateTime time;
  Color couleur;
  CountdownTimerDemo(this.time,this.couleur);
  @override
  State<CountdownTimerDemo> createState() => _CountdownTimerDemoState();
}



class _CountdownTimerDemoState extends State<CountdownTimerDemo> {
  // Step 2
  Timer? countdownTimer;
  Duration myDuration = Duration(days: 5);
  DateTime now = DateTime.now();


  
   bool start = true;
  @override
  Widget build(BuildContext context) {
   
  
    DateTime deliverytime = widget.time;
  Duration dif = deliverytime.difference(now);
   String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(myDuration.inDays);
  // Step 7
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    double percentage = 1.0;

  void setCountDown() {
    final reduceSecondsBy = 1;
    if(mounted)
    {
setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
    }
    
  }
   void startTimer() {
     myDuration = dif;
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }
    @override

 void firsttimestart()
 {
   if(start == true)
   {
     setState(() {
       startTimer();
     start = false;
     });
     
   } 
 }
 void percentyle()
 {
    if(double.parse('$hours')* 0.1 < 0)
   {
percentage = 0;
   }
else  if(double.parse('$hours') < 10 ) 
   {
percentage =  double.parse('$hours') * 0.1;
   }
  
} 
 
 firsttimestart();
  percentyle(); 
  
    return Card(
      elevation: 10,
        shape: RoundedRectangleBorder(
       
          borderRadius: BorderRadius.circular(15), // if you need this
        ),
      child: Container(
        
        height: 210,
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
                
              ),
              
             const SizedBox(
                height: 30,
                child:Text("Time remaining",style:headline2)
              ),
              const SizedBox(
                height: 10,
                
              ),
              
              CircularPercentIndicator(
                  radius: 70.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: percentage,
                  center: Column(
                    children: [
                      if(days!="00")  Container(     
                    height: 40,
                ),
                     if(days!="00") Text(
                      '$days jours ',
                      style: headline2grand
                ),
                  if(days=="00")  Container(     
                    height: 50,
                ),
                      Text(
                      '$hours:$minutes',
                      style: headline2grand
                ),
                    ],
                  ),
                  
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: widget.couleur,
                ),
            
           
            
             
              
            ],
          ),
        ),
      ),
    );
  }
}