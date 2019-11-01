import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class LinkTextSpan extends TextSpan {
  LinkTextSpan({TextStyle style, String url, String text})
      : super(
            style: style,
            text: text ?? url,
            recognizer: TapGestureRecognizer()
              ..onTap = () => launcher.launch(url));
}

class RichTextView extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int maxLines;

  RichTextView(this.text, {this.style, this.maxLines});

  bool _isLink(String input) {
    final matcher = RegExp(
        r"(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)");
    return matcher.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    final _normalStyle = Theme.of(context).textTheme.body1.merge(style);
    final _linkStyle = _normalStyle.copyWith(
      fontWeight: FontWeight.w500,
      color: Theme.of(context).accentColor,
    );
    final words = text.split(' ');
    List<TextSpan> span = [];
    words.forEach((word) {
      span.add(_isLink(word)
          ? LinkTextSpan(
              text: '$word ',
              url: word,
              style: _linkStyle,
            )
          : TextSpan(text: '$word ', style: _normalStyle));
    });
    if (span.length > 0) {
      return RichText(
        maxLines: maxLines,
        text: TextSpan(text: '', style: style, children: span),
      );
    } else {
      return Text(text, maxLines: maxLines, style: _normalStyle);
    }
  }
}
