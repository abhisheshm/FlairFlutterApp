import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_filex/open_filex.dart';

class ChatFile extends StatefulWidget {
  final String fileUrl;

  ChatFile({required this.fileUrl});

  @override
  _ChatFileState createState() => _ChatFileState();
}

class _ChatFileState extends State<ChatFile> {
  bool _downloading = false;
  String _path = "";
  bool _isExists = false;
  
  Future<void> _checkFile() async {
if (await Permission.storage.request().isGranted) {
    var tempDir = await getExternalStorageDirectory();
    bool exists = await File("${tempDir?.path}/${widget.fileUrl.split('/').last}").exists();
    print(exists);
    setState(() {
      _path = "${tempDir?.path}/${widget.fileUrl.split('/').last}";
      _isExists = exists;
    });
}
  }
  @override
  void initState() {
    super.initState();
    
    _checkFile();
  }

  Future<void> _downloadFile() async {
    if (await Permission.storage.request().isGranted) {
      setState(() {
      _downloading = true;
    });
    if(!await File(_path).exists()){
      Dio dio = Dio();
      await dio.download(widget.fileUrl, _path);
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
    return Container(
      width: 220,
      child:
      Stack(
      alignment: Alignment.center,
      children: [
        Text(widget.fileUrl.split('/').last),
        if (_downloading)
          CircularProgressIndicator()
        else if(!_isExists)
          IconButton(
            icon: Icon(Icons.download_rounded),
            onPressed: _downloadFile,
         )
         else
          IconButton(onPressed: openFile, icon: Icon(Icons.download_done))
      ]
    ));
  }
}
