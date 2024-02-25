import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solution_challenge_app/features/journal/screens/widgets/open_journal.dart';

class JournalWidget extends StatelessWidget {
  const JournalWidget({super.key, required this.content});

  final dynamic content;

  @override
  Widget build(BuildContext context) {
    bool isHeading = content['heading'] == null ? false : true;
    bool isImage = content['imagePaths'].length == 0 ? false : true;
    bool isContent = content['content'] == null ? false : true;
    final File path = isImage ? File(content['imagePaths'][0]) : File('');

    return InkWell(
      onTap: () {
        Get.to(OpenJournal(content: content));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isHeading
                  ? Text(
                      content['heading'],
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    )
                  : const SizedBox(),
              isContent
                  ? Column(
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          (content['content'].length <= 36)
                              ? content['content']
                              : "${content['content'].substring(0, 31)}....",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              isImage
                  ? Column(
                      children: [
                        const SizedBox(height: 16),
                        Container(
                          // width: 250,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: FileImage(path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
