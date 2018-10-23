all:
	swift build --configuration release --static-swift-stdlib

clean:
	swift package clean

install:
	cp $(shell ls .build/x86_64*/release/prevent-macos-sleep) /usr/local/bin/prevent-sleep
	cp com.springhack.prevent-sleep.plist /Library/LaunchDaemons/com.springhack.prevent-sleep.plist
	chmod 755 /usr/local/bin/prevent-sleep
	chmod 755 /Library/LaunchDaemons/com.springhack.prevent-sleep.plist

uninstall:
	rm /usr/local/bin/prevent-sleep
	rm /Library/LaunchDaemons/com.springhack.prevent-sleep.plist
