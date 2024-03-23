import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:file_picker/src/linux/file_picker_linux.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CrudScreen extends StatelessWidget {
  const CrudScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(hintText: 'عنوان'),
            ),
            const TextField(
              decoration: InputDecoration(hintText: 'مسیر'),
            ),
            const TextField(
              decoration: InputDecoration(hintText: 'آرتیست'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () async {
                      final result = await FilePickerWeb.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.any,
                      );

                      if (result != null) {
                        Random random = Random();
                        final rand = random.nextInt(99999);
                        final supabase = Supabase.instance.client;
                        final myFile = result.files.first.bytes;
                        final fileName = result.files.first.name;
                        final String path = await supabase.storage
                            .from('mybucket')
                            .uploadBinary(
                              'public/${rand.toString() + fileName}',
                              myFile!,
                              fileOptions: const FileOptions(
                                  cacheControl: '3600', upsert: false),
                            );
                      }
                    },
                    child: Text('Browse')),
                SizedBox(width: 20),
                Text('data')
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
                height: 40,
                width: 300,
                child: ElevatedButton(onPressed: () {}, child: Text('ذخیره')))
          ],
        ),
      ),
    );
  }
}

void uploadFile() async {
  final result = FilePicker.platform.pickFiles(
    type: FileType.any,
  );
  if (result != null) {
  } else {
    // User canceled the picker
  }
}
