import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'create_group/add_members.dart';
import 'group_chat_room.dart';

class GroupChatHomeScreen extends StatefulWidget {
  @override
  _GroupChatHomeScreenState createState() => _GroupChatHomeScreenState();
}

class _GroupChatHomeScreenState extends State<GroupChatHomeScreen> {
  // made a shifting change here
  late TextEditingController? controller;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  bool isAdmin = false;

  List groupList = [];

  @override
  void initState() {
    super.initState();
    getAvailableGroups();
  }

  void getAvailableGroups() async {
    String uid = _auth.currentUser!.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('groups')
        .get()
        .then((value) {
      setState(() {
        groupList = value.docs;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onLongPress: () => alertDialog(),
          child: Text("Groups"),
        ),
      ),
      body: isLoading
          ? Container(
              height: size.height,
              width: size.width,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: groupList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => GroupChatRoom(
                        groupName: groupList[index]['name'],
                        groupChatId: groupList[index]['id'],
                      ),
                    ),
                  ),
                  leading: Icon(Icons.group),
                  title: Text(groupList[index]['name']),
                );
              },
            ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              child: Icon(Icons.create),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AddMembersInGroup(),
                ),
              ),
              tooltip: "Create Group",
            )
          : Container(),
    );
  }

  Future alertDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Enter the code"),
          content: TextField(
            decoration: InputDecoration(hintText: 'Enter secret code'),
          ),
          actions: [
            TextButton(
              onPressed: submit,
              child: const Text("Submit"),
            ),
          ],
        ),
      );
  void submit() {
    setState(() {
      isAdmin = true;
      Navigator.of(context).pop();
    });
  }
}
