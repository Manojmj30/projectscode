import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Model/feedDetail_model.dart';


class BeatScreen extends StatefulWidget {
  final String ID;
  const BeatScreen({super.key, required this.ID});

  @override
  State<BeatScreen> createState() => _BeatScreenState();
}

class _BeatScreenState extends State<BeatScreen> {
  FeedDetailmodel? feedDetailModel;

  @override
  void initState() {
    super.initState();
    fetchBirthdayPosts();
  }

  Future<void> fetchBirthdayPosts() async {
    final url = Uri.parse('http://qa.birthdaybeat.ai:80/birthdaybeat/feedPostMap/beatList');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjYzODI4MDE1MDE4OTcxMTM2IiwiZXhwIjoxNzM1Mzg0Njk0LCJ0b2tlblR5cGUiOiJhY2Nlc3NUb2tlbiIsImlhdCI6MTcyMjQyNDY5NH0.W5B7_aMhKK2VJiRgqO7IIsGa8vG3554xmAs8xbH6eYM',
    };
    final body = jsonEncode({
      "pagination": {
        "size": 5,
        "page": 0
      },
      "filter": {
        "postId": widget.ID
      }
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      setState(() {
        feedDetailModel = feedDetailmodelFromJson(response.body);
      });
    } else {
      throw Exception('Failed to load birthday detail');
    }
  }
  int _selectedIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('Beat',style: TextStyle(color: Color(0xFF866aac),fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: feedDetailModel == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: feedDetailModel!.results.length,
          itemBuilder: (context, index) {
            final result = feedDetailModel!.results[index];
            final wishes = result.wishes[index];
            return buildPost(result,wishes,context);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/home.png',
              width: 24,
              height: 24,
              color: _selectedIndex == 0 ? const Color(0xFF9931a7) : const Color(0xFF89b8c3),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/calendar.png',
              width: 24,
              height: 24,
              color: _selectedIndex == 1 ? const Color(0xFF9931a7) : const Color(0xFF89b8c3),
            ),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/cane.png',
              width: 24,
              height: 24,
              color: _selectedIndex == 2 ? const Color(0xFF9931a7) : const Color(0xFF89b8c3),
            ),
            label: 'Beat',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/profile.png',
              width: 24,
              height: 24,
              color: _selectedIndex == 3 ? const Color(0xFF9931a7) : const Color(0xFF89b8c3),
            ),
            label: 'Connect',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/M5.png',
              width: 24,
              height: 24,

            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF9931a7),
        unselectedItemColor: const Color(0xFF89b8c3),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildPost(Result result,Wish wishes,BuildContext context) {
    dynamic imageurl = result.userInfo.imageUrl;
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(result.modifiedAt);
    DateFormat dateFormat = DateFormat('MMMM d yyyy');
    String formattedDate = dateFormat.format(dateTime);
    Size size = MediaQuery.sizeOf(context);
    var height = size.height;
    var width = size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0XFF223347),
                Color(0XFF5f3277)
              ],
              begin: Alignment.bottomLeft, // Gradient start
              end: Alignment.bottomRight, // Gradient end
            ),
            borderRadius: BorderRadius.only(
           topLeft: Radius.circular(10),
                topRight: Radius.circular(10)
            )),

          child: Padding(
            padding: const EdgeInsets.fromLTRB(10,0,0,0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(result.userInfo.imageUrl??'',),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      result.caption,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13,color: Color(0xFFaec1c8)),
                    ),
                    Row(
                      children: [
                        Text(
                            formattedDate,
                            style: const TextStyle(fontSize: 12, color: Color(0xFF7395a3),)
                        ),
                        const SizedBox(width:10),
                        result.totalWishCount==1?
                        Text('${result.totalWishCount} posted'.toString(),style: const TextStyle(fontSize: 12, color: Color(0xFF7395a3),)):
                        Text('${result.totalWishCount} people posted'.toString(),style: const TextStyle(fontSize: 12, color: Color(0xFF7395a3),))
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Image.asset('assets/icons/button.png',height: 50,width: 50,)
              ],
            ),
          ),
        ),
        Container(
          height:height*0.70,
          width:height*0.60,
          decoration: const BoxDecoration(
              color:  Color(0xFFe1dbec),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)
              )
          ),
          child:Padding(
            padding: const EdgeInsets.fromLTRB(10,10,0,0),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 9.0,
                    runSpacing: 6.0,
                    children: result.wishes.map((wish) {
                      return Column(
                        children: [
                          ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                               topRight: Radius.circular(10)
                                ),
                            child: CachedNetworkImage(
                              imageUrl: wish.imageUrl ?? '',
                              width: height*0.40,
                              height: height*0.40,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            width: height*0.40,
                            height: height*0.20,
                            decoration: const BoxDecoration(
                                color: Color(0XFFe2f6f5),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)
                                )
                            ),
                            child:  Column(
                              children: [
                                Row(
                                  children: [
                                    /*CircleAvatar(
                                      backgroundImage: NetworkImage(imageurl??'',),
                                    ),*/
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(10,0,0,0),
                                      child: Wrap(
                                                                  children:[
                                                                      Text('Wish you a happy birthday\n Adam! may enjoy your\nserene trips!!',style: TextStyle(color: Colors.black),
                                                                      )]),
                                    ),
                                    const SizedBox(width:20),
                                    Image.asset(
                                      'assets/icons/profile.png',
                                      width: 24,
                                      height: 24,
                                      color:const Color(0xFF89b8c3),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10,5,0,0),
                                  child: Row(
                                    children: [
                                      Container(
                                        height:20,
                                        width:90,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child:const Row(
                                          children: [
                                            SizedBox(width:5),
                                            Icon(Icons.emoji_emotions,color: Colors.yellow,size:20),
                                            Icon(Icons.emoji_emotions_outlined,color: Colors.yellow,size:20),
                                            Icon(Icons.thumb_up_sharp,color: Colors.yellow,size:20),
                                            Text('109',style: TextStyle(color: Color(0xFF089cbc)),)
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width:5),
                                      const Icon(Icons.chat_bubble,color:Color(0xFF089cbc),size:15),
                                      const Text('3 Replies',style: TextStyle(color: Color(0xFF089cbc)),)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10,10,0,0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/icons/M5.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.fromLTRB(10,0,0,0),
                                        child: Text('Connect with priya to comment',style: TextStyle(color: Color(0xFFb9d9de),fontSize: 12),),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    }).toList() ?? [],
                  ),
                ),

              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

}
