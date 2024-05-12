import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditDetails extends StatefulWidget {
  String title;
  String description;
  String uploaderName;

  EditDetails({
    Key? key,
    this.title = '',
    this.description = '',
    this.uploaderName = '',
  }) : super(key: key);

  @override
  _EditDetailsState createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _uploaderNameController;

  late String _documentId; // To store the document id of the Firestore document

  @override
void initState() {
  super.initState();
  _titleController = TextEditingController(text: widget.title);
  _descriptionController = TextEditingController(text: widget.description);
  _uploaderNameController = TextEditingController(text: widget.uploaderName);

  // Get the document reference and store the document ID
  FirebaseFirestore.instance
      .collection('your_collection')
      .where('title', isEqualTo: widget.title)
      .where('description', isEqualTo: widget.description)
      .where('uploaderName', isEqualTo: widget.uploaderName)
      .get()
      .then((querySnapshot) {
    if (querySnapshot.docs.isNotEmpty) {
      _documentId = querySnapshot.docs.first.id;
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: _uploaderNameController,
              decoration: InputDecoration(labelText: 'Uploader Name'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveChanges,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

 Future<void> _saveChanges() async {
  final timestamp = DateTime.now();
  final formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm').format(timestamp);

  // Get the reference to the Firestore document
  final docRef = FirebaseFirestore.instance.collection('your_collection').doc(_documentId);

  // Prepare the data to update
  final Map<String, dynamic> updatedData = {};

  // Check if title has changed
  if (_titleController.text != widget.title) {
    updatedData['title'] = _titleController.text;
  }

  // Check if description has changed
  if (_descriptionController.text != widget.description) {
    updatedData['description'] = _descriptionController.text;
  }

  // Check if uploaderName has changed
  if (_uploaderNameController.text != widget.uploaderName) {
    updatedData['uploaderName'] = _uploaderNameController.text;
  }

  // Update the document data with the changes if any
  if (updatedData.isNotEmpty) {
    updatedData['updatedAt'] = formattedTimestamp;
    await docRef.update(updatedData).then((_) {
      // Update the widget's properties with the new values
      setState(() {
        widget.title = _titleController.text;
        widget.description = _descriptionController.text;
        widget.uploaderName = _uploaderNameController.text;
      });

      // Pass updated data back to the main screen
      Navigator.pop(context, updatedData);
    });
  } else {
    Navigator.pop(context);
  }
}

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _uploaderNameController.dispose();
    super.dispose();
  }
}
