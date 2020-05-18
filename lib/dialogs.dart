import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'globals.dart' as globals;

class JoinRoom extends StatefulWidget {
  @override
  _JoinRoomState createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  final _key = GlobalKey<FormState>();
  bool _loading = false;
  String roomName;
  String warning;
  final firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        height: 300,
        padding: EdgeInsets.all(30),
        child: Form(
          key: _key,
          child: Column(
            children: [
              Text(
                "Enter room name",
                style: TextStyle(fontSize: 32, color: Colors.blue),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter name";
                  }
                  return null;
                },
                style: TextStyle(fontSize: 26, color: Colors.black),
                onSaved: (value) {
                  roomName = value;
                },
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text(
                      "Join",
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    onPressed: () async {
                      if (_key.currentState.validate()) {
                        _key.currentState.save();
                        setState(() {
                          _loading = true;
                        });
                        final snapshot =
                            await firestore.collection(roomName).getDocuments();
                        if (snapshot.documents.length == 0) {
                          setState(() {
                            warning = "Room doesnt Exist";
                            _loading = false;
                          });
                        } else {
                          globals.roomname = roomName;
                          Navigator.pop(context);
                        }
                      }
                    },
                    color: Colors.blue,
                  ),
                  Spacer(),
                  (_loading) ? CircularProgressIndicator() : Container(),
                ],
              ),
              Spacer(),
              (warning != null)
                  ? Text(
                      warning,
                      style: TextStyle(color: Colors.red, fontSize: 32),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

class CreateRoom extends StatefulWidget {
  @override
  _CreateRoomState createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final _key = GlobalKey<FormState>();
  bool _loading = false;
  String roomName;
  String warning;
  final firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        height: 300,
        padding: EdgeInsets.all(30),
        child: Form(
          key: _key,
          child: Column(
            children: [
              Text(
                "Enter room name",
                style: TextStyle(fontSize: 32, color: Colors.blue),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter name";
                  }
                  return null;
                },
                style: TextStyle(fontSize: 26, color: Colors.black),
                onSaved: (value) {
                  roomName = value;
                },
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text(
                      "Create",
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    onPressed: () async {
                      if (_key.currentState.validate()) {
                        _key.currentState.save();
                        setState(() {
                          _loading = true;
                        });
                        final snapshot =
                            await firestore.collection(roomName).document("");
//                        if (snapshot.documents.length == 0) {
//                          setState(() {
//                            warning = "Room doesnt Exist";
//                            _loading = false;
//                          });
//                          }
//                          else {
//                          globals.roomname = roomName;
//                          Navigator.pop(context);
//                        }
                      }
                    },
                    color: Colors.blue,
                  ),
                  Spacer(),
                  (_loading) ? CircularProgressIndicator() : Container(),
                ],
              ),
              Spacer(),
              (warning != null)
                  ? Text(
                      warning,
                      style: TextStyle(color: Colors.red, fontSize: 32),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}