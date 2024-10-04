import 'package:flutter/material.dart';
import 'package:medicalbot/Confirmation.dart';
import 'package:medicalbot/ip.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:medicalbot/menuUtilisateurs.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:sqflite/sqflite.dart';
import 'package:medicalbot/dbhelper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http_parser/http_parser.dart';

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
    color: Color(0xffffBB86FC));
//text styles
const TextStyle headline2 = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontFamily: 'Exo2',
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
List<String> items = [];
List<String> photos = [];

class RendezADD extends StatefulWidget {
  String CapsuleNumber;
  Function refreshMenuMED;
  RendezADD(this.CapsuleNumber,this.refreshMenuMED);
  @override
  State<RendezADD> createState() => _RendezADD();
}

class _RendezADD extends State<RendezADD> {
  TimeOfDay _time = TimeOfDay.now();
  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }
DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    

    void callback() {
      setState(() {});
    }
    

    void cardaddercounter() {
      if (addedcards == 1) {
        setState(() {
          card2added = true;
          addedcards++;
        });
      } else if (addedcards == 2) {
        setState(() {
          card3added = true;
          addedcards++;
        });
      }
    }

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));


    void reset() {
      addedcards = 1;
      card2added = false;
      card3added = false;
      selectedValue = null;
      selectednumber = 1;
      selectedValue2 = null;
      selectednumber2 = 1;
      selectedValue3 = null;
      selectednumber3 = 1;
      
    }


 _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050), 
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }
Widget datedebut=
Card(
  elevation: 5,
   shape: RoundedRectangleBorder(
                   
                        borderRadius: BorderRadius.circular(15.0),
                        ),
 child:Padding(padding:EdgeInsets.fromLTRB(10,10,10,10),child:Column(
          
          children: <Widget>[
          
               Container(
                height:40,
                width: 135,
                alignment: Alignment.center,
              
                child:Text("Date",style: TextStyle(fontFamily: 'Dongle',fontSize: 40,color: Colors.black),),),
           
            Container(
              height:55,
              //color: Colors.grey,
              child:TextButton(
                onPressed: () {
                  _selectDate(context);
                },
              child:  Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",style: TextStyle(fontFamily: 'Dongle',fontSize: 40,color: Colors.blueAccent),),
            ),),
           
          ],
        )),
        
        ) ;
Widget heuredebut=
GestureDetector(
                              onTap: _selectTime,
                              child:Card(
  elevation: 5,
   shape: RoundedRectangleBorder(
                   
                        borderRadius: BorderRadius.circular(15.0),
                        ),
 child:Padding(padding:EdgeInsets.fromLTRB(10,10,10,10),child:Column(
          mainAxisAlignment:MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height:40,
              width: 135,
            alignment: Alignment.center,
              child:Text("Time",style: TextStyle(fontFamily: 'Dongle',fontSize: 40,color: Colors.black),),),
             Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 5),
                            child:  Row(
                                children: [
                                  Container(
                                      height: 50,
                                      width: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  10.0) //                 <--- border radius here
                                              ),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.blueAccent, width: 2)),
                                      child: Text(_time.hour.toString(),
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold))),
                                  Container(
                                      height: 50,
                                      width: 10,
                                      alignment: Alignment.center,
                                      child: Text(":",
                                          style: TextStyle(fontSize: 25))),
                                  Container(
                                      height: 50,
                                      width: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  10.0) //                 <--- border radius here
                                              ),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.blueAccent, width: 2)),
                                      child: Text(_time.minute.toString(),
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold))),
                                ],
                              ),
                            ),
                         
           
          ],
        )),
        
        ) );

 void callback2() {
      reset();
      setState(() {});
          }
bool  test()
{ 
   if((selecteduser == "")&&(selectedValue.toString() == "null"))
  {
     final snackBar = SnackBar(
        backgroundColor: Colors.white,
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
                Text('No patient and no medication selected',style: TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontFamily: 'Exo2',
    color: Color(0xff625B71),),),
              ],
            ),),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
