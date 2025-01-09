import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:any_link_preview/any_link_preview.dart';

import '../controller/story_controller.dart';


class StoryItemContainer extends StatelessWidget {
  final String url;
  final Color? bgColor;
  final Key? key;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final EdgeInsetsGeometry? captionOuterPadding;
  final bool shown;
  final Duration? duration;

  const StoryItemContainer({
    required this.url,
    this.bgColor,
    this.key,
    this.loadingWidget,
    this.errorWidget,
    this.captionOuterPadding,
    this.shown = false,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      color: bgColor,
      child: Stack(
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: AnyLinkPreview(
                link: url,
                displayDirection: UIDirection.uiDirectionVertical,
                showMultimedia: true,
                bodyMaxLines: 3,
                bodyTextOverflow: TextOverflow.ellipsis,
                titleStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
                errorBody: 'Show my custom error body',
                errorTitle: 'Show my custom error title',
                errorWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey[300],
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text('Oops!, can\'t preview this link'),
                    ),
                    SizedBox(height: 16),
                    InkWell(
                      onTap: () => EasyLauncher.url(url: url),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[300],
                        ),
                        padding: EdgeInsets.all(8),
                        child: Text(url),
                      ),
                    ),
                  ],
                ),
                cache: Duration(days: 7),
                backgroundColor: Colors.grey[300],
                borderRadius: 12,
                removeElevation: false,
                boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  bottom: 24,
                ),
                padding: captionOuterPadding ??
                    EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}