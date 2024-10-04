import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicalbot/menuMedicaments.dart';
import 'package:animations/animations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicalbot/rempliremergency.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:medicalbot/ip.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class capsulefirebase {
  capsulefirebase({required this.medicament});

  capsulefirebase.fromJson(Map<String, Object?> json)
    : this(
        
        medicament: json['medicament']! as String,
      );

  
  final String medicament;

  Map<String, Object?> toJson() {
    return {
      'medicament': medicament
    };
  }
}

class EmergencyCapsuleTable {
  final int capsuleNumber;
  final String medicament;

  const EmergencyCapsuleTable ({
    required this.capsuleNumber,
    required this.medicament,
  });

  factory EmergencyCapsuleTable .fromJson(Map<String, dynamic> json) {
    return EmergencyCapsuleTable (
     capsuleNumber: json['capsuleNumber'],
      medicament: json['medicament'],
    );
  }
}

Future<EmergencyCapsuleTable> fetchAlbumEmergency(String N) async {
  final String jsonplaceholderred = "http://" + ip + ":5000/getemergency" + N;
  final response = await http.get(Uri.parse(jsonplaceholderred));
  final jsonresponse = json.decode(response.body);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return EmergencyCapsuleTable .fromJson(jsonresponse[0]);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
bool selected = false;
bool noiconselected = true;
 late File imageFile = File('');
  TextEditingController contentcontroller = TextEditingController();
class emergency extends StatefulWidget {


emergency();
  
 
  @override
  State<emergency> createState() => _emergency();
}
late Future<EmergencyCapsuleTable> futureAlbum3;
  late Future<EmergencyCapsuleTable> futureAlbum4;
class _emergency extends State<emergency> {

@override
  void initState() {
    super.initState();

    setState(() {
      futureAlbum3 = fetchAlbumEmergency("3");
      futureAlbum4 = fetchAlbumEmergency("4");
     
    });
  }  

  Widget build(BuildContext context) {
   
//-----------------------------------------------------------------------------------------------HTTP REQUEST AREA 
 void insertemergencyLOCAL(String capsuleNumber, String medicament) async {
    try {
      final response = await http.post(
        Uri.parse('http://'+ip+':5000/insertemergency'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{"capsuleNumber": capsuleNumber, "medicament": medicament}),
      );
      if (response.statusCode.toString() != "") {
        
      }
    } catch (e) {
      print(e);
      
    }
  }
  Upload(File img,String capsuleNumber) async {    
  var uri = Uri.parse("http://"+ip+":5000/api/image-upload");
 var request = new http.MultipartRequest("POST", uri);
  request.files.add( new http.MultipartFile.fromBytes("image", img.readAsBytesSync(), filename: "Capsule "+capsuleNumber+".jpg", contentType: new MediaType("image", "jpg"))); 
  var response = await request.send();
  print(response.statusCode);
  response.stream.transform(utf8.decoder).listen((value) {
    print(value);
  });
}

 void readytoinsermedicament(
        String capsuleNumber) async {
      try {
        final response = await http.post(
          Uri.parse('http://' + ip + ':5000/readytoinsertmedicament'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'number': capsuleNumber,
           'datemedicament':"empty"
          }),
        );
        if (response.statusCode.toString() != "") {
          setState(() {
            
          });
        }
      } catch (e) {
        
      }
    }


//-----------------------------------------------------------------------------------------------HTTP REQUEST AREA 

//-----------------------------------------------------------------------------------------------FIRESTORE AREA

void insertintofirestore (String capsuleNumber,String medication)
async {
   await Firebase.initializeApp();

CollectionReference Capsules = FirebaseFirestore.instance.collection('Capsules');

  // Obtain science-fiction movies
 

  // Add a movie
Future<void> updateUser() {
  return Capsules
    .doc('Capsule '+capsuleNumber)
    .update({'medication': medication})
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));
}
updateUser();
  
}





















