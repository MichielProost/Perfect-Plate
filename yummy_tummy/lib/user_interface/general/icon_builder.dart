import 'package:flutter/material.dart';

enum CustomIcon { vegan, vegetarian }

class IconBuilder extends StatelessWidget {
  static final Map<CustomIcon, String> iconPaths = {
    CustomIcon.vegan: "icons/vegan.png",
    CustomIcon.vegetarian: "icons/vegetarian.png",
  };

  final String _imgPath;
  final Color color;
  final double size;

  /// Build an icon from the given image path
  IconBuilder(CustomIcon iconType,
      {this.color = Colors.black, this.size = 24.0})
      : _imgPath = iconPaths[iconType];

  @override
  ImageIcon build(BuildContext context) {
    return ImageIcon(
      AssetImage(_imgPath),
      color: color,
      size: 24,
    );
  }
}
