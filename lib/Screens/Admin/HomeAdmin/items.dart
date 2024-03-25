import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/Screens/Admin/HomeAdmin/bloc/home_admin_bloc.dart';
import 'package:music/Screens/Admin/add_item/AddSong.dart';
import 'package:music/data/repository/song_repository.dart';

class MusicItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HomeAdminBloc? bloc;
    return BlocProvider<HomeAdminBloc>(
      create: (context) {
        bloc = HomeAdminBloc(songRepository);
        bloc!.add(HomeAdminStarted());
        bloc!.stream.forEach((state) {
          if (state is HomeAdminDeleteItemError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error.toString())));
          }
        });

        return bloc!;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              BlocBuilder<HomeAdminBloc, HomeAdminState>(
                builder: (context, state) {
                  if (state is HomeAdminSuccess) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return AddSong();
                                },
                              ));
                            },
                            icon: Icon(CupertinoIcons.add)),
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                            itemCount: state.songs.length,
                            itemBuilder: (context, index) {
                              final song = state.songs[index];
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(song.id.toString()),
                                      SizedBox(width: 20),
                                      Text(song.artistId.toString()),
                                      SizedBox(width: 20),
                                      Expanded(
                                          child: Center(
                                              child:
                                                  Text(song.sougTitle ?? ''))),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            CupertinoIcons.play_circle_fill,
                                            size: 30,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            bloc!.add(HomeAdminDeleteItem(
                                                itemId: song.id!));
                                          },
                                          icon: song.deleteLoading
                                              ? const Icon(
                                                  Icons.delete_outlined)
                                              : CircularProgressIndicator()),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(CupertinoIcons
                                              .pencil_circle_fill))
                                    ],
                                  ),
                                  Divider(),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (state is HomeAdminLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is HomeAdminError) {
                    return Center(
                      child: Text(state.err),
                    );
                  } else {
                    return Center(
                      child: Text('State Is Not Valid'),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
