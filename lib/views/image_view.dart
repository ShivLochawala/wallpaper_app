import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:url_launcher/url_launcher.dart';

class ImageView extends StatefulWidget {
  final String imageUrl;
  ImageView({@required this.imageUrl});
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imageUrl,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(widget.imageUrl, 
              fit: BoxFit.cover,)
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    _save();
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        color: Color(0xff1C1818).withOpacity(0.9),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/2,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0x36FFFFFF),
                              Color(0xff1C1818)
                            ]
                          ),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color:Colors.white54,)
                        ),
                        child: Column(
                          children: <Widget>[
                            Text('Set Wallpaper', style: TextStyle(fontSize: 16, color: Colors.white),),
                            Text('Image will be saved in gallery', style: TextStyle(fontSize: 12, color: Colors.white),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height:16),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text("Cancel", style: TextStyle(color: Colors.white),)
                ),
                SizedBox(height: 50,),
              ],
            ),
          )
        ],
      )
    );
  }
  _save() async {
    if(Platform.isAndroid){
      await _askPermission();
    }
    
    var response = await Dio().get(widget.imageUrl,
        options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

/*
  _askPermission() async {
    if (Platform.isIOS) {
      /*Map<PermissionGroup, PermissionStatus> permissions =
          */await PermissionHandler()
              .requestPermissions([PermissionGroup.photos]);
    } else {
     /* PermissionStatus permission = */await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
    }
  }
  */
  _askPermission() async{
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }
  
}