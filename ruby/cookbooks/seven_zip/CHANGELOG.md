seven_zip Cookbook CHANGELOG
========================
This file is used to list changes made in each version of the seven_zip cookbook.

v2.0.0
------
- [Upgrade to 7-Zip 15.14](https://github.com/daptiv/seven_zip/pull/9).
- [7-Zip now installed to the default MSI location by default](https://github.com/daptiv/seven_zip/pull/11).
- [7z.exe is located using the Windows registry unless the home attribute is explicitly set](https://github.com/daptiv/seven_zip/pull/10).
- [7-Zip is only added to the Windows PATH if the syspath attribute is set](https://github.com/daptiv/seven_zip/pull/11).
- [Installation idempotence check was fixed](https://github.com/daptiv/seven_zip/pull/14), package name was corrected.
- [TravisCI build added](https://github.com/daptiv/seven_zip/pull/12).
- [ServerSpec tests added](https://github.com/daptiv/seven_zip/pull/9)
- [Document Archive LRWP](https://github.com/daptiv/seven_zip/pull/6)

v1.0.2
------
- [COOK-3476 - Upgrade to 7-zip 9.22](https://tickets.opscode.com/browse/COOK-3476)

1.0.0
-----
- initial release
