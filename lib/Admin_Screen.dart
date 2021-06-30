import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Admin_Screen extends StatefulWidget {
  @override
  _Admin_ScreenState createState() => _Admin_ScreenState();
}

class _Admin_ScreenState extends State<Admin_Screen> {
  var imageTextController = TextEditingController();

  var locationFocus = FocusNode();
  var imageUrlFocus = FocusNode();
  var infoFocus = FocusNode();
  var _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  late String name, info, location, imageurl;

  @override
  void dispose() {
    imageTextController.dispose();
    locationFocus.dispose();
    infoFocus.dispose();
    super.dispose();
    imageUrlFocus.dispose();
  }

  @override
  void initState() {
    imageUrlFocus.addListener(() {
      if (!imageUrlFocus.hasFocus) {
        setState(() {});
      }
    });
    super.initState();
  }

  void _saveform() async {
    setState(() {
      isLoading = true;
    });
    _formKey.currentState!.save();
    var url = Uri.parse(
        'https://test-001-98b21-default-rtdb.firebaseio.com/temples.json');
    var res = await http.post(url,
        body: json.encode({
          'name': name,
          'information': info,
          'location': location,
          'imageurl': imageurl
        }));
    print(json.decode(res.body));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Super Admin'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _saveform();
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding:
                    EdgeInsets.only(top: 30, right: 10, left: 10, bottom: 10),
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                      ),
                      textInputAction: TextInputAction.next,
                      onSaved: (val) {
                        name = val.toString();
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(locationFocus);
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      focusNode: locationFocus,
                      decoration: InputDecoration(
                        labelText: 'Location',
                      ),
                      onSaved: (val) {
                        location = val.toString();
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(infoFocus);
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: TextFormField(
                      focusNode: infoFocus,
                      maxLines: 20,
                      onSaved: (val) {
                        info = val.toString();
                      },
                      decoration: InputDecoration(labelText: 'Information'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2)),
                    child: FittedBox(
                      child: Image.network(
                        imageTextController.text,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    focusNode: imageUrlFocus,
                    decoration: InputDecoration(labelText: 'Image URL'),
                    onFieldSubmitted: (_) {
                      setState(() {});
                    },
                    onSaved: (val) {
                      imageurl = val.toString();
                    },
                    controller: imageTextController,
                  )
                ],
              )),
    );
  }
}