return false;
  }
  else if(selectedValue.toString() == "null")
  {
       final snackBar = SnackBar(
        backgroundColor: Colors.white,
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
                Text('no medication selected',style:headline2),
              ],
            ),),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
return false;
  }
  else if(selecteduser == "")
  {
     final snackBar = SnackBar(
        backgroundColor: Colors.white,
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
                Text('no patient selected',style:headline2),
              ],
            ),),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
return false;
  }
  else{ 
    return true;
  }


}
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              heroTag: "save",
              onPressed: () {
                if(test()== true)
                {
                 
Navigator.push(context, PageTransition(
  type: PageTransitionType.scale,
  alignment: Alignment.bottomRight, 
  child: Confirmation(widget.CapsuleNumber,selectedValue.toString(),selectednumber,selectedValue2.toString(),selectednumber2,selectednumber3,selectedValue3.toString(),selectedusernom,selecteduser,_time,selectedDate,callback2,widget.refreshMenuMED)));
                }
               

              },
              backgroundColor: colorbtnBlueGray,
              child: const Icon(Icons.library_add_check, size: 30),
            ),
            resizeToAvoidBottomInset: false,
            backgroundColor: colorBG,
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
                        elevation: 10,
                        onPressed: () {
                          reset();
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
                      width: 70,
                    ),
                    const Text(
                      'Medical Bot',
                      style: GrandTitle,
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      
                      Container(
                        height: 20,
                        //color:Colors.red
                      ),
                     

                      Padding(
                        //Choix temp
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                            height: 40,
                            //width:380,
                            //color: Colors.blue,
                            child: Text("Time and Date",
                                style: semiGrandTitle)),
                      ),
                     
                      Row(
                        children: [
                         Container(
                        width: MediaQuery.of(context).size.width /15,
                      ),
                       heuredebut,
                       Container(
                        width: MediaQuery.of(context).size.width / 10,
                      ),
                        datedebut,
                        
                        ],
                      ),

                      Container(
                        height: 20,
                        //color:Colors.red
                      ),
                      Padding(
                        //Choix utilisateur
                        padding: const EdgeInsets.only(left: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              height: 40,
                              //width:380,
                              //color: Colors.blue,
                              child: Text("Patient",
                                  style: semiGrandTitle)),
                        ),
                      ),
                      Container(
                        //empty space
                        height: 10,
                        //color:Colors.red
                      ),
                      usercards(callback),
                      Row(
                        children: [
                          Padding(
                            //Choix medicaments
                            padding: const EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  height: 40,
                                  //width:380,
                                  //color: Colors.blue,
                                  child: Text("Medication",
                                      style: semiGrandTitle)),
                            ),
                          ),
                          Container(
                            //empty space
                            width: MediaQuery.of(context).size.width / 3,
                            //color:Colors.red
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // if you need this
                                side: const BorderSide(
                                  color: colorbtnBlueGray,
                                  width: 2,
                                ),
                              ),
                              elevation: 1,
                              color: colorbtnBlueGray,
                              child: Container(
                                height: 45,
                                width: 100,
                                //color:Colors.blue,
                                child: Row(children: [
                                  Container(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      cardaddercounter();
                                       final snackBar = SnackBar(
          content: Text('Medicament  ajouter'),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    },
                                    child: Container(
                                        //color:Colors.red,
                                        height: 30,
                                        width: 30,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Icon(
                                            Icons.add,
                                            color: Color(0xffFFFFFF),
                                            size: 20.0,
                                          ),
                                        )),
                                  ),
                                  Container(
                                    height: 30,
                                    child: VerticalDivider(
                                      color: Colors.white,
                                      thickness: 1,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                        useRootNavigator: true,
                                        elevation: 1,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return addCardModel();
                                        },
                                      );
                                    },
                                    child: Container(
                                        //color:Colors.grey,
                                        height: 30,
                                        width: 40,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Icon(
                                            Icons.create_rounded,
                                            color: Color(0xffFFFFFF),
                                            size: 20.0,
                                          ),
                                        )),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //empty space
                        height: 10,
                        //color:Colors.red
                      ),
                      medicards(callback),
                      card2added
                          ? Column(
                              children: [
                                Padding(
                                  //Choix medicaments
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Align(
                                        //Medicament 2
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                            height: 40,
                                            //width:380,
                                            //color: Colors.blue,
                                            child: Text("Medicament 2",
                                                style: semiGrandTitle)),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                      ),
                                      Padding(
                                        //button
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (card3added == true) {
                                                addedcards = 2;
                                                card3added = false;
                                                selectedValue3 = null;
                                                selectednumber3 = 1;
                                              } else {
                                                addedcards = 1;
                                                card2added = false;
                                                selectedValue2 = null;
                                                selectednumber2 = 1;
                                              }
                                            });
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      15), // if you need this
                                            ),
                                            elevation: 5,
                                            color: cardcolor,
                                            child: Container(
                                              height: 45,
                                              width: 50,
                                              //color:Colors.blue,
                                              child: Container(
                                                  //color:Colors.red,
                                                  height: 30,
                                                  width: 30,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.black,
                                                      size: 20.0,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 20),
                                  child: medicards2(callback),
                                ),
                              ],
                            )
                          : Container(),
                      card3added
                          ? Column(
                              children: [
                                Padding(
                                  //Choix medicaments
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Align(
                                        //Medicament 2
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                            height: 40,
                                            //width:380,
                                            //color: Colors.blue,
                                            child: Text("Medicament 3",
                                                style: semiGrandTitle)),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (card3added == true) {
                                              addedcards = 2;
                                              card3added = false;
                                              selectedValue3 = null;
                                                selectednumber3 = 1;
                                            }
                                          });
                                        },
                                        child: Padding(
                                          //button
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      15), // if you need this
                                            ),
                                            elevation: 5,
                                            color: cardcolor,
                                            child: Container(
                                              height: 45,
                                              width: 50,
                                              //color:Colors.blue,
                                              child: Container(
                                                  //color:Colors.red,
                                                  height: 30,
                                                  width: 30,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 0, 0),
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.black,
                                                      size: 20.0,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 20),
                                  child: medicards3(callback),
                                ),
                              ],
                            )
                          : Container(),
                      
                    ],
                  ),
                )
              ],
            )));
  }
}

