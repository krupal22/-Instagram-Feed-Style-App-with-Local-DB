import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:saver_gallery/saver_gallery.dart';


class DownloadHelper {


  static downloadAndSaveImage(String imageUrl, BuildContext context) async {

    if(Uri.parse(imageUrl).isAbsolute){

    if (await checkAndRequestPermissions(skipIfExists: false)) {
      late ValueNotifier<double> valueNotifier = ValueNotifier(0.0);
      SaveResult result =SaveResult(false, "null");
      String imageName = "${DateTime.now().millisecondsSinceEpoch}.jpg";


      Dio()
          .get(imageUrl, options: Options(responseType: ResponseType.bytes),
          onReceiveProgress: (received, total) {
            var progress = (received / total); // Update progress
            print(progress * 100);
            valueNotifier.value = progress;
          }).then((response) async {


        result = await SaverGallery.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          fileName: imageName,
          androidRelativePath: "Pictures/Kevit/images",
          skipIfExists: false,
        );

        valueNotifier.notifyListeners();

      });


      showDialog(
          context: context,
          builder: (ctx) {
            return Dialog(
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: const BoxDecoration(),
                    child: ValueListenableBuilder(
                        valueListenable: valueNotifier,
                        builder: (ctx, val, _) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Download File"),
                              SizedBox(height: 10),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    height: 60,
                                    width: 60,
                                    child: CircularProgressIndicator(
                                      value: valueNotifier.value,
                                    ),
                                  ),
                                  Text("${(valueNotifier.value*100).round()}%")
                                ],
                              ),

                            SizedBox.shrink(),
                              SizedBox(height: 10),

                              ElevatedButton(onPressed: (){

                                Navigator.of(context).pop();

                              }, child: Text("Continue"))

                            ],
                          );
                        })
                )
            );
          });




    } else {
      print(false);
    }
    }else{

      //Local File So just Move File One folder to another
      if (await checkAndRequestPermissions(skipIfExists: false)){

        String imageName = "${DateTime.now().millisecondsSinceEpoch}.jpg";

        File _selectedFile= File(imageUrl);
        await SaverGallery.saveImage(
          await _selectedFile.readAsBytes(),
          quality: 60,
          fileName: imageName,
          androidRelativePath: "Pictures/Kevit/images",
          skipIfExists: false,
        );


      }



    }
  }

  static Future<bool> checkAndRequestPermissions(
      {required bool skipIfExists}) async {
    if (!Platform.isAndroid && !Platform.isIOS) {
      return false; // Only Android and iOS platforms are supported
    }

    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = deviceInfo.version.sdkInt;

      if (skipIfExists) {
        // Read permission is required to check if the file already exists
        return sdkInt >= 33
            ? await Permission.photos.request().isGranted
            : await Permission.storage.request().isGranted;
      } else {
        // No read permission required for Android SDK 29 and above
        return sdkInt >= 29
            ? true
            : await Permission.storage.request().isGranted;
      }
    } else if (Platform.isIOS) {
      // iOS permission for saving images to the gallery
      return skipIfExists
          ? await Permission.photos.request().isGranted
          : await Permission.photosAddOnly.request().isGranted;
    }

    return false; // Unsupported platforms
  }






}
