import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medicalbot/emergency.dart';
import 'package:medicalbot/ip.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:medicalbot/ip.dart';


class rempliremergency extends StatefulWidget {
String capsuleNumber;
Function reset;
Function refresh;
  rempliremergency(this.capsuleNumber,this.reset,this.refresh);
  
 
  @override
  State<rempliremergency> createState() => _rempliremergency();
}

class _rempliremergency extends State<rempliremergency> {
  

  Widget build(BuildContext context) {


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
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
        
        void insertedmedicament(
        String capsuleNumber) async {
      try {
        final response = await http.post(
          Uri.parse('http://' + ip + ':5000/insertedmedicament'),
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          
          body:
          Column(children: [
           
                Container(height: 50,),
                Center(
                  child: Text(
                    'Add medication to robot',
                    style: GrandTitle,
                  ),
                ),
                Container(height: 20,),
                Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                //color:Colors.red,
                child:Image(image: AssetImage('assets/medicalbot.png'))
                ),
                 Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                //color:Colors.red,
                
                ),
                Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                //color:Colors.red,
                child:Center(child: Text("Fill the robot with medication",style:headline2))
                ),
                 Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                //color:Colors.red,
                child:Center(child: Text("then press the button",style:headline2))
                ),
                 Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                //color:Colors.red,
                
                ),
                  GestureDetector(
                    onTap: (){
                      insertedmedicament(widget.capsuleNumber);
                      widget.reset();
                      widget.refresh();
                      Navigator.pop(context);
                     Navigator.pop(context);
                    },
                    child: Card(
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
                                                    child: Text("End",
                                                        style: headline2white)))),
                  ),
              
           
          ],)
          
          
          ));
  }}