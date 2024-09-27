import 'package:flutter/material.dart';

class MyChatText extends StatelessWidget {
  final String text;
  final List images;
  const MyChatText({super.key, required this.text, required this.images});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    'https://cdn-icons-png.freepik.com/512/3656/3656988.png',
                  ),
                  backgroundColor: Colors.green,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.5),
                        border: Border.all(color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(text,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                    )),
                      ),
                    ),
                  ),
                )
              ],
            ),
            images.length > 0
                ? Container(
                    height: 200,
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: 30, top: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            height: 100,
                            width: 200,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(images[index]))),
                          ),
                        );
                      },
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
