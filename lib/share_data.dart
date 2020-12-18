
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';


class ShareData extends StatefulWidget {
  @override
  ShareDataState createState() => ShareDataState();
}

class ShareDataState extends State<ShareData> {
  String text = '';
  String subject = '';
  List<String> imagePaths = [];

  @override
  Widget build(BuildContext context) {
    String pickedFile = imagePaths ==null?"":imagePaths.toString();
    String trimmedFileName = pickedFile.split("/").last;
    return  Scaffold(
        backgroundColor: Colors.blueGrey[100],

        appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: const Text('Flutter Share Data'),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Share text:',
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'Enter some text and/or link to share',
                    ),
                    maxLines: 2,
                    onChanged: (String value) => setState(() {
                      text = value;
                    }),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Share subject:',
                      labelStyle: TextStyle(color: Colors.blue),

                      hintText: 'Enter subject to share (optional)',
                    ),
                    maxLines: 2,
                    onChanged: (String value) => setState(() {
                      subject = value;
                    }),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 12.0)),
                  ListTile(
                    leading: Icon(Icons.add),
                    title: Text("Add image"),
                    onTap: () async {
                      final imagePicker = ImagePicker();
                      final pickedFile = await imagePicker.getImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedFile != null) {
                        setState(() {
                          imagePaths.add(pickedFile.path);
                        });
                      }
                    },
                  ),
                  Text(imagePaths ==null?"":trimmedFileName),

                  const Padding(padding: EdgeInsets.only(top: 12.0)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Builder(
                        builder: (BuildContext context) {
                          return RaisedButton(
                            color: Colors.orangeAccent[100],
                            child: const Text('Share'),
                            onPressed: text.isEmpty && imagePaths.isEmpty
                                ? null
                                : () => _onShareData(context),
                          );
                        },
                      ),
                      const Padding(padding: EdgeInsets.only(top: 12.0)),
                      Builder(
                        builder: (BuildContext context) {
                          return RaisedButton(
                            color: Colors.orangeAccent[100],

                            child: const Text('Share With Empty Fields'),
                            onPressed: () => _onShareWithEmptyFields(context),
                          );
                        },
                      ),
                    ],
                  ),

                ],
              ),
            ),
          )
    );

  }



  _onShareData(BuildContext context) async {

    final RenderBox box = context.findRenderObject();

    if (imagePaths.isNotEmpty) {
      await Share.shareFiles(imagePaths,
          text: text,
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(text,
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

  _onShareWithEmptyFields(BuildContext context) async {
    await Share.share("text");
  }
}