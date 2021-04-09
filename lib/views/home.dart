import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/datas/data.dart';
import 'package:wallpaper_app/models/categories_model.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/views/category.dart';
import 'package:wallpaper_app/views/search.dart';
import 'package:wallpaper_app/widgets/widget.dart';
import 'package:http/http.dart' as http; 

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // ignore: deprecated_member_use
  List<CategoriesModel> categories = new List();
  // ignore: deprecated_member_use
  List<WallpaperModel> wallpapers = new List();
  TextEditingController searchController = new TextEditingController();

  getTrendingWallpapers() async{
    var url = Uri.parse('https://api.pexels.com/v1/curated');
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

  getCategoriesList(){
    return Container(
      height: 50,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal:24),
        itemCount: categories.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Categories(
                    searchQuery: categories[index].categoriesName,
                  )
                )
              );
            },
            child: CategoriesTile(
              imageUrl: categories[index].imageUrl,
              title: categories[index].categoriesName,
            ),
          );
        } 
      ),
    );
  }

  @override
  void initState() {
    getTrendingWallpapers();
    categories = getCategories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              SizedBox(height: 8,),
              Container(
                margin: EdgeInsets.all(8),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Made By ", 
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text("Shiv Lochawala",
                      style: TextStyle(
                        color: Colors.green[400],
                        fontWeight: FontWeight.w900
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 8,),
              getCategoriesList(),
              SizedBox(height: 16,),
              WallpaperList(wallpapers: wallpapers, context: context),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imageUrl, title;
  CategoriesTile({@required this.imageUrl, this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right:8),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            child: Image.network(imageUrl, 
              height: 50, 
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 50, 
            width: 100,
            color: Colors.black38,
            alignment: Alignment.center,
            child: Text(title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 17 
              ),
            ),
          )
        ],
      ),
    );
  }
}

