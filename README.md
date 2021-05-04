# ztexts

a simple tool for fetching texts and consuming them. 

The original purpose is to simplify the process of importing texts and their localizations into Flutter apps from translation repository solutions such as Applanga.

## Installation
For now use the unpublished package [approach](https://flutter.dev/docs/development/packages-and-plugins/using-packages#dependencies-on-unpublished-packages) as described below.

```yaml
dev_dependencies:
  
  ztexts:
    git:
      url: https://github.com/zaraz-digital/ztexts.git
```

Later the package will be published to [pub.dev](https://pub.dev/).

NOTE: in order to use for applying the texts in the Flutter app, add this to your pubspec.yaml as well:
```yaml
dependencies:
  flutter_localizations:
    sdk: flutter
```

## Usage

As the original purpose of this library is to simplify management of localizations in Flutter app, its current main use-case is:
* having your texts and translations in [Applanga](https://www.applanga.com/)
* easily importing them into your Flutter app
* having these texts converted into Flutter friendly format (using i18n format)

The below command does exactly these 3 points.
```terminal
flutter pub run ztexts:apply --from=applanga --to=apptexts --config=ztexts.yaml
```

Options:

Option | Description
------------- | -------------
from  | Mandatory. Identifies the source of texts. Currently supported values are: [applanga]
to  | Mandatory. Identifies the destination of texts. Currently supported values are: [apptexts, log]
config  | Optional, defaults to 'pubspec.yaml'. Path of yaml file containing the library configuration

As described above, there are 2 possible values accepted in the 'to' option:
* apptexts - will import the texts into the app using i18n format. See details below
* log - will simply print the texts to the console. Useful while testing and debugging

The file which path is passed under the 'config' option should contain the configuration of source and destination of texts.

For the above example command it could look like this:
```yaml
ztexts:
  applanga:
    appId: YOUR_APP_ID_HERE
    apiToken: YOUR_API_TOKEN_HERE
  apptexts:
    outputPath: assets/strings
```
For details on how to get your Applanga appId and apiToken please check [Applanga API](https://www.applanga.com/docs/integration-documentation/api).

Using the above configuration and running the above command in the root of your Flutter project would allow you to use your Applanga texts as below:
```dart
      appBar: AppBar(
        // welcome - is a text id from Applanga
        title: Text(S.of(context).welcome),
      )
```
This usage would also require you to add these properties in your application widget:
* localizationsDelegates
* supportedLocales

as shown below

```dart
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        S.delegate, // Add delegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      ...
```

## Next
Shortlist of next planned activities:
* Adding tests
* Updating README.md with architecture, enriched info on usage and options
* Updating CHANGELOG.md preparing for first [pub.dev](https://pub.dev/) publish 
* Looking into CI
* Looking into other potential use-cases where this library could help

## Contributing
Pull requests are always welcome.

## License
[BSD-3-Clause](https://opensource.org/licenses/BSD-3-Clause)