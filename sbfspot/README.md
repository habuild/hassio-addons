# Community Hass.io Add-ons: SBFspot

![project-stage-shield] ![Project Maintenance][maintenance-shield]

[project-stage-shield]: https://img.shields.io/badge/project%20stage-experimental-yellow.svg
[maintenance-shield]: https://img.shields.io/maintenance/yes/2022.svg

![Version](https://img.shields.io/badge/dynamic/json?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fhabuild%2Fsbfspot_addon%2Fmaster%2Fsbfspot%2Fconfig.json)
![Arch](https://img.shields.io/badge/dynamic/json?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Fhabuild%2Fsbfspot_addon%2Fmaster%2Fsbfspot%2Fconfig.json)

This [home assistant](https://www.home-assistant.io/getting-started/) add-on provides the installation, configuration, and integration for the **Bluetooth** version of [SBFspot 3.9.3](https://github.com/habuild/sbfspot_addon/tree/master/sbfspot).

This add-on installs a cron service for SPFspot uploader at 5 minutely daytime interval, [PVoutput](https://pvoutput.org/) account and API are required, it also requires an SQL database like Mariadb. 
It also sends a MQTT message to home assistant, therefore a MQTT broker is required.

# Installation

### Initial database creation.
Download and import either [No Drop DB create](https://github.com/habuild/sbfspot_addon/blob/master/sbfspot/.images/CreateMySQLDB_no_drop.sql) **or** [Create My SQL.sql](https://github.com/SBFspot/SBFspot/blob/master/SBFspot/CreateMySQLDB.sql) in [phpMyAdmin](https://github.com/hassio-addons/addon-phpmyadmin) to create your database. **IF** you haven't already created the database previously, use the NO Drop version. You will also need to add the Database and User/Password to MariaDB and allocate the port.

![screenshot](https://raw.githubusercontent.com/habuild/sbfspot_addon/master/.images/MariaDB%20setup.PNG)

### MQTT 
[sbfspot_sensors.yaml](https://github.com/habuild/sbfspot_addon/blob/master/sbfspot/.images/sbfspot_sensors.yaml) I use packages to include these yaml sensors. You will need to change to match your plant name and serial as you have set in the add-on configuration options. 

**Although** the [configuration options](https://github.com/habuild/sbfspot_addon/blob/master/sbfspot/.images/Example_Config.yaml) list a MQTT host. The MQTT Host, Username, and Password need to be hardcoded into the **MQTT_PublisherArgs:** The **{topic}** and **{{message}}** will be picked up from options. 

**MQTT_PublisherArgs:** **'-h Your_MQTT_Hostname -u Your_MQTT_Username -P Your_MQTT_password -t {topic} -m "{{message}}" -d -r'**

**-d** is for MQTT debug in log. 

**-r** is to retain messages.


### Example Configuration Options.
can be copy/pasted as [Example Config](https://github.com/habuild/sbfspot_addon/blob/master/sbfspot/.images/Example_Config.yaml) or entered via UI 
![Example Options](https://raw.githubusercontent.com/habuild/sbfspot_addon/master/.images/Example_config_png.PNG) 

### Data paths 
In docker the /data/ path arrives at /usr/share/hassio/addons/data/slug#_sbfspot on the host. 
### Upload logs
TODO Need to grep? or bashio the upload log file back into HA log. The log file here may need to be cleaned up manually.

### **Link to SBFspot Documentation**
Refer to the [Wiki](https://github.com/SBFspot/SBFspot/wiki) for documentation and FAQ.

### **Special thanks to:**
* LauR3y/hassio-addons which this version is cleaned up from.
* The SBFspot team for SPFspot.


![Supports aarch64 Architecture][aarch64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
