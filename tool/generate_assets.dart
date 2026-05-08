import 'dart:io';

// Run this script with: dart tool/generate_assets.dart
void main() async {
  await _generate(
    assetsPath: 'assets/images/',
    outputPath: 'lib/src/core/constants/images_assets.dart',
    className: 'ImagesAssets',
    extensions: ['.png', '.jpg', '.jpeg', '.webp'],
    prefix: 'assets_images',
  );

  await _generate(
    assetsPath: 'assets/svg/',
    outputPath: 'lib/src/core/constants/svg_assets.dart',
    className: 'SvgAssets',
    extensions: ['.svg'],
    prefix: 'assets_svg',
  );
}

Future<void> _generate({
  required String assetsPath,
  required String outputPath,
  required String className,
  required List<String> extensions,
  required String prefix,
}) async {
  final dir = Directory(assetsPath);

  if (!dir.existsSync()) {
    print('❌ Directory not found: $assetsPath');
    return;
  }

  final files =
      dir
          .listSync(recursive: true)
          .whereType<File>()
          .where(
            (file) =>
                !file.path.contains('/2.0x/') &&
                !file.path.contains('/3.0x/') &&
                !file.path.contains('/4.0x/') &&
                extensions.any((ext) => file.path.toLowerCase().endsWith(ext)),
          )
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  final buffer = StringBuffer();

  buffer.writeln('// ignore_for_file: prefer_single_quotes');
  buffer.writeln('// GENERATED FILE - DO NOT EDIT MANUALLY');
  buffer.writeln('// Run: dart tool/generate_assets.dart');
  buffer.writeln();

  buffer.writeln('class $className {');
  buffer.writeln('  $className._();');
  buffer.writeln();

  for (final file in files) {
    final relativePath = file.path.replaceAll('\\', '/');

    final fileName = relativePath.split('/').last;
    final nameWithoutExt = fileName.split('.').first;

    final sanitized = nameWithoutExt
        .replaceAll(' ', '_')
        .replaceAll('-', '_')
        .replaceAll('.', '_')
        .replaceAll('@', '_')
        .replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '');

    final safeName = RegExp(r'^\d').hasMatch(sanitized)
        ? '${prefix}_$sanitized'
        : sanitized;

    final camelCase = _toCamelCase('${prefix}_$safeName');

    buffer.writeln('  /// $relativePath');
    buffer.writeln('  static const String $camelCase = "$relativePath";');
    buffer.writeln();
  }

  buffer.writeln('}');

  final outputFile = File(outputPath);

  if (!outputFile.parent.existsSync()) {
    outputFile.parent.createSync(recursive: true);
  }

  outputFile.writeAsStringSync(buffer.toString());

  print('✅ Generated: $outputPath (${files.length} assets)');
}

String _toCamelCase(String text) {
  final parts = text.split('_');

  return parts.first.toLowerCase() +
      parts
          .skip(1)
          .map(
            (part) =>
                part.isEmpty ? '' : part[0].toUpperCase() + part.substring(1),
          )
          .join();
}
