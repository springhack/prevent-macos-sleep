SRC = *.swift

all:
	mkdir -p build
	swiftc $(SRC) -o ./build/prevent-macos-sleep
