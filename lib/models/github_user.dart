// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

GithubUser githubUserFromJson(String str) =>
    GithubUser.fromJson(json.decode(str));

String userToJson(GithubUser data) => json.encode(data.toJson());

class GithubUser {
  GithubUser({
    this.login,
    this.id,
    this.nodeId,
    this.avatarUrl,
    this.gravatarId,
    this.url,
    this.htmlUrl,
    this.followersUrl,
    this.followingUrl,
    this.gistsUrl,
    this.starredUrl,
    this.subscriptionsUrl,
    this.organizationsUrl,
    this.reposUrl,
    this.eventsUrl,
    this.receivedEventsUrl,
    this.type,
    this.siteAdmin,
    this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.hireable,
    this.bio,
    this.twitterUsername,
    this.publicRepos,
    this.publicGists,
    this.followers,
    this.following,
    this.createdAt,
    this.updatedAt,
  });

  factory GithubUser.fromJson(Map<String, dynamic> json) => GithubUser(
        login: json["login"],
        id: json["id"],
        nodeId: json["node_id"],
        avatarUrl: json["avatar_url"],
        gravatarId: json["gravatar_id"],
        url: json["url"],
        htmlUrl: json["html_url"],
        followersUrl: json["followers_url"],
        followingUrl: json["following_url"],
        gistsUrl: json["gists_url"],
        starredUrl: json["starred_url"],
        subscriptionsUrl: json["subscriptions_url"],
        organizationsUrl: json["organizations_url"],
        reposUrl: json["repos_url"],
        eventsUrl: json["events_url"],
        receivedEventsUrl: json["received_events_url"],
        type: json["type"],
        siteAdmin: json["site_admin"],
        name: json["name"],
        company: json["company"],
        blog: json["blog"],
        location: json["location"] ?? "Location Unknown",
        email: json["email"],
        hireable: json["hireable"],
        bio: json["bio"],
        twitterUsername: json["twitter_username"],
        publicRepos: json["public_repos"],
        publicGists: json["public_gists"],
        followers: json["followers"],
        following: json["following"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  String avatarUrl;
  String bio;
  String blog;
  String company;
  DateTime createdAt;
  String email;
  String eventsUrl;
  int followers;
  String followersUrl;
  int following;
  String followingUrl;
  String gistsUrl;
  String gravatarId;
  bool hireable;
  String htmlUrl;
  int id;
  String location;
  String login;
  String name;
  String nodeId;
  String organizationsUrl;
  int publicGists;
  int publicRepos;
  String receivedEventsUrl;
  String reposUrl;
  bool siteAdmin;
  String starredUrl;
  String subscriptionsUrl;
  String twitterUsername;
  String type;
  DateTime updatedAt;
  String url;

  Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "node_id": nodeId,
        "avatar_url": avatarUrl,
        "gravatar_id": gravatarId,
        "url": url,
        "html_url": htmlUrl,
        "followers_url": followersUrl,
        "following_url": followingUrl,
        "gists_url": gistsUrl,
        "starred_url": starredUrl,
        "subscriptions_url": subscriptionsUrl,
        "organizations_url": organizationsUrl,
        "repos_url": reposUrl,
        "events_url": eventsUrl,
        "received_events_url": receivedEventsUrl,
        "type": type,
        "site_admin": siteAdmin,
        "name": name,
        "company": company,
        "blog": blog,
        "location": location,
        "email": email,
        "hireable": hireable,
        "bio": bio,
        "twitter_username": twitterUsername,
        "public_repos": publicRepos,
        "public_gists": publicGists,
        "followers": followers,
        "following": following,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
