<!-- https://developers.home-assistant.io/docs/add-ons/presentation#keeping-a-changelog -->
## ![Version](https://img.shields.io/badge/dynamic/json?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fhabuild%2Fhassio-addons%2Fmain%2Ftest-sbfspot%2Fconfig.json)
- This is a test version and will change without warning.
- as above, you have been warned
- added services:need for mariadb

## ![Release][release-shield-2022-3-5]
[release-shield-2022-3-5]: https://img.shields.io/badge/version-2022.3.5-blue.svg
- Add cronjob to update sensors if restart occurs.
- SBFspot version 3.9.5 was released.

## ![Release][release-shield-2022-3-4]
[release-shield-2022-3-4]: https://img.shields.io/badge/version-2022.3.4-blue.svg
- Better log handling for latest file.
- Set removal of old logs at 3 days.

## ![Release][release-shield-2022-3-3]
[release-shield-2022-3-3]: https://img.shields.io/badge/version-2022.3.3-blue.svg
- Upload logging moved to HA logging window.
    - needs default /data/sbfspot/log directory.
- SBFspot version 3.9.3

## ![Release][release-shield-2022-3-2]
[release-shield-2022-3-2]: https://img.shields.io/badge/version-2022.3.2-blue.svg
- bug chasing
- SBFspot version 3.9.3


## ![Release][release-shield] 

[release-shield]: https://img.shields.io/badge/version-2022.3.1-blue.svg

- SBFspot version 3.9.3
- Initial release
- Rebuilt to multi stage docker containter.
    - This saves ~450MB on the final image.
- Is using base HA alpine container and s6 Overlay, so should be fully compatible with HAOS.
- Doesn't require complicated USER setups. 

- I'm no programmer, so apologies if I break something along the way  


