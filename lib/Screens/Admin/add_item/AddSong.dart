import 'dart:html';
import 'dart:io';
import 'dart:js_util';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:file_picker/src/linux/file_picker_linux.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/Screens/Admin/add_item/bloc/add_song_bloc.dart';
import 'package:music/data/Services/Artist/Artist_Service.dart';
import 'package:music/data/model/Artist.dart';
import 'package:music/data/repository/Artist/ArtistRepository.dart';
import 'package:music/data/repository/song_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

IArtistServices artistService = ArtistSupaBaseDB();

class AddSong extends StatefulWidget {
  const AddSong();
  @override
  State<AddSong> createState() => _AddSongState();
}

late Artist selectedArtist;
String path = '';
String fileName = '';
var myFile;
late AddSongBloc bloc;

class _AddSongState extends State<AddSong> {
  final TextEditingController titleController = TextEditingController();
  @override
  void initState() {}
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddSongBloc>(
      create: (context) {
        bloc = AddSongBloc(artistRepository, songRepository);
        bloc.add(AddSongStarted());
        bloc.stream.forEach((state) {
          if (state is LoadArtistSuccess) {
            selectedArtist = state.artists[0];
          }
        });
        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Song'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 300,
                child: BlocBuilder<AddSongBloc, AddSongState>(
                  builder: (context, state) {
                    if (state is LoadArtistSuccess) {
                      return DropdownButton<Artist>(
                        value: selectedArtist,
                        items: state.artists.map((Artist artist) {
                          return DropdownMenuItem<Artist>(
                              value: artist, child: Text(artist.artistName!));
                        }).toList(),
                        onChanged: (Artist? newValue) {
                          setState(() {
                            selectedArtist = newValue!;
                            debugPrint(selectedArtist.id.toString());
                          });
                        },
                      );
                    } else if (state is ErrorLoadArtist) {
                      return Text(state.error);
                    } else if (state is LoadingArtist) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else
                      return const Text('state not valid');
                  },
                ),
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(hintText: 'عنوان'),
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
                          myFile = result.files.first.bytes;
                          setState(() {
                            fileName = result.files.first.name;
                          });
                        }
                      },
                      child: Text('Browse')),
                  SizedBox(width: 20),
                  Text(fileName)
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                  height: 40,
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () {
                        bloc.add(BtnSaveClick(
                            fileName: fileName,
                            myFile: myFile,
                            artistId: selectedArtist.id!,
                            title: titleController.text));
                      },
                      child: Text('ذخیره')))
            ],
          ),
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
