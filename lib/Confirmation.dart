import 'package:flutter/material.dart';
import 'package:medicalbot/ip.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:medicalbot/remplir.dart';
import 'package:intl/intl.dart';

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

const GrandTitle = TextStyle(
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
String serverresponse = "connexion avec le serveur";
class Confirmation extends StatefulWidget {
  String selectedValue, selectedValue2, selectedValue3;
  int selectednumber, selectednumber2, selectednumber3;
  String color, prenom;
  TimeOfDay _time;
  String CapsuleNumber;
  Function callback2;
Function refreshMenuMED;
DateTime _date;
  Confirmation(
      this.CapsuleNumber,
      this.selectedValue,
      this.selectednumber,
      this.selectedValue2,
      this.selectednumber2,
      this.selectednumber3,
      this.selectedValue3,
      this.prenom,
      this.color,
      this._time,
      this._date,
      this.callback2,
      this.refreshMenuMED);
  @override
  State<Confirmation> createState() => _Confirmation();
}

class _Confirmation extends State<Confirmation> {
  

  Widget build(BuildContext context) {
    String selectedValue = widget.selectedValue;
    String selectedValue2 = widget.selectedValue2;
    String selectedValue3 = widget.selectedValue3;
    int selectednumber = widget.selectednumber;
    int selectednumber2 = widget.selectednumber2;
    int selectednumber3 = widget.selectednumber3;
    String selectedusernom = widget.prenom;
    String selecteduser = widget.color;
    TimeOfDay _time = widget._time;
    String CapsuleNumber = widget.CapsuleNumber;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));

    void createAlbum(
        String capsuleNumber,
        String medicament1,
        String medicament2,
        String medicament3,
        String datemedicament,
        String username,
        String usercolor,
        String medicament1N,
        String medicament2N,
        String medicament3N) async {
      try {
        final response = await http.post(
          Uri.parse('http://' + ip + ':5000/insertcapsule' + CapsuleNumber),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'medicament1': medicament1,
            'medicament2': medicament2,
            'medicament3': medicament3,
            'datemedicament': datemedicament,
            'username': username,
            'usercolor': usercolor,
            'medicament1N': medicament1N,
            'medicament2N': medicament2N,
            'medicament3N': medicament3N,
          }),
        );
        if (response.statusCode.toString() != "") {
          setState(() {
            serverresponse = response.statusCode.toString();
          });
        }
      } catch (e) {
        serverresponse = "NOT FOUND";
      }
    }
  void readytoinsermedicament(
        String capsuleNumber,String datemedicament) async {
      try {
        final response = await http.post(
          Uri.parse('http://' + ip + ':5000/readytoinsertmedicament'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'number': capsuleNumber,
           'datemedicament':datemedicament
          }),
        );
        if (response.statusCode.toString() != "") {
          setState(() {
            serverresponse = response.statusCode.toString();
          });
        }
      } catch (e) {
        serverresponse = "NOT FOUND";
      }
    }


  void callback()
  {
    serverresponse = "No connection with server";
    Confirmed = false;
   Navigator.pop(context);
   Navigator.pop(context);
   Navigator.pop(context);
   widget.callback2();
  }