int addedcards = 1;
bool card2added = false;
bool card3added = false;

class CardEXpandedandEnhanced extends StatelessWidget {
  String nom;
  String prenom;
  Color color1;
  bool stater;
  CardEXpandedandEnhanced(this.nom, this.prenom, this.color1, this.stater);

  Widget build(BuildContext context) {
    TextStyle insidecardnoColor = TextStyle(
        fontSize: 23.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        fontFamily: 'Exo2',
        color: Colors.black);
    TextStyle insidecardnoColor2 = TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        fontFamily: 'Exo2',
        color: Colors.black);
    return Container(
      width: 160.0,
      height: 160.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 30,
              child: Card(
                shape: RoundedRectangleBorder(
                  side: stater
                      ? BorderSide(color: color1, width: 2)
                      : BorderSide(color: Colors.white, width: 0),
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 10,
                child: Container(
                    height: 140,
                    width: 140,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 50),
                          Text(
                            nom,
                            style: insidecardnoColor,
                          ),
                          Text(prenom, style: insidecardnoColor2),
                        ],
                      ),
                    )),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: stater
                      ? BorderSide(color: color1, width: 2)
                      : BorderSide(color: Colors.white, width: 0),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  height: 60,
                  width: 60,
                  child: Icon(
                    Icons.account_circle_rounded,
                    color: color1,
                    size: 60.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

String selecteduser = "";
String selectedusernom = "";

List<Map<String, dynamic>> _journals = [];

class addCardModel extends StatefulWidget {
  @override
  State<addCardModel> createState() => _addCardModel();
}

class _addCardModel extends State<addCardModel> {
  final TextEditingController _nomController = TextEditingController();
  bool selected = false;
  String imageSelected = "";
  late File imageFile = File('');
  String errormessage = "";
  bool medused = false;

  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();

    void usagestatus() {
      for (int i = 0; i < items.length; i++) {
        if (items[i] == _nomController.text) {
          setState(() {
            medused = true;
          });
        }
      }
    }
Upload(File img) async {    

  var uri = Uri.parse("http://"+ip+":5000/api/image-upload");

 var request = new http.MultipartRequest("POST", uri);
  request.files.add( new http.MultipartFile.fromBytes("image", img.readAsBytesSync(), filename: _nomController.text+".jpg", contentType: new MediaType("image", "jpg"))); 
      


  var response = await request.send();
  print(response.statusCode);
  response.stream.transform(utf8.decoder).listen((value) {
    print(value);
  });
}
    Future<void> _addItem() async {
      if ((selected == true) &&
          (_nomController.text != "") &&
          (medused == false)) {
        final snackBar = SnackBar(
          content: Text('Medication created'),
          duration: Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        await SQLHelper.createItem(_nomController.text, imageSelected);
        Upload(imageFile);
        setState(() {
          errormessage = "Medication created";
        });
      } else if (_nomController.text == "") {
        const snackBar = SnackBar(
          content: Text('No name entered'),
          duration: Duration(seconds: 5),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (selected == false) {
        const snackBar = SnackBar(
          content: Text('No photo selected'),
          duration: Duration(seconds: 5),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (medused == true) {
        const snackBar = SnackBar(
          content: Text("medicament already exists"),
          duration: Duration(seconds: 5),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

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
        });
      }
    }

    Widget childofcontainer() {
      if (selected == true) {
        return Container(
            height: 100,
            width: 100,
            child: Image.file(
              imageFile,
              fit: BoxFit.fill,
            ));
      } else {
        return Container(
            height: 100, width: 100, child: Icon(Icons.add_a_photo));
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          color: colorBG,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 0),
                child: Text("Add medication type", style: semiGrandTitle),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: cardcolor,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // if you need this
                  ),
                  child: Container(
                    height: 320,
                    child: Column(
                      children: [
                        Padding(
                          //nom
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Container(
                            height: 70,
                            // color: Colors.red,
                            child: TextFormField(
                              controller: _nomController,
                              decoration: InputDecoration(
                                labelText: 'Medication name',
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                          ),
                        ),

                        GestureDetector(
                          //image selector
                          onTap: () async {
                            selectImages();
                          },
                          child: childofcontainer(),
                        ),
                        Container(
                          width: 50,
                        ),
                        //image preview

                        Container(
                          height: 30,
                        ),
                      
                            
                            GestureDetector(
                              //creer medicament
                              onTap: () async {
                                usagestatus();
                                await _addItem();
                                medused = false;
                                if (errormessage == "Medication created") {
                                  setState(() {
                                    _nomController.text = '';
                                    selected = false;
                                  });
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Row(
                                children: [
                                 Container(width: MediaQuery.of(context).size.width/3),
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
                                          width: 220,
                                          child: Center(
                                              child: Text("Add medication",
                                                  style: headline2white)))),
                                ],
                              ),
                            ),
                         
                      
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class usercards extends StatefulWidget {
  Function callback;
  usercards(this.callback);
  @override
  State<usercards> createState() => _usercards();
}

class _usercards extends State<usercards> {
  bool userred = false;
  bool userorange = false;
  bool useryellow = false;
  bool userpurple = false;
  bool usergreen = false;
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

  bool Comp(String nom) {
    if (nom == "")
      return true;
    else
      return false;
  }

  Future<Album> fetchAlbum(String C) async {
    final String jsonplaceholderred = "http://" + ip + ":5000/getdata" + C;
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

  Widget build(BuildContext context) {
    return Container(
      // users+colors
      height: 190,
      //color:Colors.blue,
      child: ListView(
        physics : ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        //shrinkWrap: true,
        children: [
          FutureBuilder<Album>(
            //red
            future: futureAlbumred,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                bool condition = false;
                condition = Comp(snapshot.data!.nom);
                return condition
                    ? Container()
                    : GestureDetector(
                        //red
                        onTap: () {
                          setState(() {
                            userred = true;
                            usergreen = false;
                            userorange = false;
                            useryellow = false;
                            userpurple = false;
                            selecteduser = "red";
                            selectedusernom = snapshot.data!.prenom+" "+snapshot.data!.nom ;
                            this.widget.callback();
                          });
                        },
                        child: CardEXpandedandEnhanced(snapshot.data!.nom,
                            snapshot.data!.prenom, Colors.red, userred),
                      );
              } else if (snapshot.hasError) {
                return Container();
              }

              // By default, show a loading spinner.
              return Container();
            },
          ),
          FutureBuilder<Album>(
            //green
            future: futureAlbumgreen,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                bool condition = false;
                condition = Comp(snapshot.data!.nom);
                return condition
                    ? Container()
                    : GestureDetector(
                        //green
                        onTap: () {
                          setState(() {
                            usergreen = true;
                            userred = false;
                            userorange = false;
                            useryellow = false;
                            userpurple = false;
                            selecteduser = "green";
                             selectedusernom = snapshot.data!.prenom+" "+snapshot.data!.nom ;
                            this.widget.callback();
                          });
                        },
                        child: CardEXpandedandEnhanced(snapshot.data!.nom,
                            snapshot.data!.prenom, Colors.green, usergreen),
                      );
              } else if (snapshot.hasError) {
                return Container();
              }

              // By default, show a loading spinner.
              return Container();
            },
          ),
          FutureBuilder<Album>(
            //orange
            future: futureAlbumorange,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                bool condition = false;
                condition = Comp(snapshot.data!.nom);
                return condition
                    ? Container()
                    : GestureDetector(
                        //orange
                        onTap: () {
                          setState(() {
                            userorange = true;
                            usergreen = false;
                            userred = false;
                            useryellow = false;
                            userpurple = false;
                            selecteduser = "orange";
                             selectedusernom = snapshot.data!.prenom+" "+snapshot.data!.nom ;
                            this.widget.callback();
                          });
                        },
                        child: CardEXpandedandEnhanced(snapshot.data!.nom,
                            snapshot.data!.prenom, Colors.orange, userorange),
                      );
              } else if (snapshot.hasError) {
                return Container();
              }

              // By default, show a loading spinner.
              return Container();
            },
          ),
          FutureBuilder<Album>(
            //purple
            future: futureAlbumpurple,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                bool condition = false;
                condition = Comp(snapshot.data!.nom);
                return condition
                    ? Container()
                    : GestureDetector(
                        //purple
                        onTap: () {
                          setState(() {
                            userpurple = true;
                            userorange = false;
                            useryellow = false;
                            usergreen = false;
                            userred = false;
                            selecteduser = "purple";
                             selectedusernom = snapshot.data!.prenom+" "+snapshot.data!.nom ;
                            this.widget.callback();
                          });
                        },
                        child: CardEXpandedandEnhanced(snapshot.data!.nom,
                            snapshot.data!.prenom, Colors.purple, userpurple),
                      );
              } else if (snapshot.hasError) {
                return Column(
                  children: [
                    //Container(height: 100,),

                    Container(
                      width: 120,
                      height: 120,
                      alignment: AlignmentDirectional.center,
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                      ),
                    ),
                  ],
                );
              }

              // By default, show a loading spinner.
              return Column(
                children: [
                  //Container(height: 100,),

                  Container(
                    width: 120,
                    height: 120,
                    alignment: AlignmentDirectional.center,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                    ),
                  ),
                ],
              );
            },
          ),
          FutureBuilder<Album>(
            //yellow
            future: futureAlbumyellow,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                bool condition = false;
                condition = Comp(snapshot.data!.nom);
                return condition
                    ? Container()
                    : GestureDetector(
                        //yellow
                        onTap: () {
                          setState(() {
                            useryellow = true;
                            userpurple = false;
                            userorange = false;
                            usergreen = false;
                            userred = false;
                            selecteduser = "yellow";
                             selectedusernom = snapshot.data!.prenom+" "+snapshot.data!.nom ;
                            this.widget.callback();
                          });
                        },
                        child: CardEXpandedandEnhanced(snapshot.data!.nom,
                            snapshot.data!.prenom, Colors.yellow, useryellow),
                      );
              } else if (snapshot.hasError) {
                return Container();
              }

              // By default, show a loading spinner.
              return Container();
            },
          ),
        ],
      ),
    );
  }
}

