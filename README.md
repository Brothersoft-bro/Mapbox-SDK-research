# Mapbox-SDK-research

We reviewed the mapping SDK’s available for mobile developers. The idea behind this repository was to share our findings related to the Mapbox SDK research we did for the iOS platform. 
In a very limited time we were able to integrate the Mapbox SDK with map display, map style switch, route calculation & navigation from your current to your destination location.

## Requirements

- iOS 13.0+
- Xcode 11
- Swift 5

## Installation

- Download the POC’s source code
- Use "pod install" in order to install the necessary dependencies via Cocoa Pods (make sure that you have Cocoa Pods installed)
- Go to https://www.mapbox.com/ and register a developer account in order to get your Access Token - it allows you to access the Mapbox APIs
- Add your Mapbox SDK access token into the info.plist file (MGLMapboxAccessToken key)
- Build & Run 

## Features

- Basic Map display with the user's current location
- The ability to switch between different map styles
- Calculate a route between your current location and a destination location selected via long press on the map. Navigation from your current location to the destination location

## Images

<div align="center">
    <img src="/Images/1.png" width="100px"</img> 
    <img src="/Images/2.png" width="100px"</img> 
    <img src="/Images/3.png" width="100px"</img> 
    <img src="/Images/4.png" width="100px"</img> 
    <img src="/Images/5.png" width="100px"</img> 
    <img src="/Images/6.png" width="100px"</img> 
    <img src="/Images/7.png" width="100px"</img> 
</div>
