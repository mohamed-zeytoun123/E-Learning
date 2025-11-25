# Asset Generation Tool

This tool automatically generates separate asset files based on file extensions and locations.

## Generated Files

- **`lib/core/asset/app_icons.dart`** - All PNG files from `assets/icons/`
- **`lib/core/asset/app_images_png.dart`** - All PNG files from `assets/images/png/`
- **`lib/core/asset/app_images_svg.dart`** - All SVG files from `assets/images/vectors/`

## Usage

To regenerate asset files after adding, removing, or renaming assets:

```bash
dart run tool/generate_assets.dart
```

Or simply:

```bash
dart tool/generate_assets.dart
```

## How It Works

The script automatically:
1. Scans the `assets/icons/` directory for `.png` files → generates `AppIcons` class
2. Scans the `assets/images/png/` directory for `.png` files → generates `AppImagesPng` class
3. Scans the `assets/images/vectors/` directory for `.svg` files → generates `AppImagesSvg` class

File names are automatically converted to camelCase (e.g., `check_double.png` → `checkDouble`).

## Example Usage in Code

```dart
import 'package:e_learning/core/asset/app_assets.dart';

// Icons
Image.asset(AppIcons.checkDouble)
Image.asset(AppIcons.errorOutline)

// PNG Images
Image.asset(AppImagesPng.homeeBg)

// SVG Images
SvgPicture.asset(AppImagesSvg.home)
SvgPicture.asset(AppImagesSvg.search1)
```

## Note

⚠️ **Do not edit the generated files manually!** They will be overwritten when you run the generation script.