//-----------------------------------------------------------------------------------------------FIRESTORE AREA

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    
  SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
  Widget capsule(capsuleNumber,capsulecontent) {        
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
        child:    Text(capsuleNumber, style: headline2blackgrand2)
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(capsulecontent, style: headline2),
        ),
        Container(
          height: 40,
          //color: Colors.blue,
         
        ),
        
        
           
           
       
        
       
     
       
      ],
    );}

  void reset(){
    setState(() {
       selected = false;
 noiconselected = true;
 contentcontroller.text = "";
    });


    }
    void refresh(){
  setState(() {
    setState(() {
      futureAlbum3 = fetchAlbumEmergency("3");
      futureAlbum4 = fetchAlbumEmergency("4");
     
    });
  });
}
   bool availabilty ()
   {
     if(noiconselected == true && contentcontroller.text != "")
     {
      return true;
     }
     else if (selected == true && contentcontroller.text != "")
     {
       return true;
     }
     else {
       return false;
     }
   }


  Widget capsuleExpanded(capsuleNumber){


  

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (availabilty() == true )
          {
            readytoinsermedicament(capsuleNumber);
            insertintofirestore(capsuleNumber,contentcontroller.text);
            insertemergencyLOCAL(capsuleNumber,contentcontroller.text);
            if(selected == true ) Upload(imageFile,capsuleNumber);
Navigator.push(
                
                context,
                MaterialPageRoute(
                  builder: (context) => rempliremergency(capsuleNumber,reset,refresh)),
                
              );
          }
          else{
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
                Text('No capsule name set ',style: TextStyle(
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
          }    
             
            },
        label: const Text('Save'),
        icon: const Icon(Icons.save),
        backgroundColor: colorbtnBlueGray,
      ),
      body:Column(
        children: [
            Row( // title row
          children: [
             Padding(
               padding: const EdgeInsets.only(left:8.0),
               child: FloatingActionButton(
                          heroTag: "back",
                          elevation: 10,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.blue,
                            size: 20.0,
                          ),
                          backgroundColor: cardcolor,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15.0))),
                        ),
             ),
             Container(width: MediaQuery.of(context).size.width/3,),
            Container(
              //color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 40,),
                  Container(
                    height: 75,
                    width: 200,
                   // color:Colors.greenAccent ,
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Capsule", style: headline2blackgrand1),
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      height: 87,
                      width: 200,
                     // color:Colors.greenAccent ,
                      padding: const EdgeInsets.all(8.0),
                                     child:    Text(capsuleNumber, style: headline2blackgrand2)
                                     ),
                   
                ],
              ),
            ),
           
         
          ],
        ),
          Expanded(
            child: ListView(
              physics:BouncingScrollPhysics(),
              children: [
             Padding(
              padding: const EdgeInsets.fromLTRB(8,8,8,8),
              child: contentcard(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8,8,8,8),
              child: iconcard(),
            ),
           
            
            
            ],),
          ),
        ],
      )
      
      );
  }
  bool Comp(String nom) {
    if (nom == "")
      return true;
    else
      return false;
  }
  
  return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
         
          resizeToAvoidBottomInset: false,
           body:   Column(
             children: [

               Padding(
                 padding: const EdgeInsets.only(top:30),
                 child: Row( // medical bot
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
                      style: GrandTitleblue,
                    ),
                  ],
          ),
               ),
             Container(height: MediaQuery.of(context).size.height/15,),
             Container(
                padding: EdgeInsets.only(left:10,bottom: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(height: 30,child:Text("Emergency Capsules",style:headline2grand))),
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
                      FutureBuilder<EmergencyCapsuleTable>(
                                    future: futureAlbum3,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                       return Comp(snapshot.data!.medicament.toString())?OpenContainer(
                          transitionDuration: Duration(milliseconds: 500),
                          closedColor:Colors.white,
                          closedElevation: 10,
                          openElevation: 10,
                          closedShape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // if you need this
                          ),
                          closedBuilder: (context, action) {
                            return capsule(snapshot.data!.capsuleNumber.toString(),"Empty");
                          },
                          openBuilder: (context, action) {
                            return capsuleExpanded(snapshot.data!.capsuleNumber.toString());
                          }):Container(child:Card(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),),
                elevation: 10,
                            child: capsule(snapshot.data!.capsuleNumber.toString(),snapshot.data!.medicament.toString())));
                                       
                                      }
                    
                                      // By default, show a loading spinner.
                                      return Center(
                                                  child: Container(
                                                   // width: 120,
                                                    //height: 120,
                                                    //color:Colors.red,
                                                    alignment:
                                                        AlignmentDirectional.center,
                    
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 5,
                                                    ),
                                                  ),
                                                );
                                    },
                                  ),
                     
                   FutureBuilder<EmergencyCapsuleTable>(
                                    future: futureAlbum4,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                       return Comp(snapshot.data!.medicament.toString())?OpenContainer(
                          transitionDuration: Duration(milliseconds: 500),
                          closedColor:Colors.white,
                          closedElevation: 10,
                          openElevation: 10,
                          closedShape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // if you need this
                          ),
                          closedBuilder: (context, action) {
                            return capsule(snapshot.data!.capsuleNumber.toString(),"Empty");
                          },
                          openBuilder: (context, action) {
                            return capsuleExpanded(snapshot.data!.capsuleNumber.toString());
                          }):Container(child:Card(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),),
                elevation: 10,
                            child: capsule(snapshot.data!.capsuleNumber.toString(),snapshot.data!.medicament.toString())));
                                       
                                      }
                    
                                      // By default, show a loading spinner.
                                      return Center(
                                                  child: Container(
                                                   // width: 120,
                                                    //height: 120,
                                                    //color:Colors.red,
                                                    alignment:
                                                        AlignmentDirectional.center,
                    
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 5,
                                                    ),
                                                  ),
                                                );
                                    },
                                  ),
                    ])),
            
             ],
           ),
           
           )
           
           
           );
  }}





  class iconcard extends StatefulWidget {
  @override
  State<iconcard> createState() => _iconcard();
}

