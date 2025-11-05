import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:markdown_widget/markdown_widget.dart';

class ReleaseNoteDialog {
  // TODO: make it static
  AlertDialog alertDialog(Size size, Color mainColor, String version) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      // TODO: check if IntrinsicHeight() is the best way!
      content: IntrinsicHeight(
        child: FutureBuilder<String>(
          future: fetchReleaseNote(
            'https://gitlab.com/api/v4/projects/67820864/releases/v$version',
          ),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            // TODO: check return widgets, get it better!
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: size.width * 0.18,
                    height: size.width * 0.18,
                    child: CircularProgressIndicator(
                      strokeWidth: size.width * 0.02,
                      strokeCap: StrokeCap.round,
                      value: null,
                      color: Colors.white70,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: size.width * 0.036,
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              final String markdown =
                  '### New in v$version\n'
                  '${snapshot.data}\n\n'
                  '[v$version](https://gitlab.com/morgenfrost/maya/-/releases/v$version)';

              return Container(
                width: size.width * 0.8,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      mainColor,
                      BlendMode.modulate,
                    ),
                    image: AssetImage('assets/images/bg_pattern_one.jpg'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                ),
                child: MarkdownBlock(
                  data: markdown,
                  config: MarkdownConfig(
                    configs: [
                      H3Config(
                        style: TextStyle(
                          fontSize: size.width * 0.052,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      H4Config(
                        style: TextStyle(
                          fontSize: size.width * 0.042,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      PConfig(
                        textStyle: TextStyle(
                          fontSize: size.width * 0.036,
                          color: Colors.white,
                        ),
                      ),
                      LinkConfig(
                        style: TextStyle(
                          fontSize: size.width * 0.036,
                          color: Colors.white,
                        ),
                      ),
                      ListConfig(
                        marker: (ordered, depth, index) {
                          return Container(
                            margin: EdgeInsets.all(size.width * 0.016),
                            width: size.width * 0.02,
                            height: size.width * 0.02,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Text(
                  'No data available.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: size.width * 0.036,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

Future<String> fetchReleaseNote(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);

    return data['description'];
  } else {
    throw Exception('Failed to load data.');
  }
}
