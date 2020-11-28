import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:github_profiles/screens/home.dart';

import '../models/github_user.dart';
import 'profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchController = new TextEditingController();
  // GithubUser _user;

  Future<GithubUser> _findGithubUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Profiles'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              keyboardType: TextInputType.text,
              autocorrect: false,
              enableSuggestions: false,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  iconSize: 30.0,
                  icon: Icon(Icons.search_outlined, color: Colors.black38),
                  onPressed: () {
                    final user = fetchGithubUser(_searchController.text);

                    setState(() {
                      _findGithubUser = user;
                    });
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  gapPadding: 20.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  gapPadding: 20.0,
                ),
                hintText: 'Search by username...',
              ),
            ),
            SizedBox(height: 20.0),
            /* Main scrollable content goes here */
            Container(
              child: SingleChildScrollView(
                child: FutureBuilder<GithubUser>(
                  future: _findGithubUser,
                  builder: (ctx, snapshot) {
                    // return data
                    if (snapshot.hasData) {
                      final user = snapshot.data;
                      return Column(
                        children: <Widget>[
                          ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                tileColor: Colors.grey[300],
                                leading: Hero(
                                  tag: user.login,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(user.avatarUrl),
                                  ),
                                ),
                                subtitle: Text(user.login),
                                title: Text(user.name),
                                onTap: () {
                                  Navigator.of(context).push(PageRouteBuilder(
                                      transitionDuration:
                                          Duration(milliseconds: 850),
                                      pageBuilder: (ctx, animation, child) =>
                                          Profile(user: user)));
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                        margin: EdgeInsets.only(top: 30.0),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.error_outline_outlined),
                            Text('An error occurred')
                          ],
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Container();
                    }
                  },
                ),

                //  Column(
                //   children: <Widget>[
                //     ListView(
                //       shrinkWrap: true,
                //       children: <Widget>[
                //         ListTile(
                //           // leading: Icon(Icons.supervised_user_circle),
                //           leading: CircleAvatar(),
                //           title: Text('Github User'),
                //           trailing: Icon(Icons.remove_red_eye_outlined),
                //           onTap: () {
                //             Navigator.of(context).push(
                //                 MaterialPageRoute(builder: (ctx) => Profile()));
                //           },
                //         ),
                //       ],
                //     ),
                //   ],
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<GithubUser> fetchGithubUser(String user) async {
  var response = await http.get('https://api.github.com/users/$user');

  if (response.statusCode == 200) {
    return GithubUser.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch github user');
  }
}