Widget timeWidget=
 Card(
   elevation: 5,
   shape: RoundedRectangleBorder(
                   
                        borderRadius: BorderRadius.circular(15.0),
                        ),
   child:Column(
   children: [
     Container(
              height:40,
              width: 135,
            alignment: Alignment.center,
              child:Text("Time",style: TextStyle(fontFamily: 'Dongle',fontSize: 40,color: Colors.black),),),
     Padding(
                            padding: const EdgeInsets.fromLTRB(20,10,20,10),
                            child: Row(
                              
                              mainAxisAlignment: MainAxisAlignment.center,

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
 ) );
 String formattedDate = DateFormat('yyyy-MM-dd').format(widget._date);
 Widget dateWidget=
 Card(
   elevation: 5,
   shape: RoundedRectangleBorder(
                   
                        borderRadius: BorderRadius.circular(15.0),
                        ),
   child:Column(
   children: [
     Container(
              height:40,
              width: 135,
            alignment: Alignment.center,
              child:Text("Date",style: TextStyle(fontFamily: 'Dongle',fontSize: 40,color: Colors.black),),),
     Padding(
                            padding: const EdgeInsets.all(20),
                            
                            child: Container(child: Text(formattedDate,style:headline2),)
                            ),
   ],
 ) );
    Widget MedicamentCardinsideconfirmation(
        String numeromed, String Value, String number) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
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
                          TextSpan(
                              text: 'Medication type :  ', style: headline2),
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
 String time =  _time.hour.toString() + ":" + _time.minute.toString();
    Widget confirmationcard = Container(
        child:  Expanded(
        
                  child: ListView(
                   shrinkWrap: true,
          
          children: [
             Padding(
                          //Choix temp
                          padding: const EdgeInsets.only(bottom: 5,top: 10,left: 10),
                          child: Container(
                            alignment: Alignment.center,
                              height: 40,
                              //width:380,
                              //color: Colors.blue,
                              child: Text("Time ",
                                  style: semiGrandTitle)),
                        ),
                 Row(
                   children: [
                      Container(
                        width: MediaQuery.of(context).size.width /15,
                      ),
                     timeWidget,
                      Container(
                        width: MediaQuery.of(context).size.width /15,
                      ),
                     dateWidget
                   ],
                 ),
                   Padding(
                          //Choix temp
                          padding: const EdgeInsets.only(bottom: 5,top: 10,left: 10),
                          child: Container(
                            alignment: Alignment.center,
                              height: 40,
                              //width:380,
                              //color: Colors.blue,
                              child: Text("User ",
                                  style: semiGrandTitle)),
                        ),
            Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // if you need this
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child:Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                            text: TextSpan(
                              style: headline3,
                              children: <TextSpan>[
                                TextSpan(text: 'Patient name  ', style: headline2),
                                TextSpan(text: selectedusernom, style: headline2little),
                              ],
                            ),
                          ),
                      Container(height: 10,),
                       RichText(
                            text: TextSpan(
                              style: headline3,
                              children: <TextSpan>[
                                TextSpan(text: 'Patient color  ', style: headline2),
                               
                                TextSpan(text: selecteduser, style: headline2little),
                              ],
                            ),
                          ),
                    ],
                  ), 
                  ))),
                     
                 Padding(
                          //Choix temp
                          padding: const EdgeInsets.only(bottom: 5,top: 10,left: 10),
                          child: Container(
                            alignment: Alignment.center,
                              height: 40,
                              //width:380,
                              //color: Colors.blue,
                              child: Text("Medication ",
                                  style: semiGrandTitle)),
                        ),
            MedicamentCardinsideconfirmation("Medication 1",
                selectedValue.toString(), selectednumber.toString()),
            if (selectedValue2.toString() != "null")MedicamentCardinsideconfirmation("Medication 2", selectedValue2.toString(), selectednumber2.toString()),
            if (selectedValue3.toString() != "null")
              MedicamentCardinsideconfirmation("Medication 3",
                  selectedValue3.toString(), selectednumber3.toString()),
           
              
               
             
          ],
        ),
      ),
    );
//------------------------------------------------------------------------------------------>main   
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
              heroTag: "save",
              onPressed: () {
               
                if(selectedValue2.toString() == "null")
                     {
                        selectedValue2 = "";
                        selectednumber2 = 0;
                     }
                     if(selectedValue3.toString() == "null")
                     {
                        selectedValue3 = "";
                        selectednumber3 = 0;
                     }
                      createAlbum(
                          CapsuleNumber,
                          selectedValue.toString(),
                          selectedValue2.toString(),
                          selectedValue3.toString(),
                         formattedDate+" - "+ time,
                          selectedusernom,
                          selecteduser,
                          selectednumber.toString(),
                          selectednumber2.toString(),
                          selectednumber3.toString());
                      readytoinsermedicament(CapsuleNumber,formattedDate+" - "+ time);
                    showModalBottomSheet<void>(
                                       
                                        useRootNavigator: true,
                                        isDismissible: false,
                                        elevation: 1,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return chargerrobot(CapsuleNumber,callback,widget.refreshMenuMED);
                                        },
                                      );

              },
              backgroundColor: colorbtnBlueGray,
              child: const Icon(Icons.library_add_check, size: 30),
            ),
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
                  width: 80,
                ),
                const Text(
                  'Confirmation',
                  style: GrandTitle,
                ),
              ],
            ),
            confirmationcard,
          ],
        )));
  }
}
bool Confirmed = false;

class chargerrobot extends StatefulWidget {
  String capsuleNumber;
  Function callback;
  Function refreshMenuMED;
  chargerrobot(this.capsuleNumber,this.callback,this.refreshMenuMED);

  @override
  State<chargerrobot> createState() => _chargerrobot();
}

class _chargerrobot extends State<chargerrobot> {
//text styles


 

  void buildingslider() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });
  }
String res = "no connetion with server";
  void checkvalidity() {
    if (serverresponse == "200") {
      setState(() {
        Confirmed = true;
        res = "Saved";
      });
    } else {
      setState(() {
        Confirmed = false;
         res = "no connetion with server";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   
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
              height: 30,
            ),
            Text(res, style: headline2),
          Confirmed? GestureDetector(
             onTap:(){
                 Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  remplir(widget.capsuleNumber,widget.callback,widget.refreshMenuMED)),
            );
             },
             child:
             
             Row(
               children: [
                 Container(width: MediaQuery.of(context).size.width/1.8,),
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
                                              width: 170,
                                              child: Center(
                                                  child: Text("Next step",
                                                      style: headline2white)))),
               ],
             ),):

GestureDetector(
             onTap:(){
               this.widget.callback();
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
