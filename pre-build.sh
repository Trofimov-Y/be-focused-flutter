#!/bin/sh
dart run po_editor_translations --api_token=4c740314004bc10661b6ef8db3347beb --project_id=673153 --files_path=lib/l10n/arb
flutter gen-l10n --arb-dir="lib/l10n/arb"
flutter pub run build_runner build --delete-conflicting-outputs
