import 'dart:io';

void main() async {
  final assetsDir = Directory('assets');
  if (!await assetsDir.exists()) {
    print('Error: assets directory not found');
    exit(1);
  }

  // Generate AppIcons
  await generateIcons();
  
  // Generate PNG Image Paths (for use with ImageContainerWidget)
  await generatePngImages();
  
  // Generate SVG Images
  await generateSvgImages();
  
  print('✅ Asset files generated successfully!');
}

Future<void> generateIcons() async {
  final iconsDir = Directory('assets/icons');
  if (!await iconsDir.exists()) {
    print('Warning: assets/icons directory not found');
    return;
  }

  final pngFiles = await iconsDir
      .list()
      .where((entity) => entity is File && entity.path.endsWith('.png'))
      .map((entity) => entity.path.split(Platform.pathSeparator).last)
      .toList()
    ..sort();

  final buffer = StringBuffer();
  buffer.writeln('// ignore_for_file: prefer_single_quotes');
  buffer.writeln('// Auto-generated file - do not edit manually');
  buffer.writeln('class AppIcons {');
  buffer.writeln('  AppIcons._();');
  buffer.writeln('  ');
  
  for (final file in pngFiles) {
    final baseName = _toCamelCase(file.replaceAll('.png', ''));
    final name = 'icon' + (baseName.isEmpty ? '' : baseName[0].toUpperCase() + baseName.substring(1));
    buffer.writeln('  static const String $name = "assets/icons/$file";');
  }
  
  buffer.writeln('}');
  buffer.writeln('');

  await File('lib/core/asset/app_icons.dart').writeAsString(buffer.toString());
  print('✓ Generated lib/core/asset/app_icons.dart');
}

Future<void> generatePngImages() async {
  final pngDir = Directory('assets/images/png');
  if (!await pngDir.exists()) {
    print('Warning: assets/images/png directory not found');
    return;
  }

  final pngFiles = await pngDir
      .list()
      .where((entity) => entity is File && entity.path.endsWith('.png'))
      .map((entity) => entity.path.split(Platform.pathSeparator).last)
      .toList()
    ..sort();

  final buffer = StringBuffer();
  buffer.writeln('// ignore_for_file: prefer_single_quotes');
  buffer.writeln('// Auto-generated file - do not edit manually');
  buffer.writeln('// PNG images are handled via ImageContainerWidget');
  buffer.writeln('class ImagePaths {');
  buffer.writeln('  ImagePaths._();');
  buffer.writeln('  ');
  
  for (final file in pngFiles) {
    final name = _toCamelCase(file.replaceAll('.png', ''));
    buffer.writeln('  static const String $name = "assets/images/png/$file";');
  }
  
  buffer.writeln('}');
  buffer.writeln('');

  await File('lib/core/constant/image_paths.dart').writeAsString(buffer.toString());
  print('✓ Generated lib/core/constant/image_paths.dart');
}

Future<void> generateSvgImages() async {
  final svgDir = Directory('assets/images/vectors');
  if (!await svgDir.exists()) {
    print('Warning: assets/images/vectors directory not found');
    return;
  }

  final svgFiles = await svgDir
      .list()
      .where((entity) => entity is File && entity.path.endsWith('.svg'))
      .map((entity) => entity.path.split(Platform.pathSeparator).last)
      .toList()
    ..sort();

  final buffer = StringBuffer();
  buffer.writeln('// ignore_for_file: prefer_single_quotes');
  buffer.writeln('// Auto-generated file - do not edit manually');
  buffer.writeln('class AppImagesSvg {');
  buffer.writeln('  AppImagesSvg._();');
  buffer.writeln('  ');
  
  for (final file in svgFiles) {
    final name = _toCamelCase(file.replaceAll('.svg', ''));
    buffer.writeln('  static const String $name = "assets/images/vectors/$file";');
  }
  
  buffer.writeln('}');
  buffer.writeln('');

  await File('lib/core/asset/app_images_svg.dart').writeAsString(buffer.toString());
  print('✓ Generated lib/core/asset/app_images_svg.dart');
}

String _toCamelCase(String input) {
  final words = input.split(RegExp(r'[_\s-]+'));
  if (words.isEmpty) return '';
  
  final firstWord = words[0].toLowerCase();
  final restWords = words.skip(1).map((word) => 
      word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1).toLowerCase());
  
  return firstWord + restWords.join('');
}

