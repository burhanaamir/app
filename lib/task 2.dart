import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tts06c1/API/api_services.dart';
class task2 extends StatefulWidget {
  const task2({super.key});

  @override
  State<task2> createState() => _task2State();
}

class _task2State extends State<task2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: MyServices.fetchData(),
        builder: (context, snapshot) {


          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }

          if(snapshot.hasData){

            // 1. Json Decode - > Map
            Map map = jsonDecode(snapshot.data);
            String total = map["total"];
            List myData = map["tv_shows"];

            return Stack(

              children: [

                // Background Support
                const SizedBox(
                  width: double.infinity,
                  height: 184,

                ),

                // Cover photo
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  width: 200,
                  height: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.grey.shade400,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage("${myData[2]["image_thumbnail_path"]}"))
                  ),
                ),

                // Profile Pic

                Positioned(
                  left: 230,
                  top:100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name: ${myData[2]["name"]}",style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                      Text("Date:${myData[2]["start_date"]}",style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 14),),
                      Text("Country: ${myData[2]["country"]}",style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                      Text("Channel: ${myData[2]["network"]}",style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                    ],
                  ),
                )

              ],
            );
          }

          if(snapshot.hasError){
            return Icon(Icons.error,color: Colors.red,);
          }


          return Container();
        },),

    );
  }
}
