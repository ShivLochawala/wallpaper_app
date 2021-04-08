import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/datas/data.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/widgets/widget.dart';
import 'package:http/http.dart' as http; 

class Search extends StatefulWidget {
  final String searchQuery;
  Search({this.searchQuery});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController searchController = new TextEditingController();
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
    searchController.text = widget.searchQuery;  
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
              Container(
                padding: EdgeInsets.symmetric(horizontal:20),
                margin: EdgeInsets.symmetric(horizontal:24),
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd), 
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context,   MaterialPageRoute(
                          builder: (context) => Search(
                            searchQuery: searchController.text,
                          )
                          )
                        );    
                      },
                      child: Container(
                        child: Icon(Icons.search)
                      )
                    )
                  ],
                ),
              ),
              SizedBox(height: 16,),
              WallpaperList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}