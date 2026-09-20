# If you wanna help me

<a href="https://www.buymeacoffee.com/daboynb" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41" width="174"></a>

# Download

**[Get the APK from the Releases page](https://github.com/daboynb/Safetycore-placeholder/releases/latest)** — it is not in the file list above.

# Instructions
1) Uninstall the app from the [Play Store](https://play.google.com/store/apps/details?id=com.google.android.safetycore).
2) Download the APK from the [Releases page](https://github.com/daboynb/Safetycore-placeholder/releases/latest).
3) Install it.

Enjoy!

If Google tries to replace the APK with the updated SafetyCore app, it will fail due to a signature mismatch.

# Troubleshooting

Nearly every issue opened on this repo is the same one, in one of two shapes:

- `App not installed as package conflicts with an existing package` — installing by tapping the APK
- `INSTALL_FAILED_UPDATE_INCOMPATIBLE: Existing package com.google.android.safetycore signatures do not match newer version` — installing via adb

Both mean the real SafetyCore is still registered on your device. Android refuses to replace a
package with one signed by a different key ([AOSP](https://cs.android.com/android/platform/superproject/main/+/main:frameworks/base/core/java/android/content/pm/PackageManager.java):
*"a previously installed package of the same name has a different signature than the new package"*).

## Step 1 — run the triage

```
adb shell "pm list packages -u | grep safetycore"
adb uninstall com.google.android.safetycore
```

Do **not** add `--user 0`. By default `adb uninstall` removes the package for *every* user on the
device, which is what you want — `--user 0` only touches the primary profile and is the reason many
people get stuck.

## Step 2 — read what it answered

**`Success`** → SafetyCore was an ordinary updatable app and is now really gone. Install the placeholder:

```
adb install -r Safetycore-placeholder.apk
```

**`Failure [not installed for 0]`, while step 1 still lists the package** → SafetyCore is preinstalled
in your system partition. Android never actually deletes a system package: it marks it
`installed=false` for the user and keeps the package record *and its original signature* in the
package database ([AOSP `DeletePackageHelper`](https://cs.android.com/android/platform/superproject/main/+/main:frameworks/base/services/core/java/com/android/server/pm/DeletePackageHelper.java)).
Any differently signed APK is rejected from then on. There is no non-root workaround — please do not
open an issue for this.

## Vendor notes

| Device | Extra step |
|---|---|
| Samsung | Also uninstall it inside Knox Secure Folder (Secure Folder → Settings → Apps), and turn off Settings → Security and privacy → **Auto Blocker** |
| Honor / MagicOS, OPPO / ColorOS | Plain `pm uninstall com.google.android.safetycore` works — no root needed. Confirmed on Honor 200 Pro and OPPO Reno13 Pro |
| Any device, no PC | Use [Shizuku](https://shizuku.rikka.app/) + aShell to run the same commands on-device |
| OnePlus | `com.android.safetycenter.styles.overlay` / `.resources.overlay` may block installation. Unresolved — reports welcome |

## Changed your mind?

To bring the real SafetyCore back:

```
adb uninstall com.google.android.safetycore
adb shell cmd package install-existing com.google.android.safetycore
```

## VirusTotal flags the APK

Some engines report `Android.Riskware.Repack.*`. This is a false positive: the APK contains no code
at all — just a manifest, see [`app/src/main/AndroidManifest.xml`](app/src/main/AndroidManifest.xml).
Heuristics fire because it declares a Google package name while being signed with a different key,
which is precisely the point of a placeholder. Build it yourself if you prefer.

# Screenshots
<p>
  <img src="https://github.com/user-attachments/assets/d553158a-3f33-40ab-a8ed-543aa15ed7a0" width="200" />
  <img src="https://github.com/user-attachments/assets/468a7d3e-9385-4285-962a-4f0a4bfbaa5e" width="200" />
  <img src="https://github.com/user-attachments/assets/521a8382-2f34-4c31-b2a5-87868da47d7d" width="200" />
</p>

# Changelog :

- v1: Initial release
  
- v2: Increased the version number to 2000000000, causing the Play Store update to become unavailable.

- v3: Removed unnecessary code and reduced the size from 5.4 MB to 35,4 kB. (This release is signed, you need to uninstall the previuos one)

- v2000000000: Fix for Obtainium users.
