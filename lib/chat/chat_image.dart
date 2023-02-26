import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';

class ChatImage extends StatefulWidget {
  final String imageUrl;

  ChatImage({required this.imageUrl});

  @override
  _ChatImageState createState() => _ChatImageState();
}

class _ChatImageState extends State<ChatImage> {
  bool _downloading = false;
  String _path = "";
  bool _isExists = false;
  
  Future<void> _checkFile() async {
    if (await Permission.storage.request().isGranted) {
    var tempDir = await getExternalStorageDirectory();
    bool exists = await File("${tempDir?.path}/${widget.imageUrl.split('/').last}").exists();
    setState(() {
      _path = "${tempDir?.path}/${widget.imageUrl.split('/').last}";
      _isExists = exists;
    });
    }
  }
  @override
  void initState() {
    super.initState();
    _checkFile();
  }

  Future<void> _downloadImage() async {
    if (await Permission.storage.request().isGranted) {
      setState(() {
      _downloading = true;
    });
    if(!_isExists){
      Dio dio = Dio();
      await dio.download(widget.imageUrl, _path);
    }
    OpenFilex.open(_path);
    setState(() {
      _downloading = false;
      _isExists = true;
    });
    }
  }

  void openFile(){
    OpenFilex.open(_path);
  }
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      padding: const EdgeInsets.fromLTRB(5, 15, 5, 5),
      width: 220,
      child:Stack(
      alignment: Alignment.center,
      children: [
        Image.network(widget.imageUrl),
        if (_downloading)
          CircularProgressIndicator()
        else if(!_isExists)
          IconButton(
            icon: Icon(Icons.download_rounded),
            onPressed: _downloadImage,
          )
          else
          IconButton(onPressed: openFile, icon: Icon(Icons.download_done))
      ],
    ));
  }
}
