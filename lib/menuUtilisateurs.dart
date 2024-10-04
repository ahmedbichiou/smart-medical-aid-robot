import 'package:flutter/material.dart';
import 'package:medicalbot/creationUilisateurs.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:convert';
import 'package:medicalbot/ip.dart';
import 'package:expandable/expandable.dart';
import 'package:http/http.dart' as http;
import 'dart:math' as math;

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
const TextStyle bodyText1 =
    TextStyle(fontSize: 25.0, fontFamily: 'Dongle', color: Color(0xff00006f));
 
bool deleted = false;
class Users extends StatefulWidget {
  @override
  State<Users> createState() => _Users();
}

class _Users extends State<Users> {
   
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
       futureAlbumred = fetchAlbum("red");
   futureAlbumgreen = fetchAlbum("green");
   futureAlbumorange = fetchAlbum("orange");
   futureAlbumpurple = fetchAlbum("purple");
   futureAlbumyellow = fetchAlbum("yellow");
    });
  }

bool Comp(String nom)
{
  if(nom =="")
  return true;
  else return false;
}



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorBG,
      body: Column(
        children: [
          Container(
            height: 50,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: FloatingActionButton(
                  heroTag: "back",
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
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
              ),
              Container(
                width: 70,
              ),
              const Text(
                'Medical Bot',
                style: GrandTitle,
              ),
            ],
          ),
          Container(
            height: 30,
            //width:380,
            //color:Colors.blue,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  height: 40,
                  //width:380,
                  //color: Colors.blue,
                  child: Text("Patients List", style: semiGrandTitle)),
            ),
          ),
           Expanded(
             child: ListView(
               physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  FutureBuilder<Album>(
              future: futureAlbumred,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bool condition=false;
                   condition=Comp(snapshot.data!.nom);
                  return condition? Container():ExpantionPanel2(snapshot.data!.nom,snapshot.data!.prenom,"route",Colors.red,"red",callback);
                } else if (snapshot.hasError) {
                  return Container();
                }
           
                // By default, show a loading spinner.
                return Container();
              },
                     ),
             FutureBuilder<Album>(
              future: futureAlbumgreen,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bool condition=false;
                   condition=Comp(snapshot.data!.nom);
                  return condition? Container() : ExpantionPanel2(snapshot.data!.nom,snapshot.data!.prenom,"route",Colors.green,"green",callback);
                } else if (snapshot.hasError) {
                  return Container();
                }
           
                // By default, show a loading spinner.
                return Container();
              },
                     ),
             
                    FutureBuilder<Album>(
              future: futureAlbumpurple,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bool condition=false;
                   condition=Comp(snapshot.data!.nom);
                  return condition? Container() : ExpantionPanel2(snapshot.data!.nom,snapshot.data!.prenom,"route",Colors.purple,"purple",callback);
                } else if (snapshot.hasError) {
                  return Column(children: [
           Container(height: 100,),
           Container(
            width: 120,
                height: 120,
                alignment: AlignmentDirectional.center,
           
           child:CircularProgressIndicator(strokeWidth: 5,),),
           Container(height: 20,),
           Text("No connection to Robot", style: headline2),
                ],);
                }
           
                // By default, show a loading spinner.
                return Column(children: [
           Container(height: 100,),
           Container(
            width: 120,
                height: 120,
                alignment: AlignmentDirectional.center,
           
           child:CircularProgressIndicator(strokeWidth: 5,),),
           Container(height: 20,),
           Text("No connection to Robot", style: headline2),
                ],);
              },
                     ),       
                   FutureBuilder<Album>(
              future: futureAlbumorange,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bool condition=false;
                   condition=Comp(snapshot.data!.nom);
                  return condition? Container() : ExpantionPanel2(snapshot.data!.nom,snapshot.data!.prenom,"route",Colors.orange,"orange",callback);
                } else if (snapshot.hasError) {
                  return Container();
                }
           
                // By default, show a loading spinner.
                return  Container();
              },
                     ),   
                 FutureBuilder<Album>(
              future: futureAlbumyellow,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bool condition=false;
                   condition=Comp(snapshot.data!.nom);
                  return condition? Container() : ExpantionPanel2(snapshot.data!.nom,snapshot.data!.prenom,"route",Colors.yellow,"yellow",callback);
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
              final value = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UsersADD()),
                
              );
              setState(() {
                futureAlbumred = fetchAlbum("red");
   futureAlbumgreen = fetchAlbum("green");
   futureAlbumorange = fetchAlbum("orange");
   futureAlbumpurple = fetchAlbum("purple");
   futureAlbumyellow = fetchAlbum("yellow");
              });
            },
        label: const Text('ADD'),
        icon: const Icon(Icons.add),
        backgroundColor: colorbtnBlueGray,
      ),
    );
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


