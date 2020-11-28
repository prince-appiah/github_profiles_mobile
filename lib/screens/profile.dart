import 'package:flutter/material.dart';
import 'package:github_profiles/models/github_user.dart';

class Profile extends StatelessWidget {
  final GithubUser user;

  const Profile({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    print('User in profile page $user');

    // Display details with hero image
    return Scaffold(
      appBar: AppBar(
          // title: Text(user.login),
          title: Text(user.login)),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // user avatar with a background
              Container(
                padding: const EdgeInsets.all(20.0),
                alignment: Alignment.center,
                height: size.height * 0.3,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.avatarUrl),
                      radius: 60.0,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      user.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 23.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_city_outlined,
                          color: Colors.white,
                          size: 25.0,
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          user.location,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Text(
                //   'User Above and name here',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 23.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ),
              // Bio
              Container(
                padding: const EdgeInsets.all(20.0),
                width: size.width,
                child: Column(
                  children: [
                    Text(
                      'Bio',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        // color: Colors.grey,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      user.bio,
                      // 'User bio goes here',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700],
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              // followers,following, repos
              Container(
                padding: const EdgeInsets.all(20.0),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Followers',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            // color: Colors.grey,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          user.followers.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[700],
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Following',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            // color: Colors.grey,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          user.following.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[700],
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Repositories',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            // color: Colors.grey,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          user.publicRepos.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[700],
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // pull requests, commits, contributions
              Container(
                padding: const EdgeInsets.all(20.0),
                width: size.width,
                child: Row(
                  children: [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
