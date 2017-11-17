#!/usr/bin/env bash

bluetoothKernalExtension="com.apple.iokit.BroadcomBluetoothHostControllerUSBTransport"

function restartBluetooth() {
  sudo kextunload -q -b ${bluetoothKernalExtension}
  sudo kextload -b ${bluetoothKernalExtension}
}

restartBluetooth

