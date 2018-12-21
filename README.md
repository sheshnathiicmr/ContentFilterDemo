# ContentFilterDemoApp-iOS
A simple example of Network-Extension(content-filter) iOS app using swift. 

## Disclaimer
This demo app's purpose is to demonstrate the bare minimum required to block network request for webkit and socket except this app. **This is not a production ready code!** In order to have a production  you will need to push this app through MDM server and grant content filtering permission by MDM server
 

## Requirements
1. Xcode 10.0 or newer
2. Actual iPhone/Ipad
2. Apple developer account


## Setup instructions
1. Allow network extension capability and same app group for host app and extension app for refrence see project and it's target capability center
   


## Run instructions
1. Run the app on device and allow permission for network monitoring.
2. Open safari or any other browser/apps and browse any site, you will see it's restrcited by "ContentFilterDemoApp"




## References:
* https://developer.apple.com/documentation/networkextension
* https://www.appcaretaker.com/2018/12/21/ios-on-device-network-content-filtering-systemnetwork-extension/

