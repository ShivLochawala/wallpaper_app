import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/wallpaper_model.dart';
import 'package:wallpaper_app/views/image_view.dart';

Widget brandName(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text("My",
        style: TextStyle(
          color: Colors.green[400],
          fontSize: 18,
          fontWeight: FontWeight.w500
        ),
      ),
      Text("Wallpaper", 
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500
        ),
      ),
      Text("App", 
        style: TextStyle(
          color: Colors.green[400],
          fontSize: 18,
          fontWeight: FontWeight.w500 
        ),
      )
    ],
  );
  /*return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      children: <TextSpan>[
        TextSpan(text: 'My', style: TextStyle(color: Colors.blue)),
        TextSpan(text: 'Wallpaper', style: TextStyle(color: Colors.black87)),
        TextSpan(text: 'App', style: TextStyle(color: Colors.blue)),
      ],
    ),
  );*/
}

// ignore: non_constant_identifier_names
Widget WallpaperList({List<WallpaperModel> wallpapers, context}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal:16),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper){
        return GridTile(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => ImageView(
                  imageUrl: wallpaper.src.portrait
                  )
                )
              );
            },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                child: ClipRRect(
                  child:wallpaper.src.portrait != null?
                    CachedNetworkImage(
                      imageUrl: wallpaper.src.portrait,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => LinearProgressIndicator(
                         valueColor: AlwaysStoppedAnimation<Color>(Colors.green[400]),
                         backgroundColor: Colors.white
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    )
                    :Container(),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}