# LemuQR

LemuQR is an app to **store and create QR codes** and other types of 2D codes. 
We can find a relatively large number of apps dealing with QR codes, but the goal of this app is slightly different.
The intention is to create a "wallet" specifically for storing codes that we want to have easy access to. 
So users can have a QR codes with their contact information, payment information or perhaps a train ticket always ready on their phone or wrist. 

## Supported platforms 
- iOS
- iPadOS
- macOS (via Catalyst)
- watchOS
- Homescreen widget

## Features
- Displaying and managing existing codes in the app
- Displaying codes on Apple Watch
- Displaying a code on a homescreen widget
- Creating codes manually by entering text
- Creating codes from camera/gallery
- Setting colors and icons for codes
- Synchronization via iCloud

## Implementation

### Architecture
The app is built using **SwiftUI** with a standard MVVM architecture. 

### Persistance
The persitance layer is handled by **CoreData**. There is only one model, `QRCode`, which stores all the required details. 
CoreData is set up with **CloudKit** as well, to keep everything in sync across all devices. 
We're also using an App Group container, so the data is accessible by the widget.

### Views

We're using a common Master-Detail View pattern, where there is a list of items in the Master view and more information in the Detail view. 
The Master view allows the user to view the list of QR codes and reorder or delete them. 
The Detail view shows the QR code itself and has an option to edit it. 
For editing or creating a new QR code, we're using `EditItemView` which handles both cases. 

### QR code handling

QR Codes are rendered using the [RSBarcodes](https://github.com/yeahdongcn/RSBarcodes_Swift) library. 
This cannot be done on watchOS, so when the code is created on the phone, the data is saved in the database.

To scan the QR codes from images I used the library [CodeScanner](https://github.com/twostraws/CodeScanner), which makes the process quite convinient.

### WatchOS

The watchOS app consists of two targets, the WatchKit App and the WatchKit Extension.
However the WatchKit App is mainly for legacy reasons and does not contain any code. 
The extension is also using SwiftUI and the code is for the most part directly ported from the main app. 
The UI is simplified to only display the codes, since editing is not practical due to technical and UI/UX limitations.

**Note:** A real device is needed for testing, since CloudKit is not supported on an emulator.

### Widget

The widget is powered by two extensions, the widget extension itself and the intents extension. 
The intents extension is used to provide configuration to the widget, specifically to select which QR code should be displayed at the moment. 
We have a custom configuration of the intent, with a custom data type called `QROptionType`. 
For this type we have a provider in `IntentHandler`, which fetches the entries from CoreData.
The widget itself consists of a provider, which returns an instance of the model `LemuQREntry` based on the current configuration. 
Then there is a simple view, which displays the image data from the model, and the main class `LemuQR_Widget` which initializes everything. 
