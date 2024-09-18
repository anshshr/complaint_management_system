import 'package:flutter/material.dart';

class BotChatText extends StatelessWidget {
  final String text;
  const BotChatText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 15),
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(text,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                            )),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://www.shutterstock.com/image-illustration/3d-illustration-little-robot-fat-260nw-1640636815.jpg',
              ),
              backgroundColor: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }
}
