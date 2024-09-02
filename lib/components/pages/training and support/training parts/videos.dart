import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class Videos extends StatefulWidget {
  final String deptname;
  const Videos({
    super.key,
    required this.deptname,
  });

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  List<Map<String, String>>? videoList;
  bool isLoaded = false;
  String? errorMessage;

  Future getVideos(String name) async {
    final gemini = Gemini.instance;

    try {
      final response = await gemini.text(
        "You are responsible for sharing educational YouTube videos related to the ${widget.deptname} department. Provide a list of YouTube video URLs that are relevant to this department and would help in understanding its roles and responsibilities.",
      );

      if (response?.output != null) {
        // Log the response for debugging
        print("API Response: ${response!.output}");

        setState(() {
          videoList = extractVideoLinks(response.output!);

          if (videoList == null || videoList!.isEmpty) {
            errorMessage = "No video links found in the response.";
          }
        });
      } else {
        setState(() {
          errorMessage = "No response from the API.";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "An error occurred: $e";
      });
      print(e.toString());
    } finally {
      setState(() {
        isLoaded = true;
      });
    }
  }

  List<Map<String, String>> extractVideoLinks(String response) {
    final lines = response.split('\n');
    final List<Map<String, String>> videos = [];

    for (var line in lines) {
      line = line.trim();
      if (line.startsWith('* [')) {
        // Extract title and link
        final match = RegExp(r'\*\s\[(.*?)\]\((.*?)\)').firstMatch(line);
        if (match != null) {
          final title = match.group(1) ?? '';
          final link = match.group(2) ?? '';
          videos.add({'title': title, 'link': link});
        }
      }
    }

    return videos;
  }

  @override
  void initState() {
    super.initState();
    getVideos(widget.deptname);
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.deptname} Videos',
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue[400],
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.blue[50],
        child: isLoaded
            ? errorMessage != null
                ? Center(
                    child: Text(
                      errorMessage!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                  )
                : videoList != null && videoList!.isNotEmpty
                    ? ListView.builder(
                        itemCount: videoList!.length,
                        itemBuilder: (context, index) {
                          final video = videoList![index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            shadowColor: Colors.blue[200],
                            child: InkWell(
                              onTap: () {
                                _launchURL(video['link']!);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${index + 1}: ${video['title']}',
                                      style: TextStyle(
                                        color: Colors.blue[900],
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      video['link'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          'No videos found for ${widget.deptname}.',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                      )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/animation/dept1.json',
                        height: 200, width: 200),
                    const SizedBox(height: 20),
                    const Text(
                      'Loading, please wait...',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
