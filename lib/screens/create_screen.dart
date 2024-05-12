import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateScreen extends StatefulWidget {
  final DocumentSnapshot? documentSnapshot;

  const CreateScreen({Key? key, this.documentSnapshot}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _uploaderNameController = TextEditingController();
  final _profilePictureUrl =
      'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars-thumbnail.png';
  @override
  void initState() {
    super.initState();
    if (widget.documentSnapshot != null) {
      _titleController.text = widget.documentSnapshot!['title'];
      _descriptionController.text = widget.documentSnapshot!['description'];
      _uploaderNameController.text = widget.documentSnapshot!['uploaderName'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.documentSnapshot != null ? 'Update Entry' : 'Create Entry'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _uploaderNameController,
                decoration: const InputDecoration(labelText: 'Uploader Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  // Iterate over the dummy data and add each entry to Firestore
                  for (final data in dummyData) {
                    await FirebaseFirestore.instance
                        .collection('entries')
                        .doc()
                        .set(data);
                  }

                  // Navigate back to the previous screen
                  Navigator.pop(context);
                },
                child:
                    Text(widget.documentSnapshot != null ? 'Update' : 'Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> dummyData = [
  {
    'uploaderName': 'John Doe',
    'title': 'Beautiful Sunset',
    'description': 'Enjoying a beautiful sunset at the beach.',
    'createdAt': DateTime.now()
        .subtract(Duration(days: 2)), // Example date, adjust as needed
    'profilePicture':
        'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars-thumbnail.png',
  },
  {
    'uploaderName': 'Alice Smith',
    'title': 'Delicious Dinner',
    'description': 'A mouth-watering dinner cooked with love.',
    'createdAt': DateTime.now()
        .subtract(Duration(days: 1)), // Example date, adjust as needed
    'profilePicture':
        'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars-thumbnail.png',
  },
  {
    'uploaderName': 'Emily Johnson',
    'title': 'Spectacular Mountain View',
    'description': 'A breathtaking view of snow-capped mountains.',
    'createdAt': DateTime.now()
        .subtract(Duration(hours: 6)), // Example date, adjust as needed
    'profilePicture':
        'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars-thumbnail.png',
  },
  {
    'uploaderName': 'David Brown',
    'title': 'Adorable Puppy',
    'description': 'Playing fetch with a cute little puppy.',
    'createdAt': DateTime.now()
        .subtract(Duration(minutes: 30)), // Example date, adjust as needed
    'profilePicture':
        'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars-thumbnail.png',
  },
  {
    'uploaderName': 'Sophia Wilson',
    'title': 'Cozy Reading Nook',
    'description': 'Curling up with a good book in a cozy reading nook.',
    'createdAt': DateTime.now()
        .subtract(Duration(days: 2)), // Example date, adjust as needed
    'profilePicture':
        'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars-thumbnail.png',
  },
  {
    'uploaderName': 'Ethan Martinez',
    'title': 'Scenic Countryside',
    'description': 'Exploring the tranquil beauty of the countryside.',
    'createdAt': DateTime.now()
        .subtract(Duration(days: 1)), // Example date, adjust as needed
    'profilePicture':
        'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars-thumbnail.png',
  },
  {
    'uploaderName': 'Olivia Anderson',
    'title': 'Vibrant Flower Garden',
    'description': 'Strolling through a garden filled with colorful flowers.',
    'createdAt': DateTime.now()
        .subtract(Duration(hours: 6)), // Example date, adjust as needed
    'profilePicture':
        'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars-thumbnail.png',
  },
  {
    'uploaderName': 'Noah Taylor',
    'title': 'Epic Road Trip',
    'description': 'Embarking on an epic road trip across the country.',
    'createdAt': DateTime.now()
        .subtract(Duration(minutes: 30)), // Example date, adjust as needed
    'profilePicture':
        'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars-thumbnail.png',
  },
  {
    'uploaderName': 'Ava Thomas',
    'title': 'Charming Seaside Village',
    'description': 'Exploring a charming seaside village on a sunny day.',
    'createdAt': DateTime.now()
        .subtract(Duration(days: 2)), // Example date, adjust as needed
    'profilePicture':
        'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars-thumbnail.png',
  },
  {
    'uploaderName': 'Liam Clark',
    'title': 'Magical Starry Night',
    'description': 'Gazing at the stars on a clear, magical night.',
    'createdAt': DateTime.now()
        .subtract(Duration(days: 1)), // Example date, adjust as needed
    'profilePicture':
        'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars-thumbnail.png',
  },
];
