---

# SBFspot addon for HAOS

![Version](https://img.shields.io/badge/dynamic/yaml?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fhabuild%2Fhassio-addons%2Fmain%2Fhaos-sbfspot%2Fconfig.yaml)
![Project Stage](https://img.shields.io/badge/dynamic/yaml?color=blueviolet&label=Project%20Stage&query=%24.stage&url=https%3A%2F%2Fraw.githubusercontent.com%2Fhabuild%2Fhassio-addons%2Fmain%2Fhaos-sbfspot%2Fconfig.yaml)
![Arch](https://img.shields.io/badge/dynamic/yaml?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Fhabuild%2Fhassio-addons%2Fmain%2Fhaos-sbfspot%2Fconfig.yaml)
![Project Maintenance][maintenance-shield] [![CI](https://github.com/habuild/hassio-addons/actions/workflows/addon-ci.yaml/badge.svg)](https://github.com/habuild/hassio-addons/actions/workflows/addon-ci.yaml)

[project-stage-shield]: https://img.shields.io/badge/project%20stage-experimental-yellow.svg
[maintenance-shield]: https://img.shields.io/maintenance/yes/2023.svg

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fhabuild%2Fhassio-addons)

This [home assistant](https://www.home-assistant.io/getting-started/) add-on provides a wrapper for the **Bluetooth** version of [![SBFspot](https://img.shields.io/badge/dynamic/json?color=blue&label=SBFspot&query=tag_name&suffix=%20latest&url=https%3A%2F%2Fgithub.com%2FSBFspot%2FSBFspot%2Freleases%2Flatest)](https://github.com/SBFspot/SBFspot/releases/latest)

This add-on runs a crontab service for SBFspot and SPFspotUploader at 5 minutely daytime interval.

[PVoutput](https://pvoutput.org/) account and API are required to use the upload feature.

[Mariadb addon](https://my.home-assistant.io/redirect/supervisor_addon/?addon=core_mariadb) or similiar SQL database, is needed to store the data for upload to PVOutput.

[phpMyAdmin](https://my.home-assistant.io/redirect/supervisor_addon/?addon=a0d7b954_phpmyadmin&repository_url=https%3A%2F%2Fgithub.com%2Fhassio-addons%2Faddon-phpmyadmin) is required to create the DB structure.

[MQTT broker](https://my.home-assistant.io/redirect/supervisor_addon/?addon=core_mosquitto) is needed to send MQTT messages to home Assistant.

## Installation

---

### Options and Secrets

If you want to template your options with secrets, the below template can be used.

These names auto default so you shouldn't need to confirm(save) any options on installation

It should all just default when starting the addon.

```
##template for secrets.yaml
## a restart might be required after Saving your secrets file

BTAddress: ""          ## Inverter BT mac
SBFpassword: ""        ## Inverter password
LocalBTAddress: ""     # host BT mac - can be empty
SBFplantname: ""

mariadb_pw: ""
mqtt_user: ""
mqtt_pass: ""

home_lat: ""
home_long: ""
Timezone: ""
                             ### IF YOU WANT TO SKIP PVoutput
pvoSID: "0123456789:12345"   ### will default to fake if left empty
pvoAPIkey: "fake9364fake4545afke834fake"   ### will default to fake if left empty
```

The above options are the only required options if you want to fill out the options manually.

### The rest of the options default to standard HAOS server addresses and SBFspot defaults

<details><summary> OPTIONS Image </summary>
<p>

![screenshot](https://raw.githubusercontent.com/habuild/hassio-addons/main/.images/UIoptions.PNG)

</p>
</details>

<br></br>

### PVoutput SIDs

PVoutput SIDs are a combination of your inverter serial number and your PVoutput Account ID.

PVoutput SIDs can be comma separated entries with Inverter serial and separate PVO account IDs.

```
InverterSerial:AccID

eg. Inverter1:acc1,Inverter2:acc2

0123456789:12345,2222222222:54321
```

### MIS_Enabled Bluetooth Multi Inverter support.

<b>This option is only for Bluetooth multi-inverter systems.</b>

Each inverter first needs to be run through the sensor create setting to enable the MQTT sensors.
Each inverter needs to run through on it's BTAddress.
(You may have to tweak the Plantname and topic slightly)

Once the sensors are created set the Sensor create option back to NO (Disable the sensor creation setting)

You can now enable MIS under the GUI or yaml options configuration.

```
MIS_Enabled: 1
```

The NET ID needs to be greater than 1 on all inverters.

PVoutput SIDs can be comma separated entries with Inverter serial and separate PVO account IDs.

```
eg. Inverter1:acc1,Inverter2:acc2

0123456789:12345,2222222222:54321
```

refer to [Issue 42 for more info](https://github.com/habuild/hassio-addons/issues/42)

<br></br>

## MQTT

### 2022.9.1+

#### Add MQTT mqtt user and password to options.

The other options default automatically if blank.
If you need to change the broker address, you can stil use the options.

#### HA Sensor Generation

<details><summary>MQTT Sensor list</summary>
<p>

Description available in the SBFspot config file.

[MASTER SBFspot CFG](https://raw.githubusercontent.com/SBFspot/SBFspot/master/SBFspot/SBFspot.cfg)

- Default list of Sensors for MQTT_Data

```
PrgVersion,Plantname,Timestamp,SunRise,SunSet,InvSerial,InvName,InvTime,InvStatus,InvSwVer,InvClass,InvType,InvTemperature,EToday,ETotal,GridFreq,PACTot,PAC1,UAC1,IAC1,OperTm,FeedTm,PDCTot,UDC1,UDC2,IDC1,IDC2,PDC1,PDC2,BTSignal
```

- Current available list of sensors

```
PrgVersion,Plantname,Timestamp,SunRise,SunSet,InvSerial,InvName,InvTime,InvStatus,InvSwVer,InvClass,InvType,InvTemperature,InvGridRelay,EToday,ETotal,GridFreq,PACTot,PAC1,PAC2,PAC3,UAC1,UAC2,UAC3,IAC1,IAC2,IAC3,OperTm,FeedTm,PDCTot,PDC1,PDC2,PDC,UDC1,UDC2,UDC,IDC1,IDC2,IDC,BTSignal,BatTmpVal,BatVol,BatAmp,BatChaStt,InvWakeupTm,InvSleepTm,MeteringWOut,MeteringWIn,MeteringWTot

```

</p>
</details>

<details><summary>MQTT Image</summary>
<p>

![screenshot](https://raw.githubusercontent.com/habuild/hassio-addons/main/.images/mqttcap.PNG)

</p>
</details>

It is advised to **backup and/or disable existing yaml sensors** to avoid naming conflicts.

#### Autogen Sensors - No, Create, Purge, options

<details><summary><b>No</b> sensors. HAOS-SBFspot will run without generating sensors. It will use yaml or mqtt sensors. </summary>
<p>

- Use this option if you want to keep your existing yaml energy sensor on the energy dashboard.

  You can make new sensors. You can't convert the new sensors to keep the old energy dash values.

</p>
</details>

<details><summary><b>Create</b> sensors. HAOS-SBFspot will automatically create sensors in the MQTT Integration. </summary>
<p>

[MQTT Integration](https://www.home-assistant.io/integrations/mqtt)

It is advised to **backup and/or disable existing yaml sensors** to avoid naming conflicts.

Updating the new energy sensor to follow the old energy sensor on the energy dashboard is not possible in HA.

    - This option will create topics using your plantname and inverter serial number

       - homeassistant/sensor/sbfspot_{*Your Plantname*}/sbf_spot{*your inv serial*}{*SensorType*}/config

       - homeassistant/sbfspot_{Your Plantname}/sbf_spot{Your Inv Serial} is the state_topic

</p>
</details>

<details><summary><b>Purge</b> sensors. HAOS-SBFspot will send empty topics to your broker address to clear Retained topics. </summary>
<p>

- This will fail if you change topics between creating and purging sensors.
- You can use MQTT explorer or similar MQTT tool to manually remove the topics if this occurs.

</p>
</details>

<details><summary> Earlier versions and yaml mqtt sensors </summary>
<p>

### Prior to 2022.9.1

[haos-sbfspot_sensors.yaml](https://github.com/habuild/hassio-addons/blob/main/.images/sbfspot_sensors.yaml) I use packages to include these yaml sensors. You will need to change to match your plant name and serial as you have set in the add-on configuration options.

**MQTT options argument** [configuration options](https://github.com/habuild/hassio-addons/blob/main/.images/Example_Config.yaml) The MQTT Username, and Password need to be hardcoded into the **MQTT_PublisherArgs:** The **{host}** **{topic}** and **{{message}}** will be picked up from options.

**MQTT_PublisherArgs:** **'-h {host} -u Your_MQTT_Username -P Your_MQTT_password -t {topic} -m "{{message}}" -d -r'**

<i> Publisher arguments has been removed to allow for sensors </i>

**-d** is for MQTT debug in log. Which is helpful for confirming the MQTT messages are actually being sent.

**-r** is to retain messages. it is advised against using retain flag

</p>
</details>
<br></br>

## MariaDB

### Initial database creation.

Download and import either [No Drop DB create](https://github.com/habuild/hassio-addons/blob/main/.images/CreateMySQLDB_no_drop.sql) **or** [Create My SQL.sql](https://github.com/SBFspot/SBFspot/blob/master/SBFspot/CreateMySQLDB.sql) in [phpMyAdmin](https://github.com/hassio-addons/addon-phpmyadmin) to create your database. **IF** you haven't already created the database previously, use the NO Drop version. You will also need to add the Database and User/Password to MariaDB and allocate the port.

![screenshot](https://raw.githubusercontent.com/habuild/hassio-addons/main/.images/MariaDB%20setup.PNG)

<br></br>

## Container Data paths

In HAOS (home assistant operating system) the /data/ path arrives at `/mnt/data/supervisor/addons/data/{slug_haos-sbfspot}` on the host.

In docker/supervisor the /data/ path arrives at `/usr/share/hassio/addons/data/{slug_haos-sbfspot}` on the host.

## **Link to official SBFspot Documentation**

Refer to the [SBFspot Wiki](https://github.com/sbfspot/sbfspot/wiki) for documentation and FAQ about SBFspot.

### **Special thanks to:**

- The sbfspot team for SPFspot.

![Supports aarch64 Architecture][aarch64-shield]
![Supports armhf Architecture][armhf-shield]
![Supports armv7 Architecture][armv7-shield]

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
