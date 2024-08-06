
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'Model/feedList_model.dart';
import 'Screens/beat_screen.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FeedListModel? feedListModel;

  @override
  void initState() {
    super.initState();
    fetchBirthdayPosts();
  }

  Future<void> fetchBirthdayPosts() async {
    final url = Uri.parse('http://qa.birthdaybeat.ai:80/birthdaybeat/feed/list');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjYzODI4MDE1MDE4OTcxMTM2IiwiZXhwIjoxNzM1Mzg0Njk0LCJ0b2tlblR5cGUiOiJhY2Nlc3NUb2tlbiIsImlhdCI6MTcyMjQyNDY5NH0.W5B7_aMhKK2VJiRgqO7IIsGa8vG3554xmAs8xbH6eYM',
    };
    final body = jsonEncode({
      'detailedInfo': true,
      'pagination': {
        'size': 10,
        'page': 0
      }
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      setState(() {
        feedListModel = feedListModelFromJson(response.body);
      });
    } else {
      throw Exception('Failed to load birthday posts');
    }
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0XFFFFFFFF),
        appBar: AppBar(
          backgroundColor: const Color(0XFFFFFFFF),
          title: const Text('Home',style: TextStyle(color: Color(0xFF866aac),fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: feedListModel == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
              padding: const EdgeInsets.fromLTRB(10,10,10,0),
              child: BirthdayPostsWidget(feedListModel: feedListModel!),
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

      )

    );
  }

}
class BirthdayPostsWidget extends StatefulWidget {
  final FeedListModel feedListModel;

  const BirthdayPostsWidget({super.key, required this.feedListModel});

  @override
  State<BirthdayPostsWidget> createState() => _BirthdayPostsWidgetState();
}

class _BirthdayPostsWidgetState extends State<BirthdayPostsWidget> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.feedListModel.birthdayPosts.results.length ?? 0,
      itemBuilder: (context, index) {
        final result = widget.feedListModel.birthdayPosts.results[index];
        int timestamp = result.modifiedAt;
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
        DateFormat dateFormat = DateFormat('MMMM d yyyy h:mm a');
        String formattedDate = dateFormat.format(dateTime);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/icons/balloon.png',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.caption ?? '',
                      style: const TextStyle(color: Color(0xFF6d7885), fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text(
                      formattedDate,
                      style: const TextStyle(color: Color(0xFF6d7885), fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap:(){
                print('ID:${result.id.toString()} ');
                Navigator.push(context, MaterialPageRoute(builder: (context) => BeatScreen(ID:result.id.toString() ,) ));
               },
              child: Wrap(
                spacing: 4.0,
                runSpacing: 6.0,
                children: result.wishes.map((wish) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: wish.imageUrl ?? '',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  );

                }).toList() ?? [],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
                  child: Image.asset(
                    'assets/icons/M1.png',
                    width: 20,
                    height: 20,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
                  child: Image.asset(
                    'assets/icons/M2.png',
                    width: 20,
                    height: 20,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
                  child: Image.asset(
                    'assets/icons/M3.png',
                    width: 20,
                    height: 20,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0), // Adjust the radius as needed
                  child: Image.asset(
                    'assets/icons/M4.png',
                    width: 20,
                    height: 20,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5), // Adjust the radius as needed
                  child: Image.asset(
                    'assets/icons/M5.png',
                    width: 20,
                    height: 20,
                  ),
                ),
                const Text(
                  '+wished',
                  style: TextStyle(fontSize: 12, color: Color(0xFF6d7885)),
                ),

              ],
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );

  }


}
