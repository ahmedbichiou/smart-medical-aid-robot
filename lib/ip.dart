import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:medicalbot/Confirmation.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:medicalbot/dbhelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
bool status = true;
String ip="192.168.1.20";
void getipglobal() async
{

final prefs = await SharedPreferences.getInstance();   
if(prefs.getString('ip') != null)
{
ip = prefs.getString('ip')!;
} 
final prefs2 = await SharedPreferences.getInstance();  
if(prefs2.getBool('mode') != null)
{
status = prefs2.getBool('mode')!;
} 
}

class ipchanger extends StatefulWidget {

Function callback;
ipchanger(this.callback, {Key? key}) : super(key: key);
  
 
  @override
  State<ipchanger> createState() => _ipchanger();
}

class _ipchanger extends State<ipchanger> {
  TextEditingController ipController = TextEditingController();


  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.white));
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
const colorbtnBlueGray = Color(0xff3f4ade);
const TextStyle headline2white = TextStyle(
        fontSize: 35.0,
        fontStyle: FontStyle.normal,
        fontFamily: 'Dongle',
        color: Color(0xffffffff));


 Future<void> _addItem() async {
     
        if(ipController.text == "")
        {
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
                Text('No ip entered',style: TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontFamily: 'Exo2',
    color: Color(0xff625B71),),),
              ],
            ),),
          duration: Duration(seconds: 3),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
       else {
         final snackBar = SnackBar(
             backgroundColor: colorBG,
          content: Container(
           
            height: 130,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  
                   decoration: new BoxDecoration(
                     color: Colors.blue,
        
        shape: BoxShape.circle,
      ),
    child: Icon(Icons.check,color: Colors.white,size:60),
      height: 70,
      width: 70,
                ),
                Container(height: 20,),
                Text('ip entré',style: TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontFamily: 'Exo2',
    color: Color(0xff625B71),),),
              ],
            ),),
          duration: Duration(seconds: 3),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('ip', ipController.text);
       }
        
     
     
      
    }
void getstatus() async{

final prefs = await SharedPreferences.getInstance();
setState(() {
  
 if(prefs.getBool('mode') != null)
{
status = prefs.getBool('mode')!;
} 

  
  
});
}


void getip() async
{
    
final prefs = await SharedPreferences.getInstance();
       
setState(() {
  
 if(prefs.getString('ip') != null)
{
ip = prefs.getString('ip')!;
} 

  
  
});
}

void setMode(bool val)async {
final prefs = await SharedPreferences.getInstance();
await prefs.setBool('mode', val);
}


getip();
getstatus();
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body:
          Column(children: [

          Container(height: MediaQuery.of(context).size.height/10,),
          
            Row(
              children: [
                Padding(
                           padding: const EdgeInsets.all(10.0),
                           child: FloatingActionButton(
                                              heroTag: "back",
                                              elevation: 10,
                                              onPressed: () {
                                         widget.callback();     
                                          Navigator.pop(context);
                                          
                                              },
                                              child: const Icon(
                                                Icons.arrow_back_ios_new,
                                                color: Colors.black,
                                               
                                              ),
                                              backgroundColor: formcolor,
                                              shape: const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(Radius.circular(15.0))),
                                            ),
                         ),
                const Text(
                      'Connectevity Settings',
                      style: GrandTitle,
                    ),
              ],
            ),
                Container(height: MediaQuery.of(context).size.height/10,),
                    Card(
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                      color: cardcolor,
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width/15,),
                          Text("Connectivity Mode",style:headline2),
                          Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width/5,),
                          FlutterSwitch(
                                    width: 100.0,
                                    height: 40.0,
                                    activeText: "Online",
                                    inactiveText: "Local",
                                    valueFontSize: 15.0,
                                    toggleSize: 30.0,
                                    value: status,
                                    borderRadius: 30.0,
                                    padding: 8.0,
                                    showOnOff: true,
                                    activeColor: colorbtnBlueGray,
                                    onToggle: (val) {
                                      setState(() {
                                        status = val;
                                        setMode(status);
                                      });
                                    },
                                  ),
                        ],
                      ),
                    ),
                  ),
            //Container(height: MediaQuery.of(context).size.height/10,),
           if (status == false) Padding(
             padding: const EdgeInsets.all(8.0),
             child: Card(
               shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
               color: cardcolor,
               elevation: 10,
               child: Container(
                 height: MediaQuery.of(context).size.height/2.5,
                 width: MediaQuery.of(context).size.width,
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                       children: [
                         
                       Container(
                         padding: EdgeInsets.fromLTRB(10,20,10,10),
                         child: Text("Old robot IP "+ip,style: headline2,)),
                       ],
                     ),
              
                            //nom
                         Container(height: 20,),
                             Container(
                                  padding: const EdgeInsets.all(10),
                              height: 70,
                              // color: Colors.red,
                              child: TextFormField(
                               controller: ipController,
                                decoration: InputDecoration(
                                  labelText: "Enter IP",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    
                                  ),
                                ),
                              ),
                            ),
                         Container(height: 40,),
                          GestureDetector(
                            onTap: (){
                              _addItem();
                              getip();
                           
                              
                              widget.callback();
                            },
                            child: Center(
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
                                                  child: Text("Change",
                                                      style: headline2white)))),
                            ),
                          ),
                   ],
                 ),
               ),
             ),
           ),
           
          ],),
          
          
          ));
  }}