# SBFspot addon for HAOS

![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fhabuild%2Fhassio-addons%2Fmain%2Fsbfspot%2Fconfig.yaml)
![Project Stage](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Project%20Stage&query=%24.stage&url=https%3A%2F%2Fraw.githubusercontent.com%2Fhabuild%2Fhassio-addons%2Fmain%2Fhaos-sbfspot%2Fconfig.yaml)
![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Fhabuild%2Fhassio-addons%2Fmain%2Fsbfspot%2Fconfig.yaml)
![Project Maintenance][maintenance-shield] [![CI](https://github.com/habuild/hassio-addons/actions/workflows/addon-ci.yaml/badge.svg)](https://github.com/habuild/hassio-addons/actions/workflows/addon-ci.yaml)

[project-stage-shield]: https://img.shields.io/badge/project%20stage-experimental-yellow.svg
[maintenance-shield]: https://img.shields.io/maintenance/yes/2022.svg

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fhabuild%2Fhassio-addons)

This [home assistant](https://www.home-assistant.io/getting-started/) add-on provides a wrapper for the **Bluetooth** version of [SBFspot 3.9.5](https://github.com/SBFspot/SBFspot/releases/latest).

This add-on runs a crontab service for SBFspot and SPFspotUploader at 5 minutely daytime interval.

[PVoutput](https://pvoutput.org/) account and API are required to use the upload feature.

[Mariadb addon](https://github.com/home-assistant/addons/tree/master/mariadb) or similiar SQL database, is needed to store the data for upload to PVOutput.

[phpMyAdmin](https://github.com/hassio-addons/addon-phpmyadmin) is required to create the DB structure.

[MQTT broker](https://github.com/home-assistant/addons/tree/master/mosquitto) is needed to send MQTT messages to home Assistant.

## Installation

### Initial database creation.

Download and import either [No Drop DB create](https://github.com/habuild/hassio-addons/blob/main/.images/CreateMySQLDB_no_drop.sql) **or** [Create My SQL.sql](https://github.com/SBFspot/SBFspot/blob/master/SBFspot/CreateMySQLDB.sql) in [phpMyAdmin](https://github.com/hassio-addons/addon-phpmyadmin) to create your database. **IF** you haven't already created the database previously, use the NO Drop version. You will also need to add the Database and User/Password to MariaDB and allocate the port.

![screenshot](https://raw.githubusercontent.com/habuild/hassio-addons/main/.images/MariaDB%20setup.PNG)

### MQTT

[haos-sbfspot_sensors.yaml](https://github.com/habuild/hassio-addons/blob/main/.images/sbfspot_sensors.yaml) I use packages to include these yaml sensors. You will need to change to match your plant name and serial as you have set in the add-on configuration options.

**MQTT options argument** [configuration options](https://github.com/habuild/hassio-addons/blob/main/.images/Example_Config.yaml). The MQTT Username, and Password need to be hardcoded into the **MQTT_PublisherArgs:** The **{host}** **{topic}** and **{{message}}** will be picked up from options.

**MQTT_PublisherArgs:** **'-h {host} -u Your_MQTT_Username -P Your_MQTT_password -t {topic} -m "{{message}}" -d -r'**

**-d** is for MQTT debug in log. Which is helpful for confirming the MQTT messages are actually being sent.

**-r** is to retain messages. it is advised against using retain flag

### Example Configuration Options.

can be copy/pasted as [Example Config](https://github.com/habuild/hassio-addons/blob/main/haos-sbfspot/.images/Example_Config.yaml) or entered via UI
![Example Options](https://raw.githubusercontent.com/habuild/hassio-addons/main/.images/Example_config_png.PNG)

### Data paths

In HAOS (home assistant operating system) the /data/ path arrives at /mnt/data/supervisor/addons/data/{slug}\_haos-sbfspot on the host.

### Upload logs

Logs delete after 3 days now. You would need SSH with Root host access to find them anyway.

### **Link to haos-sbfspot Documentation**

Refer to the [SBFspot Wiki](https://github.com/sbfspot/sbfspot/wiki) for documentation and FAQ about SBFspot.

### **Special thanks to:**

- LauR3y/hassio-addons-addons which this version is cleaned up from.
- The sbfspot team for SPFspot.

![Supports aarch64 Architecture][aarch64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
