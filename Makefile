all: clean build

clean:
	@rm -f stub-unaligned.apk stub.apk stub.apk.idsig

build:
	@aapt package -M data/AndroidManifest.xml -I $$ANDROID_SDK_ROOT/platforms/android-37.2/android.jar -F stub-unaligned.apk --min-sdk-version 28 --target-sdk-version 37
	@zipalign 4 stub-unaligned.apk stub.apk
	@rm -f stub-unaligned.apk
	@apksigner sign --cert data/cert.pem --key data/cert.pk8 stub.apk
	@rm -f stub.apk.idsig
	@echo "\nDone!\n"
