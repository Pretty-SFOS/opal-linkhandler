<!--
SPDX-FileCopyrightText: 2023 Mirian Margiani
SPDX-License-Identifier: GFDL-1.3-or-later
-->

# Changelog

## 2.4.0 (2025-12-24)

- Added support for quickly previewing the contents of a link by swiping left.
  - All network access requires explicit user interaction.
  - A warning is shown when using a mobile data connection.
  - This feature is only enabled for HTTPS urls by default.
  - Use the `LinkPreviewMode` setting to configure the feature.
  - Thanks to roundedrectangle!
- Redesigned buttons to be more elegant.
- Fixed translation file names to be the same across all modules

- Fixed packaging to include `opal.pri` and `.gitignore` files for
  easier integration into apps. Add `include(libs/opal.pri)`
  to your `harbour-myapp.pro` file to enable Opal in your app.
- **Note:** you *still* must modify your `yaml` or `spec` file for Harbour compliance!
  See [here](https://github.com/Pretty-SFOS/opal/blob/main/README.md#using-opal)
  for updated instructions.
- Fixed documentation to exclude some unnecessary generated parts.

## 2.3.1 (2025-11-26)

- Added translations: Bengali, Chinese (Traditional Han script), Hindi, Malayalam, Thai
- Updated translations: French

## 2.3.0 (2025-08-10)

- Updated translations with contents from apps using this module.
  I tried my best to always keep the most up-to-date version of all strings.
  Hopefully nothing was overwritten - I apologize for any lost work!

- Added a new function `openOrCopyMultipleUrls` to preview multiple URLs quickly
- Updated documentation to include type for all function parameters

## 2.2.7 (2025-08-08)

- Added translations: Arabic, Persian
- Updated translations: Turkish

## 2.2.6 (2025-06-11)

- Updated translations: French

## 2.2.5 (2025-03-12)

- Updated translations: Tamil

## 2.2.4 (2025-03-11)

- Updated translations: Romanian, Tamil

## 2.2.3 (2024-11-28)

- Added translations: Dutch (Belgium), Norwegian Nynorsk
- Updated translations: Portuguese

## 2.2.2 (2024-11-27)

- Added translations: Portuguese, Portuguese (Brazil), Tamil
- Updated translations: Italian

## 2.2.1 (2024-11-19)

- Updated translations: Estonian, Finnish, Russian, Slovak, Spanish, Belarusian

## 2.2.0 (2024-10-30)

- Added translations: Lithuanian
- Updated translations: German, English
- Added support for sharing links and copying link titles (thank you, roundedrectangle!)

## 2.1.1 (2024-10-13)

- Removed duplicate Romanian translation

## 2.1.0 (2024-10-11)

- Updated translations: English, Estonian, Swedish, Ukrainian, Indonesian, Spanish, Russian, Polish, Chinese, Moldavian, Hungarian, Norwegian, Italian, Romanian, and more
- Updated packaging boilerplate and attribution file
- Improved and translated example page

## 2.0.0 (2023-06-29)

- Moved the ready-made Attribution component from
  `Opal/<module>/Opal<module>Attribution.qml` to `Opal/Attributions/Opal<module>Attribution.qml`
- You no longer have to import all Opal modules on the “About” page to attribute them,
  simply use `import "../modules/Opal/Attributions"` to access all attributions
- Translations improvements

## 1.0.0 (2023-06-26)

- First release
- Extracted from Opal.About into a separate module
