# WebView4Delphi [![Tweet](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/intent/tweet?text=Use%20WebView4Delphi%20to%20embed%20Chromium-based%20browsers%20in%20your%20application&url=https://github.com/salvadordf/WebView4Delphi&via=briskbard&hashtags=WebView4Delphi,delphi,lazarus,fpc)
WebView4Delphi is an open source project created by Salvador Díaz Fau to embed Chromium-based browsers in applications made with [Delphi](https://www.embarcadero.com/products/delphi/starter) or [Lazarus/FPC](https://www.lazarus-ide.org/) for Windows.

WebView4Delphi uses the [Microsoft Edge WebView2 Runtime](https://docs.microsoft.com/en-us/microsoft-edge/webview2/) and [Microsoft.Web.WebView2 NuGet package](https://www.nuget.org/packages/Microsoft.Web.WebView2) to embed a web browser. 

Before you try WebView4Delphi you have to download the Microsoft Edge WebView2 Runtime [from here](https://developer.microsoft.com/en-us/microsoft-edge/webview2/#download-section). If you install the evergreen version of the runtime it will be updated automatically with Windows Update but you can also decompress the fixed version in your computer and configure WebView4Delphi to use it.

WebView4Delphi uses the WebView2Loader.dll file included in the Microsoft.Web.WebView2 NuGet package version 1.0.1054.31. A copy of WebView2Loader.dll can be found in the bin32 and bin64 directories.

All the demos are configured to use the evergreen version of the runtime and the executable is created inside the bin32 and bin64 directories.

## Installation in Delphi
* Download WebView4Delphi. Click on the green "Code" button and then click on "Download ZIP".
* Decompress the ZIP package in your projects directory.
* Run Delphi and open "packages\WebView4Delphi_group.groupproj"
* Select the "Projects -> Build all projects" menu option.
* Right click on "WebView4Delphi_designtime.bpl" in the Projects section and select "Install".

## Installation in Lazarus
* Download WebView4Delphi. Click on the green "Code" button and then click on "Download ZIP".
* Decompress the ZIP package in your projects directory.
* Run Lazarus.
* Select the "Package -> Open Package File (.lpk) ..." menu option and open the "packages\webview4delphi.lpk" file.
* Click the "Compile" button in the package window.
* Click the "Use" button in the package window and select "Install".
* Press the "Yes" button when Lazarus asks if you want to rebuild Lazarus.
* Lazarus will install WebView4Delphi and restart in a few seconds.

WebView4Delphi was developed and tested on Delphi 11.0 and Lazarus 2.2.0RC2/FPC 3.2.2. It should be compatible with Delphi XE3 or newer Delphi version but testing in those versions is still pending. WebView4Delphi includes VCL, FireMonkey (FMX) and Lazarus components.

## Links
* [Developer Forums](https://www.briskbard.com/forum)

## Support
If you find this project useful, please consider making a donation.

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=FTSD2CCGXTD86)

You can also support this project with Patreon.

<a href="https://patreon.com/salvadordf"><img src="https://c5.patreon.com/external/logo/become_a_patron_button.png" alt="Patreon donate button" /></a>

## Attribution
Other projects :
* [CEF4Delphi](https://github.com/salvadordf/CEF4Delphi) 
* [OldCEF4Delphi](https://github.com/salvadordf/OldCEF4Delphi) 
* [Chromium](https://chromium.googlesource.com/chromium/src/)

## Other resources
* [Learn Delphi](https://learndelphi.org/)
* [Essential Pascal by Marco Cantù](https://www.marcocantu.com/epascal/)
* [FreePascal from Square One by Jeff Duntemann](http://www.copperwood.com/pub/FreePascalFromSquareOne.pdf)
* [Pascal and Lazarus Books and Magazines](https://wiki.freepascal.org/Pascal_and_Lazarus_Books_and_Magazines)
* [Lazarus Documentation](https://wiki.freepascal.org/Lazarus_Documentation)
