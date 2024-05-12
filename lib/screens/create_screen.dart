import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:assignment3/screens/main_screen.dart';

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

  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _isEditMode = onTapFunctionReturnsTrue(); // Update _isEditMode based on onTapFunctionReturnsTrue()
    if (_isEditMode && widget.documentSnapshot != null) {
      _titleController.text = widget.documentSnapshot!['title'];
      _descriptionController.text = widget.documentSnapshot!['description'];
      _uploaderNameController.text = widget.documentSnapshot!['uploaderName'];
    }
  }

  bool onTapFunctionReturnsTrue() {
    // Replace this with your logic to determine whether onTap returns true
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Entry Details' : 'Create Entry'),
      ),
      body: _isEditMode
          ? _buildEntryDetails()
          : Form(
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
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _uploaderNameController,
                      decoration:
                          const InputDecoration(labelText: 'Uploader Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final user = FirebaseAuth.instance.currentUser;
                          final timestamp = DateTime.now();
                          final formattedTimestamp =
                              DateFormat('yyyy-MM-dd HH:mm').format(timestamp);

                          await FirebaseFirestore.instance
                              .collection('entries')
                              .doc()
                              .set({
                            'title': _titleController.text,
                            'description': _descriptionController.text,
                            'uploaderName': _uploaderNameController.text,
                            'profilePicture': _profilePictureUrl,
                            'createdAt': formattedTimestamp,
                            'userId': user!.uid,
                          });

                          Navigator.pop(context);
                        }
                      },
                      child: Text('Create'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
  

  Widget _buildEntryDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailItem('Title', _titleController.text),
          _buildDetailItem('Description', _descriptionController.text),
          _buildDetailItem('Uploader Name', _uploaderNameController.text),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
