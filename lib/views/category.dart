import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/datas/data.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/widgets/widget.dart';
import 'package:http/http.dart' as http; 

class Categories extends StatefulWidget {
  final String searchQuery;
  Categories({this.searchQuery});
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  // ignore: deprecated_member_use
  List<WallpaperModel> wallpapers = new List();

  getSearchWallpapers(String query) async{
    var url = Uri.parse('https://api.pexels.com/v1/search?query=$query');
    var response = await http.get(url, 
      headers: {
        "Authorization" : apiKey
      });
    //print(response.body.toString());
    Map<String, dynamic> jsonData = jsonDecode(response.body);
      jsonData["photos"].forEach((element){
      //print(element);
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {
      
    });
  }

  @override
  void initState() {
    getSearchWallpapers(widget.searchQuery);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 16,),
              Container(
                child: WallpaperList(wallpapers: wallpapers, context: context),
              )
            ],
          ),
        ),
      ),
    );
  }
}