import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Bayar extends StatefulWidget {
  String payment;
  String foto_bukti_pembayaran;

  Bayar({
    this.payment,
    this.foto_bukti_pembayaran,
  });

  @override
  _Bayar createState() => _Bayar();
}

class _Bayar extends State<Bayar> {
  File _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
        left: 15.0,
        right: 15.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          5.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  widget.payment == "Cash" ? Icons.attach_money : Icons.payment,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 15.0,
                ),
                Expanded(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Varela',
                        color: Colors.grey[800],
                        fontSize: 13.0,
                      ),
                      text: widget.payment,
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: widget.payment == "Transfer" ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    widget.foto_bukti_pembayaran != ""
                        ? Icons.check
                        : Icons.clear,
                    color: widget.foto_bukti_pembayaran != ""
                        ? Colors.green
                        : Colors.red,
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Varela',
                          color: widget.foto_bukti_pembayaran != ""
                              ? Colors.green
                              : Colors.red,
                          fontSize: 13.0,
                        ),
                        text: widget.foto_bukti_pembayaran != ""
                            ? "Sudah Mengirim Bukti Pembayaran"
                            : "Belum Mengirim Bukti Pembayaran",
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.foto_bukti_pembayaran == "" ? true : false,
                    child: RaisedButton(
                        child: Text('Upload'),
                        onPressed: () => {_showPickOptionsDialog(context)}),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadPicker(ImageSource source) async {
    File picked = await ImagePicker.pickImage(source: source);
    if (picked != null) {
      setState(() {
        _cropImage(picked);
      });
    }
    Navigator.pop(context);
  }

  _cropImage(File picked) async {
    File cropped = await ImageCropper.cropImage(
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: "Crop Foto",
      ),
      sourcePath: picked.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio4x3,
      ]
    );
    if (cropped != null) {
      setState(() {
        _pickedImage = cropped;
      });
    }
  }

  _showPickOptionsDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                    ),
                    title: Text("Camera"),
                    onTap: () {
                      _loadPicker(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.file_present,
                      color: Colors.grey,
                    ),
                    title: Text("Gallery"),
                    onTap: () {
                      _loadPicker(ImageSource.gallery);
                    },
                  )
                ],
              ),
            ));
  }
}
