# Community Hass.io Add-ons: SBFspot

![project-stage-shield] ![Project Maintenance][maintenance-shield]

[project-stage-shield]: https://img.shields.io/badge/project%20stage-experimental-yellow.svg
[maintenance-shield]: https://img.shields.io/maintenance/yes/2022.svg

![Version](https://img.shields.io/badge/dynamic/json?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fhabuild%2Fhassio-addons%2Fmaster%2Fsbfspot%2Fconfig.json)
![Arch](https://img.shields.io/badge/dynamic/json?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Fhabuild%2Fhassio-addons%2Fmaster%2Fsbfspot%2Fconfig.json)

This [home assistant](https://www.home-assistant.io/getting-started/) add-on provides the installation, configuration, and integration for the **Bluetooth** version of [SBFspot 3.9.4](https://github.com/SBFspot/SBFspot/releases/latest). This version is for the OS installation method of Home assistant.

This add-on installs a cron service for SPFspot uploader at 5 minutely daytime interval, [PVoutput](https://pvoutput.org/) account and API are required, it also requires an SQL database like Mariadb. 
It also sends a MQTT message to home assistant, therefore a MQTT broker is required.

# Installation

### Initial database creation.
Download and import either [No Drop DB create](https://github.com/habuild/hassio-addons/blob/main/.images/CreateMySQLDB_no_drop.sql) **or** [Create My SQL.sql](https://github.com/SBFspot/SBFspot/blob/master/SBFspot/CreateMySQLDB.sql) in [phpMyAdmin](https://github.com/hassio-addons/addon-phpmyadmin) to create your database. **IF** you haven't already created the database previously, use the NO Drop version. You will also need to add the Database and User/Password to MariaDB and allocate the port.

![screenshot](https://raw.githubusercontent.com/habuild/hassio-addons/main/.images/MariaDB%20setup.PNG)

### MQTT 
[sbfspot_sensors.yaml](https://github.com/habuild/hassio-addons/blob/main/.images/sbfspot_sensors.yaml) I use packages to include these yaml sensors. You will need to change to match your plant name and serial as you have set in the add-on configuration options. 

**MQTT arument options** [configuration options](https://github.com/habuild/hassio-addons/blob/main/.images/Example_Config.yaml) The MQTT Username, and Password need to be hardcoded into the **MQTT_PublisherArgs:** The **{host}** **{topic}** and **{{message}}** will be picked up from options. 

**MQTT_PublisherArgs:** **'-h {host} -u Your_MQTT_Username -P Your_MQTT_password -t {topic} -m "{{message}}" -d -r'**

**-d** is for MQTT debug in log. This is helpful for confirming the MQTT messages are actually being sent.

**-r** is to retain messages. retain is not advised.

### Find your Local BT device address with Bluetoothctl
You can use the **bluetoothctl** command from the console(terminal or ssh addon) in homeassistant. This will list your controller mac address so you can add it to SBFspot addon config. You can also do this via portainer and connecting to this addon directly.

### Example Configuration Options.
can be copy/pasted as [Example Config](https://github.com/habuild/hassio-addons/blob/main/.images/Example_Config.yaml) or entered via UI 
![Example Options](https://raw.githubusercontent.com/habuild/hassio-addons/main/.images/Example_config_png.PNG) 

### Data paths 
In HAOS (home assistant operating system) the /data/ path arrives at /mnt/data/supervisor/addons/data/{slug}_haos-sbfspot on the host.

### Upload logs
Logs delete after 3 days now. You would need SSH with Root host access to find them anyway.

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
