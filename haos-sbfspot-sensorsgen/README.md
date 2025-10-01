# Bash scripts for creating Home Assistant MQTT Discovery sensors for SBFspot.

## MQTT_Date Full List

```
PrgVersion,Plantname,Timestamp,SunRise,SunSet,InvSerial,InvName,InvTime,InvStatus,InvSwVer,InvClass,InvType,InvTemperature,InvGridRelay,EToday,ETotal,GridFreq,PACTot,PAC1,PAC2,PAC3,UAC1,UAC2,UAC3,IAC1,IAC2,IAC3,OperTm,FeedTm,PDCTot,PDC1,PDC2,PDC,UDC1,UDC2,UDC,IDC1,IDC2,IDC,BTSignal,BatTmpVal,BatVol,BatAmp,BatChaStt,InvWakeupTm,InvSleepTm,MeteringWOut,MeteringWIn,MeteringWTot
```

## MQTT_Data Typical List

```
PrgVersion,Plantname,Timestamp,SunRise,SunSet,InvSerial,InvName,InvTime,InvStatus,InvSwVer,InvClass,InvType,InvTemperature,InvGridRelay,EToday,ETotal,GridFreq,PACTot,PAC1,UAC1,IAC1,OperTm,FeedTm,PDCTot,UDC1,UDC2,IDC1,IDC2,PDC1,PDC2,BTSignal,InvWakeupTm,InvSleepTm
```

### Typical multi inverter SBFspot MQTT messaging:

```
homeassistant/sbfspot_Your_Plantname/sbfspot_Inverter_Serial
```

When using multiple Inverters MQTT messages are published as follows

Inverter One:

```
Topic: homeassistant/sbfspot_Plantname_Inverter_One/sbfspot_InvSerial

            Message: {Inverter:One, Key1:Value1, Key2:Value2}
```

Inverter two, then publishes it's message to Inverter Ones Topic using Inverter Two data. The same is true for Inverter Three

Inverter Two:

```
Topic: homeassistant/sbfspot_Plantname_Inverter_One/sbfspot_InvSerial_Two

            Message: {Inverter:Two, Key1:Value1, Key2:Value2}
```

### MQTT Discovery requires Unique messages for Devices and entities.

With this addon Sensor Generation should be simplified for Mulit inverter setups.

Enjoy