class Album {
  final String nom;
  final String prenom;
  

  const Album({
    required this.nom,
    required this.prenom,
    
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      nom: json['nom'],
      prenom: json['prenom'],
      
    );
  }
}




class ExpantionPanel2 extends StatefulWidget {
Function callback;
final String nom;
  final String prenom;
  final String route;
  final Color color;
  final String colorSTR;

   ExpantionPanel2(this.nom,this.prenom,this.route,this.color,this.colorSTR,this.callback);
  @override
  State createState() {
   
    return ExpantionPanel2state();
  }
}
  TextStyle titlestyle =  TextStyle(fontSize: 20.0, color: Color(0xff00006f));
  TextStyle undertitlestyle = TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold,fontFamily: 'Montserrat',color: Colors.black);
class ExpantionPanel2state extends State<ExpantionPanel2> {
  Widget build(BuildContext context) {

void deleteAlbum(String couleur) async {
    try {
      final response = await http.post(
        Uri.parse('http://'+ip+':5000/deleteuserbycolor'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{"couleur": couleur}),
      );
      if (response.statusCode.toString() != "") {
       
      }
    } catch (e) {
      print(e);
      
    }
  }
Widget CardInside=
Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
     
         
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 10,
                //color:Colors.blue,
              ),
               Column(
                 children: [
                   Container(
                height: 20,
                width: 20,
                //color:Colors.blue,
              ),
                     Icon(
                               Icons.account_circle_rounded ,
                                color: widget.color,
                               size: 76.0,
                                    ),
                       
                    
                  
                 ],
               ),
              Container(
                height: 80,
                width: 10,
                //color:Colors.blue,
              ),
                Container( //nom
                    height: 120,
                    width: 100,
                    //color:Colors.blue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height:30,
                           width:30,
                          //color: Colors.red,
                          ),

                          
                        Container(
                          height:30,
                          //color: Colors.red,
                          child: Text("First Name", style: titlestyle)),
                         Container(
                          height:30,
                         // color: Colors.blue,
                       child: Text(widget.nom, style: undertitlestyle),),
                      ],
                    )),

  Container(
                    height: 120,
                    width: 40,),                   
                Container(
                    height: 120,
                    width: 100,
                    //color:Colors.green,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height:30,
                           width:30,
                          //color: Colors.red,
                          ),
                        Container(
                          height:30,
                          //color: Colors.red,
                          child: Text("Last Name", style: titlestyle)),
                         Container(
                          height:30,
                         // color: Colors.blue,
                       child: Text(widget.prenom, style: undertitlestyle),),
                      ],
                    )),    
          
      
            ],
          )
    );

void buildingslider() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });
  }
    return  Column(
      children: [
       ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(5),
      child: ScrollOnExpand(
        child: Card(
          elevation: 12,
          color: cardcolor,
          shape: RoundedRectangleBorder(
            //side: BorderSide(color: widget.color, width: 1),
            
            borderRadius: BorderRadius.circular(30),
            
          ),
          child: Column(
            children: <Widget>[
              ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: false,
                  hasIcon: false,
                ),
                header: CardInside,
                collapsed: Container(),
                expanded: Container(
                  height: 70,
                  //color:Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.only(left:10),
                    child: Row(
                      
                      children: [
                      Container(width: MediaQuery.of(context).size.width/3),
                    
                      
                      GestureDetector(
                        onTap: (){
                          deleteAlbum(widget.colorSTR);
                          buildingslider();
                          this.widget.callback();
                          
                        },
                        child: Row(
                          children: [
                            Icon(IconData(0xe1b9, fontFamily: 'MaterialIcons'),size:30),
                            Padding(
                          padding: const EdgeInsets.only(left:5),
                          child: Text("Supprimer"),
                        ),
                          ],
                        ),
                      ),
                      
                    ],),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    )),
      
      
      
      
      ],
    );
  }}



