import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:github_profiles/models/github_user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchController = new TextEditingController();
  Future<GithubUser> _githubUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Github Profiles'),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by username...',
                  // suffixIcon: Icon(Icons.search),
                ),
              ),
              SizedBox(height: 30),
              FutureBuilder<GithubUser>(
                future: _githubUser,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.data == null) {
                    return Center(
                      child: Text('Could not fetch users, please search again'),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('User not found'),
                    );
                  }

                  final _githubUser = snapshot.data;
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(_githubUser.avatarUrl),
                      ),
                      SizedBox(height: 20),
                      Text(_githubUser.login,
                          style: Theme.of(context).textTheme.headline5),
                      SizedBox(height: 20),
                      Text(_githubUser.location,
                          style: Theme.of(context).textTheme.headline5),
                      SizedBox(height: 20),
                      // TODO: Fix json mapping and display other user details
                      // Text(_githubUser.email,
                      //     style: Theme.of(context).textTheme.headline5),
                      // SizedBox(height: 20),
                      // Text(_githubUser.login,
                      //     style: Theme.of(context).textTheme.headline5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text('Repositories'),
                              Text(_githubUser.publicRepos.toString()),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Followers'),
                              Text(_githubUser.followers.toString()),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Following'),
                              Text(_githubUser.following.toString()),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _githubUser = fetchGithubUser(_searchController.text);
            });
          },
          child: Icon(Icons.search),
        ));
  }
}

Future<GithubUser> fetchGithubUser(String user) async {
  final response = await http.get('https://api.github.com/users/$user');

  if (response.statusCode == 200) {
    return GithubUser.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch github user');
  }
}
