import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _FirstPage();
}


class _FirstPage extends State<MyHomePage> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Firestore Example')),
        body: Center(
          child: ElevatedButton(
          child: Text('Get Data'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SubCollectionListView()),
            );
          },
        ),)
    );
  }
}

class SubCollectionListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subcollection Example')),
      body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('2023_05_08').doc('leejuhwan').collection('workout').get(),
          builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final data = documents[index].data() as Map<String, dynamic>;
              final workoutName = data['workoutName'] ?? '';
              final count = data['count'] ?? '';
              final videoID = data['videoID'] ?? '';
              return ListTile(
                title: Text(workoutName),
                subtitle: Text('Count: $count, Video ID: $videoID'),
              );
            },
          );
        },
      ),
    );
  }
}