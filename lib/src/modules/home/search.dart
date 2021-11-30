// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_app/src/core/utils/http.dart';
import 'package:mobile_app/src/data/enums/local_storage_enum.dart';
import 'package:mobile_app/src/data/models/payload/common_resp.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';

class Search extends SearchDelegate<Future<SearchData?>?> {
  static Future<SearchData?> suggest(String searchKey) async {
    var token = await getStringLocalStorge(LocalStorageKey.TOKEN.toString());
    var response = await client.get(
      Uri.parse('$baseURL/elastic/sAdv?searchKey=$searchKey'),
      headers: authHeader(token!),
    );
    if (response.statusCode == 200) {
      var temp = CommonResp.fromJson(json.decode(response.body));
      if (temp.code == "SUCCESS") {
        SearchData searchData =
            SearchData.fromJson(temp.data! as Map<String, dynamic>);
        return searchData;
      } else {
        throw Exception('Failed');
      }
    } else {
      throw Exception('Failed');
    }
  }

  List<String> data = [
    "android",
    "windows",
    "mac",
    "linux",
    "parrotOS",
    "mint"
  ];

  List<String> recentSearch = [
    "Android",
    "Windows",
    "Mac",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("Click Vao SuggestTion");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == "") {
      return ListView.builder(
          itemCount: recentSearch.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(recentSearch[index]),
              trailing: const Icon(
                Icons.arrow_forward_ios,
              ),
              onTap: () {
                showResults(context);
              },
            );
          });
    } else {
      return FutureBuilder(
          future: suggest(query),
          builder: (context, AsyncSnapshot<SearchData?> snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: <Widget>[
                Container(
                  child: _showTaskListView(snapshot),
                ),
                Expanded(
                  child: Container(
                    child: _showProjectListView(snapshot),
                  ),
                )
              ],
            );
          });
    }
  }

  Widget _showTaskListView(AsyncSnapshot<SearchData?> snapshot) {
    return Container(
      color: Colors.green,
      child: ListView.builder(
        itemCount: snapshot.data!.tasks!.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) => Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(title: Text("Day la Task Search Duoc"))),
      ),
    );
  }

  Widget _showProjectListView(AsyncSnapshot<SearchData?> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.projects!.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        String name = snapshot.data!.projects![index].name;
        String owner = snapshot.data!.projects![index].email;
        return Card(child: ListTile(title: Text("Project: $name cua $owner")));
      },
    );
  }
}

class SearchData {
  late List<ProjectSearchData>? projects;
  late List<TaskSearchData>? tasks;

  SearchData({this.projects, this.tasks});

  factory SearchData.fromJson(Map<String, dynamic> json) {
    return SearchData(
        projects: json["projects"] == null
            ? null
            : (json["projects"] as List)
                .map((e) => ProjectSearchData.fromJson(e))
                .toList(),
        tasks: json["tasks"] == null
            ? null
            : (json["tasks"] as List)
                .map((e) => TaskSearchData.fromJson(e))
                .toList());
  }
}

class ProjectSearchData {
  late int id;
  late String name;
  //OWNER
  late String email;

  ProjectSearchData(
      {required this.id, required this.name, required this.email});

  factory ProjectSearchData.fromJson(Map<String, dynamic> json) {
    return ProjectSearchData(
        id: json['id'], name: json['name'], email: json['email']);
  }
}

class TaskSearchData {
  late int id;
  late int projectId;
  late String name;
  //OWNER
  late String email;
  late String projectName;
  late String? content;

  TaskSearchData(
      {required this.id,
      required this.projectId,
      required this.name,
      required this.email,
      required this.projectName,
      required this.content});

  factory TaskSearchData.fromJson(Map<String, dynamic> json) {
    return TaskSearchData(
        id: json['id'],
        email: json['email'],
        projectId: json['projectId'],
        name: json['name'],
        projectName: json['projectName'],
        content: json['content']);
  }
}