int selectednumber = 1;
String? selectedValue;

class medicards extends StatefulWidget {
  Function callback;
  medicards(this.callback);
  @override
  State<medicards> createState() => _medicards();
}

class _medicards extends State<medicards> {
  late File fileImg = File('');
  bool isLoading = true;

  bool selected = false;
  int selectedvaluenumber = 0;

  Widget build(BuildContext context) {
    void writeFile(String imageAnalysed) async {
      final decodedBytes = base64Decode(imageAnalysed);
      final directory = await getApplicationDocumentsDirectory();
      setState(() {
        fileImg = File("${directory.path}/testImage" +
            selectedvaluenumber.toString() +
            ".png");

        fileImg.writeAsBytesSync(List.from(decodedBytes));
      });

      setState(() {
        isLoading = false;
      });
    }

    void identifiyimage() {
      String base64fromdb;
      for (int i = 0; i < items.length; i++) {
        if (items[i] == selectedValue) {
          setState(() {
            selectedvaluenumber = i;
          });
          base64fromdb = photos[i];
          writeFile(base64fromdb);
        }
      }
    }

    void remplir() async {
      final data = await SQLHelper.getItems();
      if (this.mounted) {
        setState(() {
          _journals = data;
          //_isLoading = false;
        });
      }
      int i = 0;
      if (items.length < _journals.length) {
        photos.clear();
        items.clear();
        for (i = 0; i < _journals.length; i++) {
          items.add(_journals[i]['nom']);
          photos.add(_journals[i]['photo']);
        }
      }
    }

    Widget childofcontainer() {
      return isLoading
          ? Icon(Icons.medication, size: 50)
          : Container(
              height: 100,
              width: 100,
              child: Image.file(fileImg),
            );
    }

    Widget Medicament1 = DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: const [
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                'Medication 1',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Exo2",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
            this.widget.callback();
          });
        },
        //>>>>>>>>>>>>>>>>>>>>icon
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        // selectedItemHighlightColor:Colors.grey,
        iconEnabledColor: Colors.black,
        iconDisabledColor: Colors.black,
        //>>>>>>>>>>>>>>>>>>>>icon
        buttonHeight: 50,
        buttonWidth: 190,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          //button decoration
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.grey,
          ),
          color: colorBG,
        ),
        buttonElevation: 2,
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 200,
        dropdownWidth: 200,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: false,
      ),
    );
    Widget number1 = Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (selectednumber > 1) {
                selectednumber--;
                this.widget.callback();
              }
            });
          },
          child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                //side: BorderSide(color: widget.color, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                height: 40,
                width: 40,
                child: Icon(Icons.remove),
              )),
        ),
        Container(
          height: 40,
          width: 40,
          //color: Colors.blue,
          child:
              Center(child: Text(selectednumber.toString(), style: headline2)),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectednumber++;
              this.widget.callback();
            });
          },
          child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                //side: BorderSide(color: widget.color, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                height: 40,
                width: 40,
                child: Icon(Icons.add),
              )),
        ),
      ],
    );

    identifiyimage();
    remplir();

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          //side: BorderSide(color: widget.color, width: 1),

          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          height: 240,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  //color:Colors.red,
                  child: Column(
                    children: [
                      Container(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                                height: 30,
                                child: Text("Medication type",
                                    style: headline2))),
                      ),
                      Container(height: 10),
                      Medicament1,
                      Container(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                                height: 30,
                                child: Text("Number", style: headline2))),
                      ),
                      number1,
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  width: 10,
                ),
                Container(
                  height: 200, width: 150,
                  //color:Colors.blue,
                  child: childofcontainer(),
                ),
               
              ],
            ),
          ),
        ),
      )
    );
  }
}

