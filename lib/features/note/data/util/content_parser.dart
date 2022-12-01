import 'dart:io';

import 'package:xml/xml.dart';

import '../model/note.dart';

class ContentTags {
  ContentTags._();

  static const text = 'text';
  static const check = 'check';
  static const image = 'image';
}

class ContentAttributes {
  ContentAttributes._();

  static const checked = 'checked';
}

class ContentParser {
  ContentParser._();

  static List<Object> parseContent(String source) {
    return XmlDocument.parse(source).rootElement.childElements.map((element) {
      switch (element.name.local) {
        case ContentTags.text:
          return element.text;
        case ContentTags.check:
          return CheckItem(
            element.text,
            element.getAttribute(ContentAttributes.checked) == 'true',
          );
        case ContentTags.image:
          return File(element.text);
        default:
          throw Exception('Invalid content tag: ${element.name}');
      }
    }).toList();
  }

  static String contentToString(List<Object> content) {
    final document = XmlDocument([
      XmlElement(XmlName('note')),
    ]);
    final children = document.rootElement.children;
    for (var item in content) {
      switch (item.runtimeType) {
        case String:
          item as String;
          children.add(
            XmlElement(
              XmlName(ContentTags.text),
              [],
              [XmlText(item)],
            ),
          );
          break;
        case CheckItem:
          item as CheckItem;
          children.add(
            XmlElement(
              XmlName(ContentTags.check),
              [
                XmlAttribute(
                  XmlName(ContentAttributes.checked),
                  item.checked.toString(),
                )
              ],
              [XmlText(item.text)],
            ),
          );
          break;
        case File:
          item as File;
          children.add(
            XmlElement(
              XmlName(ContentTags.image),
              [],
              [XmlText(item.path)],
            ),
          );
          break;
        default:
          throw Exception('Invalid content type: ${item.runtimeType}');
      }
    }
    return document.toXmlString();
  }
}
