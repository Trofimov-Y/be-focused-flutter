#!/bin/sh
dart pub global activate flutter_loco_translations
dart pub global run flutter_loco_translations --locales="en" --api_key="bImSTiTrbG2UYvuDx55rwX-W0h7W1nu7" --path="lib/l10n/arb"
flutter gen-l10n --arb-dir="lib/l10n/arb"
flutter pub run build_runner build --delete-conflicting-outputs