class _iconcard extends State<iconcard> {

final ImagePicker _picker = ImagePicker();
  late File fileImg = File('');
  bool isLoading = true;
  
 
   String imageSelected = "";

selectImages() async {
      final XFile? selectedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (selectedImage != null) {
        var bytes = File(selectedImage.path).readAsBytesSync();
        String img64 = base64Encode(bytes);
        setState(() {
          imageFile = File(selectedImage.path);
          imageSelected = img64;
          selected = true;
          noiconselected = false;
        });
      }
    }

  Widget build(BuildContext context) {
return Card(
                shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // if you need this
                          
                        ),
                elevation: 10,
                child: Container(
                  height:400 ,
                  width:MediaQuery.of(context).size.width,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(//Capsule Icon
                        padding: EdgeInsets.all(20),
                        child: Text("Capsule Icon",style: headline2grand)),
                      GestureDetector(
                    onTap: (){
                      selectImages();
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          
                           decoration: BoxDecoration(
                        border: Border.all(
                          width: 3,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                          height: 130,
                          width: MediaQuery.of(context).size.width/1.5,
                          child:selected?Container(child:Image.file(
              imageFile,
              fit: BoxFit.fill,
            )):Icon(
                        Icons.camera_alt,
                        color: Colors.grey,
                        size: 50.0,
                        semanticLabel: 'Text to announce in accessibility modes',
                      )
                        ),
                      ),
                    ),
                  ), 
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                   // color:Colors.red,
                    child:Row(children: [//OR
                      Container(width: 20,),
                     Container(//divider
                        decoration: BoxDecoration(
    border: Border.all(
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20))
  ),
                        height: 5,
                        width: MediaQuery.of(context).size.width/3,
                        ),
                      Container(width: 20,),
                     Text("OR",style:headline2),
                     Container(width: 20,),
                    Container(//divider
                        decoration: BoxDecoration(
    border: Border.all(
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.all(Radius.circular(20))
  ),
                        height: 5,
                        width: MediaQuery.of(context).size.width/3,
                        ),
                    ],)),
                
                   GestureDetector(
                     onTap: (){
                      
                         setState(() {
                           noiconselected = !noiconselected;
                           selected = false;
                         });
                        
                       
                       
                     },
                     child: Align(
                       alignment: Alignment.center,
                       child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedContainer(
                                  decoration: noiconselected? BoxDecoration(
                                  color:cardcolor,  
                          border: Border.all(
                            width: 3,
                          color:Colors.blue,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ):BoxDecoration(
                                    color:cardcolor,
                          border: Border.all(
                            width: 3,
                            color:cardcolor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                                  duration:const Duration(seconds: 1),
                                  curve:Curves.fastLinearToSlowEaseIn,
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width/1.5,
                                  height: 100,
                                  child:Text("No icon ",style:headline2grand)
                                  ),
                                
                                
                          ),
                     ),
                   ),
                  
                  ],)
                  
                  
                  
                  
                  ),);
}}




  class contentcard extends StatefulWidget {
  @override
  State<contentcard> createState() => _contentcard();
}

class _contentcard extends State<contentcard> {

 Widget build(BuildContext context) {
return Card(
   shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // if you need this
                          
                        ),
                elevation: 10,
  child:Container(
  height: 200,
  child:Column(
     mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
    children: [
  Container(//Capsule Icon
                        padding: EdgeInsets.all(20),
                        child: Text("Emergency capsule name",style: headline2grand)),
    Padding(
  
                              //nom
  
                              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
  
                              child: Container(
  
                                height: 70,
  
                                // color: Colors.red,
  
                                child: TextFormField(
  
                                  controller: contentcontroller,
  
                                  decoration: InputDecoration(
  
                                    labelText: "Enter name",
  
                                    fillColor: Colors.white,
  
                                    border: OutlineInputBorder(
  
                                      borderRadius: BorderRadius.circular(10.0),
  
                                      borderSide: BorderSide(),
  
                                    ),
  
                                  ),
  
                                ),
  
                              ),
  
                            ),
  
  ],),
));
}}