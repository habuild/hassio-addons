[![Release][release-shield]][release] ![Project Stage][project-stage-shield] ![Project Maintenance][maintenance-shield]

#  Reposistory add-on by Habuild

Add-on documentation: <https://developers.home-assistant.io/docs/add-ons>

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fhabuild%2Fhassio_addons)

## Add-ons

This repository contains the following add-ons

### [SBFspot_HA](./sbfspot)

![Version](https://img.shields.io/badge/dynamic/json?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fhabuild%2Fhassio-addons%2Fmaster%2Fsbfspot%2Fconfig.json)
![Arch](https://img.shields.io/badge/dynamic/json?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Fhabuild%2Fhassio-addons%2Fmaster%2Fsbfspot%2Fconfig.json)

_Example add-on to use as a blueprint for new add-ons._

<!--

Notes to developers after forking or using the github template feature:
- While developing comment out the 'image' key from 'example/config.yaml' to make the supervisor build the addon
  - Remember to put this back when pushing up your changes.
- When you merge to the 'main' branch of your repository a new build will be triggered.
  - Make sure you adjust the 'version' key in 'example/config.yaml' when you do that.
  - Make sure you update 'example/CHANGELOG.md' when you do that.
  - The first time this runs you might need to adjust the image configuration on github container registry to make it public
- Adjust the 'image' key in 'example/config.yaml' so it points to your username instead of 'home-assistant'.
  - This is where the build images will be published to.
- Rename the example directory.
  - The 'slug' key in 'example/config.yaml' should match the directory name.
- Adjust all keys/url's that points to 'home-assistant' to now point to your user/fork.
- Share your repository on the forums https://community.home-assistant.io/c/projects/9
- Do awesome stuff!
 -->



## ![SBFspot Logo](https://user-images.githubusercontent.com/1931158/30831762-006ec650-a249-11e7-86e3-13d01b36dd5d.jpg)

## ToDo List
### Fix
map directories to /addon/??

configure gui to SBFspot.cfg and SBFspotUpload.cfg??



### Configure 
built in MQTT conections??

built in MariaDB ( point to and add database and user in existing addon??


## ToDo end

SBFspot addon for supervised Home Assistant, based an open source project located at github ([SBFspot on github](https://github.com/SBFspot/SBFspot)).
This project creates an addon install for Home assistant users using the latest release of SBFspot as a docker install.

# Installation and configuration
Add ([this respository](https://github.com/HABuild/hassio_addons)) to Home Assistant via the superviser > new respository menu > add respository

Fill in the config details to setup Inverter connection, Database, MQTT , and Upload API.

Start the addon


# Special Thanks To: 
SBFspot
https://github.com/SBFspot/SBFspot

and 
nakla for the dockerfile
https://github.com/nakla/sbfspot 

and
LauR3y for sbfspot addon
https://github.com/LauR3y/hassio-addons

## SBFspot Readme ([SBFspot on github](https://github.com/SBFspot/SBFspot)).
![SBFspot Logo](https://user-images.githubusercontent.com/1931158/30831762-006ec650-a249-11e7-86e3-13d01b36dd5d.jpg)

Translation by Google: [[NL](https://translate.google.com/translate?act=url&depth=1&hl=nl&ie=UTF8&prev=_t&rurl=translate.google.com&sl=en&sp=nmt4&tl=nl&u=https://github.com/SBFspot/SBFspot)] - [[FR](https://translate.google.com/translate?act=url&depth=1&hl=nl&ie=UTF8&prev=_t&rurl=translate.google.com&sl=en&sp=nmt4&tl=fr&u=https://github.com/SBFspot/SBFspot)] - [[DE](https://translate.google.com/translate?act=url&depth=1&hl=nl&ie=UTF8&prev=_t&rurl=translate.google.com&sl=en&sp=nmt4&tl=de&u=https://github.com/SBFspot/SBFspot)] - [[ES](https://translate.google.com/translate?act=url&depth=1&hl=nl&ie=UTF8&prev=_t&rurl=translate.google.com&sl=en&sp=nmt4&tl=es&u=https://github.com/SBFspot/SBFspot)] - [[IT](https://translate.google.com/translate?act=url&depth=1&hl=nl&ie=UTF8&prev=_t&rurl=translate.google.com&sl=en&sp=nmt4&tl=it&u=https://github.com/SBFspot/SBFspot)]
### **Introduction**
SBFspot, formerly known as SMAspot, is an open source project to get actual and archive data out of an SMA® inverter over Bluetooth or Ethernet (Speedwire®) It works on either Linux ([Raspberry Pi](http://www.raspberrypi.org)) and Windows.

### **What it does**
SBFspot connects via Bluetooth or Ethernet to your SMA® solar/battery inverter and reads Archive Day/Month Power generation, user/installer events and the actual (spot) data. The collected data is stored in a SQL database (SQLite/MySQL/MariaDB) or SMA® compatible .csv files.
A separate service/daemon uploads the collected data to [PVoutput.org](https://pvoutput.org)

### **Known bugs and limitations**
For a list of known bugs, consult the [issues](https://github.com/SBFspot/SBFspot/issues). If you find a bug, please create an [issue](https://github.com/SBFspot/SBFspot/issues).

### **Documentation**
Refer to the [Wiki](https://github.com/SBFspot/SBFspot/wiki) for documentation and FAQ.

### **Special thanks to:**
* S. Pittaway: Author of ["NANODE SMA PV MONITOR"](https://github.com/stuartpittaway/nanodesmapvmonitor) on which this project is based.
* W. Simons : Early adopter, main tester and SMAdata2® Protocol analyzer
* G. Schnuff : SMAdata2® Protocol analyzer
* T. Frank: Speedwire® support
* Snowmiss: User manual
* All other users for their contribution - in any form - to the success of this project

### **Donations**
SBFspot is a free tool, developed during personal free time. If you like it, consider a donation.
If you click on the button below, you will be taken to the secure PayPal Web site. You don't need to have a paypal account in order to make a donation.

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=3R5JSRCXBGSLQ)

### **License**
[Attribution - NonCommercial - ShareAlike 3.0 Unported (CC BY-NC-SA 3.0)](https://creativecommons.org/licenses/by-nc-sa/3.0/legalcode)

In short, you are free:
* to Share => to copy, distribute and transmit the work
* to Remix => to adapt the work
Under the following conditions:
* **Attribution:** You must attribute the work in the manner specified by the author or Licensor (but not in any way that suggests that they endorse you or your use of the work).
* **Noncommercial:** You may not use this work for commercial purposes.
* **Share Alike:** If you alter, transform, or build upon this work, you may distribute the resulting work only under the same or similar license to this one.

### **Disclaimer**
A user of SBFspot software acknowledges that he or she is receiving this software on an "as is" basis and the user is not relying on the accuracy or functionality of the software for any purpose. The user further acknowledges that any use of this software will be at his own risk and the copyright owner accepts no responsibility whatsoever arising from the use or application of the software.

SMA, Speedwire are registered trademarks of [SMA Solar Technology AG](http://www.sma.de/en/company/about-sma.html)

[maintenance-shield]: https://img.shields.io/maintenance/yes/2022.svg
[project-stage-shield]: https://img.shields.io/badge/project%20stage-production%20testing-red.svg
[release-shield]: https://img.shields.io/badge/version-2022.repo-blue.svg
[release]: https://github.com/hassio-addons/addon-ssh/tree/2022.repo
