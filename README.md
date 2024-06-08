# Mida.so - Server-side A/B Testing and Feature Flags
This is a server-side A/B testing and feature flags code that allows you to integrate with the Mida platform. The code is written in JavaScript and can be used in a Node.js environment.

## Prerequisites
Before using this code, make sure you have the following set up:
- Flutter and Dart installed on your machine
- A Mida.so account with project and experiment key

## Installation
1. Download this plugin
2. Import the necessary dependencies by adding in as plugin with path as following command into pubspec.yaml:
```yaml
dev_dependencies:
  mida:
    path: ../mida-core
```

## Usage
To use the server-side A/B testing and feature flags code, follow these steps:
1. Import the `Mida` package into your code:
```dart
import 'package:mida/mida.dart';
```
2. Create an instance of the `Mida` class by providing your Mida project key:
```dart
final mida = Mida(publicKey: 'YOUR_PROJECT_KEY');
```

### A/B Testing
3. Use the `getExperiment` method to retrieve the current version of an experiment for a user. You need to provide the experiment key and the distinct ID of the user:
```dart
final version = await mida.getExperiment(experimentKey: 'EXPERIMENT_KEY', distinctId: 'USER_DISTINCT_ID');
if (version == 'Control') {
  // Handle Control logic
}
if (version == 'Variant 1') {
  // Handle Variant 1 logic
}
// Depending on how many variants you have created
if (version == 'Variant 2') {
  // Handle Variant 2 logic
}
```
4. Use the `setEvent` method to log an event for a user. You need to provide the event name and the distinct ID of the user:
```dart
final event = await mida.setEvent(eventName: 'EVENT_NAME', distinctId: 'USER_DISTINCT_ID');
```
### User Attributes
5. Use the `setAttribute` method to set user attributes for a specific user. You need to provide the distinct ID of the user and an object containing the attribute key-value pairs:
```dart
final track = await mida.setAttribute(properties: {gender: 'male', company_name: 'Apple Inc'}, distinctId: 'USER_DISTINCT_ID');
```

## API Reference
### `Mida(projectKey, options)`
- `projectKey`: (required) Your Mida project key.
- `userId`: (optional) Your default user ID.
### `getExperiment(experimentKey, distinctId)`
- `experimentKey`: (required) The key of the experiment you want to get the version of.
- `distinctId`: (optional) The distinct ID of the user that other than default user ID.
- Returns a Response that resolves to the version of the experiment.
### `setEvent(eventName, distinctId)`
- `eventName`: (required) The name of the event you want to log.
- `distinctId`: (optional) The distinct ID of the user that other than default user ID.
- Returns a Response that resolves when the event is successfully logged.
### `setAttribute(distinctId, properties)`
- `properties`: (required) An object containing the attribute key-value pairs.
- `distinctId`: (optional) The distinct ID of the user that other than default user ID.
- Returns a Response that resolves when the attributes are successfully set.

## Contributing
Contributions are welcome! If you find any issues or have suggestions for improvement, please create a pull request.
## License
This code is open source and available under the MIT License.