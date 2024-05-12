// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:assignment3/screens/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

// Initialize timeago settings
void initializeTimeAgo() {
  timeago.setLocaleMessages('en', timeago.EnMessages());
}

class mainScreen extends StatefulWidget {
  const mainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<mainScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _entriesCollection =
      FirebaseFirestore.instance.collection('entries');

  @override
  Widget build(BuildContext context) {
    User? currentUser = _auth.currentUser;
    String? currentUserName = currentUser?.displayName;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 246, 247),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: (15.0), right: 15.0, top: 50.0, bottom: 20.0),
          ),
          Center(
            child: Text(
              'Home',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 0.0, bottom: 0.0),
            child: Row(
              children: [
                Text(
                  'Hey ',
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 156, 157, 159),
                  ),
                ),
                Text(
                  '${FirebaseAuth.instance.currentUser?.displayName}',
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 254, 122, 112),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 0.0, bottom: 10.0),
            child: Text(
              'Start exploring resources',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 156, 157, 159),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white, // Set the background color to white
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(248, 222, 221, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              bottomLeft: Radius.circular(6),
                            ),
                          ),
                          child: Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 254, 122, 112),
                            size: 28,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 6.0),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: '  Search by name',
                                hintStyle: const TextStyle(
                                  color: Color(0xFF8D8D8D),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              bottomLeft: Radius.circular(6),
                            ),
                          ),
                          child: Icon(
                            Icons.cancel,
                            color: Color(0xFF8D8D8D),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.filter_alt_rounded,
                    color: Color.fromRGBO(251, 124, 101, 50),
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 15.0, top: 16.0, bottom: 10.0),
                    child: Row(
                      children: const [
                        Text(
                          'Latest Uploads ',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(
                          Icons.bolt,
                          color: Color(0xFFE9D83D),
                          size: 35,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _entriesCollection.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Error loading entries');
                        }

                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final entries = snapshot.data!.docs;
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          color: Color.fromARGB(255, 242, 246, 247),
                          child: ListView.builder(
                            itemCount: entries.length,
                            itemBuilder: (context, index) {
                              final entry = entries[index];
                              final uploaderName =
                                  entry['uploaderName'] as String?;
                              final title = entry['title'] as String?;
                              final description =
                                  entry['description'] as String?;
                              final createdAt =
                                  entry['createdAt'] as Timestamp?;
                              final profilePictureUrl =
                                  entry['profilePicture'] as String?;

                              return Card(
                                color: Color.fromARGB(255, 242, 246, 247),
                                margin: EdgeInsets.all(8.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                profilePictureUrl ?? ''),
                                            radius: 24.0,
                                          ),
                                          SizedBox(width: 12.0),
                                          Text(
                                            uploaderName ?? '',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            child: Text(
                                            timeago.format(
                                              createdAt?.toDate() ??
                                                  DateTime.now(),
                                              locale: 'en',
                                            ),
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.grey,
                                            ),
                                          ),),
                                          
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text(
                                        title ?? '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      child: Text(
                                        description ?? '',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(
                                            Icons.favorite,
                                            size: 16.0,
                                            color: Color.fromRGBO(
                                                170, 171, 172, 1),
                                          ),
                                          SizedBox(width: 4.0),
                                          Text(
                                            '2',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(width: 8.0),
                                          Icon(
                                            Icons.comment_rounded,
                                            size: 16.0,
                                            color: Color.fromRGBO(
                                                170, 171, 172, 1),
                                          ),
                                          SizedBox(width: 4.0),
                                          Text(
                                            '0',
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom navigation bar
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    // Add your navigation logic here
                  },
                  icon: const Icon(Icons.home),
                  color: Colors.red,
                ),
                IconButton(
                  onPressed: () {
                    // Add your navigation logic here
                  },
                  icon: const Icon(Icons.create),
                  color: Colors.grey,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateScreen()));
                  },
                  icon: const Icon(Icons.person),
                  color: Colors.grey,
                ),
                IconButton(
                  onPressed: () {
                    // Add your navigation logic here
                  },
                  icon: const Icon(Icons.settings),
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
