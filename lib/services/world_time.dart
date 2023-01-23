import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String? location;//location for the UI
  String? time;//the time in that location
  String? flag;//url to an asset flag icon
  String? url;//location url for api endpoint
  bool? isDayTime;//if daytime or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async{
    try{
      //make request
      var urlobj = Uri.http('worldtimeapi.org', '/api/timezone/$url', {'q': '{http}'});
      Response response = await get(urlobj);
      Map data = jsonDecode(response.body) ;
      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);//取offset字符串的后3位
      //create DateTime object
      DateTime now = DateTime.parse(datetime);//把string转为DateTime object
      now = now.add(Duration(hours:int.parse(offset)));//让DateTime object增加整形的offset
      //set the time property
      isDayTime = now.hour>6&&now.hour<=18?true:false;
      time = DateFormat.jm().format(now);//{location: Berlin, flag: germany.png, time: 11:37 PM}
    }
    catch(e){
      print('caught error: $e');
      time = 'cannot get time data';
    }

  }
}