int selectednumber2 = 1;
String? selectedValue2;

class medicards2 extends StatefulWidget {
  Function callback;
  medicards2(this.callback);
  @override
  State<medicards2> createState() => _medicards2();
}

class _medicards2 extends State<medicards2> {
  late File fileImg = File('');
  bool isLoading = true;

  bool selected = false;
  int selectedvaluenumber = 0;

  Widget build(BuildContext context) {
    void writeFile(String imageAnalysed) async {
      final decodedBytes = base64Decode(imageAnalysed);
      final directory = await getApplicationDocumentsDirectory();
      setState(() {
        fileImg = File("${directory.path}/testImage" +
            selectedvaluenumber.toString() +
            ".png");

        fileImg.writeAsBytesSync(List.from(decodedBytes));
      });

      setState(() {
        isLoading = false;
      });
    }

    void identifiyimage() {
      String base64fromdb;
      for (int i = 0; i < items.length; i++) {
        if (items[i] == selectedValue2) {
          setState(() {
            selectedvaluenumber = i;
          });
          base64fromdb = photos[i];
          writeFile(base64fromdb);
        }
      }
    }

    void remplir() async {
      final data = await SQLHelper.getItems();
      if (this.mounted) {
        setState(() {
          _journals = data;
          //_isLoading = false;
        });
      }
      int i = 0;
      if (items.length < _journals.length) {
        photos.clear();
        items.clear();
        for (i = 0; i < _journals.length; i++) {
          items.add(_journals[i]['nom']);
          photos.add(_journals[i]['photo']);
        }
      }
    }

    Widget childofcontainer() {
      return isLoading
          ? Icon(Icons.medication, size: 50)
          : Container(
              height: 100,
              width: 100,
              child: Image.file(fileImg),
            );
    }

    Widget Medicament1 = DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: const [
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                'Medication 1',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Exo2",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue2,
        onChanged: (value) {
          setState(() {
            selectedValue2 = value as String;
            this.widget.callback();
          });
        },
        //>>>>>>>>>>>>>>>>>>>>icon
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        // selectedItemHighlightColor:Colors.grey,
        iconEnabledColor: Colors.black,
        iconDisabledColor: Colors.black,
        //>>>>>>>>>>>>>>>>>>>>icon
        buttonHeight: 50,
        buttonWidth: 190,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          //button decoration
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.grey,
          ),
          color: colorBG,
        ),
        buttonElevation: 2,
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 200,
        dropdownWidth: 200,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: false,
      ),
    );
    Widget number1 = Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (selectednumber2 > 1) {
                selectednumber2--;
                this.widget.callback();
              }
            });
          },
          child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                //side: BorderSide(color: widget.color, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                height: 40,
                width: 40,
                child: Icon(Icons.remove),
              )),
        ),
        Container(
          height: 40,
          width: 40,
          //color: Colors.blue,
          child:
              Center(child: Text(selectednumber2.toString(), style: headline2)),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectednumber2++;
              this.widget.callback();
            });
          },
          child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                //side: BorderSide(color: widget.color, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                height: 40,
                width: 40,
                child: Icon(Icons.add),
              )),
        ),
      ],
    );

    identifiyimage();
    remplir();

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          //side: BorderSide(color: widget.color, width: 1),

          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          height: 240,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  //color:Colors.red,
                  child: Column(
                    children: [
                      Container(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                                height: 30,
                                child: Text("Medication type",
                                    style: headline2))),
                      ),
                      Container(height: 10),
                      Medicament1,
                      Container(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                                height: 30,
                                child: Text("Numbre", style: headline2))),
                      ),
                      number1,
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  width: 10,
                ),
                Container(
                  height: 200, width: 150,
                  //color:Colors.blue,
                  child: childofcontainer(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

int selectednumber3 = 1;
String? selectedValue3;

class medicards3 extends StatefulWidget {
  Function callback;
  medicards3(this.callback);
  @override
  State<medicards3> createState() => _medicards3();
}

class _medicards3 extends State<medicards3> {
  late File fileImg = File('');
  bool isLoading = true;

  bool selected = false;
  int selectedvaluenumber = 0;

  Widget build(BuildContext context) {
    void writeFile(String imageAnalysed) async {
      final decodedBytes = base64Decode(imageAnalysed);
      final directory = await getApplicationDocumentsDirectory();
      setState(() {
        fileImg = File("${directory.path}/testImage" +
            selectedvaluenumber.toString() +
            ".png");

        fileImg.writeAsBytesSync(List.from(decodedBytes));
      });

      setState(() {
        isLoading = false;
      });
    }

    void identifiyimage() {
      String base64fromdb;
      for (int i = 0; i < items.length; i++) {
        if (items[i] == selectedValue3) {
          setState(() {
            selectedvaluenumber = i;
          });
          base64fromdb = photos[i];
          writeFile(base64fromdb);
        }
      }
    }

    void remplir() async {
      final data = await SQLHelper.getItems();
      if (this.mounted) {
        setState(() {
          _journals = data;
          //_isLoading = false;
        });
      }
      int i = 0;
      if (items.length < _journals.length) {
        photos.clear();
        items.clear();
        for (i = 0; i < _journals.length; i++) {
          items.add(_journals[i]['nom']);
          photos.add(_journals[i]['photo']);
        }
      }
    }

    Widget childofcontainer() {
      return isLoading
          ? Icon(Icons.medication, size: 50)
          : Container(
              height: 100,
              width: 100,
              child: Image.file(fileImg),
            );
    }

    Widget Medicament1 = DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: const [
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                'Medication 1',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Exo2",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue3,
        onChanged: (value) {
          setState(() {
            selectedValue3 = value as String;
            this.widget.callback();
          });
        },
        //>>>>>>>>>>>>>>>>>>>>icon
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        // selectedItemHighlightColor:Colors.grey,
        iconEnabledColor: Colors.black,
        iconDisabledColor: Colors.black,
        //>>>>>>>>>>>>>>>>>>>>icon
        buttonHeight: 50,
        buttonWidth: 190,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          //button decoration
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.grey,
          ),
          color: colorBG,
        ),
        buttonElevation: 2,
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 200,
        dropdownWidth: 200,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(40),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: false,
      ),
    );
    Widget number1 = Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (selectednumber3 > 1) {
                selectednumber3--;
                this.widget.callback();
              }
            });
          },
          child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                //side: BorderSide(color: widget.color, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                height: 40,
                width: 40,
                child: Icon(Icons.remove),
              )),
        ),
        Container(
          height: 40,
          width: 40,
          //color: Colors.blue,
          child:
              Center(child: Text(selectednumber3.toString(), style: headline2)),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selectednumber3++;
              this.widget.callback();
            });
          },
          child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                //side: BorderSide(color: widget.color, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                height: 40,
                width: 40,
                child: Icon(Icons.add),
              )),
        ),
      ],
    );

    identifiyimage();
    remplir();

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          //side: BorderSide(color: widget.color, width: 1),

          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          height: 240,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  //color:Colors.red,
                  child: Column(
                    children: [
                      Container(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                                height: 30,
                                child: Text("Medication",
                                    style: headline2))),
                      ),
                      Container(height: 10),
                      Medicament1,
                      Container(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                                height: 30,
                                child: Text("Numbre", style: headline2))),
                      ),
                      number1,
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  width: 10,
                ),
                Container(
                  height: 200, width: 150,
                  //color:Colors.blue,
                  child: childofcontainer(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}