import IOKit.pwr_mgt
import Darwin
import Cocoa
import Cdeps


var buffer = [CChar](repeating: 0, count: 1024)
let lock = "/tmp/prevent-sleep.lock"
let pid = getpid() as Int32
var oldPid: Int32 = 0
do {
  oldPid = Int32(try String(contentsOf: URL(fileURLWithPath: lock), encoding: .utf8)) ?? 0
} catch {
  oldPid = 0
}

Cdeps.proc_pidpath(oldPid, &buffer, UInt32(buffer.count))
let processPath = String(cString: buffer)

if kill(oldPid, 0) == 0 {
  Cdeps.proc_pidpath(pid, &buffer, UInt32(buffer.count))
  let oldProcessPath = String(cString: buffer)
  if oldProcessPath == processPath {
    print("Process(\(oldPid)) exists, exiting ...")
    exit(0);
  } else {
    try String(pid).write(to: URL(fileURLWithPath: lock), atomically: false, encoding: .utf8)
    Cdeps.chmod(lock, 0o777)
  }
} else {
  try String(pid).write(to: URL(fileURLWithPath: lock), atomically: false, encoding: .utf8)
  Cdeps.chmod(lock, 0o777)
}


var reasonForActivity: CFString = "SpringHack macOS sleep preventer" as NSString
var assertionID: IOPMAssertionID = IOPMAssertionID(0)
let success = IOPMAssertionCreateWithName((kIOPMAssertPreventUserIdleDisplaySleep as NSString), IOPMAssertionLevel(kIOPMAssertionLevelOn), reasonForActivity, &assertionID)
if success == kIOReturnSuccess {
  print("Started ...")
}
while true {
  sleep(10000000)
}
