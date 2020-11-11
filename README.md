# Jay Fm

JayFm Flutter application. Jay fm is a podcast delivery service currently available at https://www.jayfm.co/. This project contains source code of it's mobile implementation using flutter. 

## Getting Started

This project is a starting point for the Jay Fm flutter application.

## How to install
1. Make sure you have the latest Flutter version in the stable channel installed on your device. You can follow https://flutter.dev/docs/get-started/install for instructions how.
2. Set up an emulator or connect a device with debugging turned on to your device.
3. Important! After running `pub get` to install dependencies you have to replace `just_audio` dependency dart file with our edited file for the application to build successfuly.
     * Go to the folder `[YOUR_FLUTTER_INSTALL_LOCATION]/.pub-cache/hosted/pub.dartlang.org/just_audio-0.5.4/lib`
     * Replace the local `just_audio.dart` with the `just_audio.dart` file located at the [google drive link](https://drive.google.com/file/d/1PchtltSdOXL445MS6yXbTDbHt1-7k0VJ/view?usp=sharing).
     * This enables tracking of the currently playing audio source by our application.
5. Run/build the application and test away.


## Contributing
Jay fm flutter is not an open source project and pull requests will only be considered as possible feedback. Feedback is highly appreciated by submission of issues.



