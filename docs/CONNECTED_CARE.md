# DocConnect patient app

Connects to the FieldMed backend shared with Zoctor. GymRatAI is entirely separate.

Build in the cloud with Flutter 3.24.5 or a compatible newer SDK:

```
flutter pub get
flutter analyze lib/main.dart lib/care
flutter test
flutter build web --dart-define-from-file=care-config.json
```

Copy `care-config.example.json` to the ignored `care-config.json` in the cloud and set FieldMed's URL and publishable key. Never use a service-role key. The code has been built against FieldMed project `xiivqhjbbpupkjytlndg`.

The app uses clinic-provisioned patient accounts, displays appointments across doctors, patient-visible checkup summaries, and an in-app notification inbox with read state. Data refreshes every 30 seconds and with pull-to-refresh. Zoctor owns schema migrations, authorization tests and the five-minute cloud reminder schedule. No real clinic accounts were provisioned by this change.

Push notifications outside the app, external calendar integrations and production frontend hosting are not configured. The earlier prototype screens remain in source but are no longer the application entry flow. Full-project analyzer findings from those legacy screens are separate from the new care flow.
