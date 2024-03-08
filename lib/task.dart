import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:tts06c1/API/api_services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
class task1 extends StatefulWidget {
  const task1({super.key});

  @override
  State<task1> createState() => _task1State();
}

class _task1State extends State<task1> {
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
                  height: 300,

                ),

          ImageSlideshow(

          width: double.infinity,
          height: 200,

          /// The page to show when first creating the [ImageSlideshow].
          initialPage: 0,

          /// The color to paint the indicator.
          indicatorColor: Colors.blue,

          /// The color to paint behind th indicator.
          indicatorBackgroundColor: Colors.grey,

          /// Called whenever the page in the center of the viewport changes.
          onPageChanged: (value) {
          print('Page changed: $value');
          },

          /// Auto scroll interval.
          /// Do not auto scroll with null or 0.
          autoPlayInterval: 3000,

          /// Loops back to first slide.
          isLoop: true,

          /// The widgets to display in the [ImageSlideshow].
          /// Add the sample image file into the images folder
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.grey.shade400,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage("${myData[2]["image_thumbnail_path"]}"))
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.grey.shade400,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage("${myData[10]["image_thumbnail_path"]}"))
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.grey.shade400,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage("${myData[6]["image_thumbnail_path"]}"))
              ),
            ),

          ],
          ), // Cover photo

                // Profile Pic
                Positioned(
                  left: 24,
                  top:170,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage("${myData[3]["image_thumbnail_path"]}"),
                  ),
                ),

                Positioned(
                  left: 100,
                  top: 190,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${myData[2]["name"]}",style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                      Text("${myData[3]["start_date"]}",style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 14),)
                    ],
                  ),
                )

              ],
            );
          }

          if(snapshot.hasData){

            // 1. Json Decode - > Map
            Map map = jsonDecode(snapshot.data);
            String total = map["total"];
            List myData = map["tv_shows"];

            return ListView.builder(
              itemCount: myData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage("${myData[index]["image_thumbnail_path"]}"),
                  ),
                  title: Text("${myData[index]["name"]}"),
                );
              },);
          }

          if(snapshot.hasError){
            return Icon(Icons.error,color: Colors.red,);
          }


          return Container();
        },),
    );
  }
}

