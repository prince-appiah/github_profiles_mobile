import 'package:flutter/material.dart';
import 'package:github_profiles/screens/home.dart';

import 'models/github_user.dart';
import 'screens/profile.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
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
                  icon: Icon(
                    Icons.search_outlined,
                    color: Colors.black38,
                  ),
                  onPressed: () {
                    final user = fetchGithubUser(_searchController.text);

                    print('found a user, $user');

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
                  builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                    final _user = snapshot.data;
                    // return data
                    if (snapshot.hasData || snapshot.data != null) {
                      print('There is data, ${snapshot.data}');
                      return Column(
                        children: <Widget>[
                          ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              ListTile(
                                // leading: Icon(Icons.supervised_user_circle),
                                leading: CircleAvatar(),
                                title: Text(_user),
                                trailing: Icon(Icons.remove_red_eye_outlined),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => Profile()));
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    } else if (snapshot.hasError || snapshot.data == null) {
                      return Container(
                          child: Column(
                        children: [
                          Icon(Icons.error_outline_outlined),
                          Text('An error occurred')
                        ],
                      ),);
                    } else {
                      return Center(child: CircularProgressIndicator());
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
