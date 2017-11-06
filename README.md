# Xcone

## Description

With this repo you could find your way to differentiate your Xcode versions on your mac.

## Usage 

### using SPM

```bash
$ xcone --application Xcode --xcode-version 9.0
```

### using  [Mint](https://github.com/yonaskolb/mint)
```bash
$ mint run StevenWatremez/Xcone "xcone --application Xcode --xcode-version 9.0"
```

## Installing

### using SPM

```bash
$ git clone https://github.com/StevenWatremez/Xcone.git
$ cd Xcone
$ swift build -c release -Xswiftc -static-stdlib
$ cp -f .build/release/Xcone /usr/local/bin/xcone
```

### using  [Mint](https://github.com/yonaskolb/mint)
```bash
$ mint install StevenWatremez/Xcone
# OR
$ mint run StevenWatremez/Xcone
```


## TODO

[] - Manage Resources folder