import IOKit.pwr_mgt
import Darwin
import Cocoa
import Clibproc


var buffer = [CChar](repeating: 0, count: 1024)
let lock = "/tmp/prevent-sleep.lock"
let pid = getpid() as Int32
let oldPid = Int32(try String(contentsOf: URL(fileURLWithPath: lock), encoding: .utf8))

Clibproc.proc_pidpath(pid, &buffer, UInt32(buffer.count))
let processPath = String(cString: buffer)

if kill(oldPid ?? 0, 0) == 0 {
  // Pid exists
  Clibproc.proc_pidpath(pid, &buffer, UInt32(buffer.count))
  let oldProcessPath = String(cString: buffer)
  if oldProcessPath == processPath {
    print("Process(\(oldPid ?? 0)) exists, exiting ...")
    exit(0);
  } else {
    try String(pid).write(to: URL(fileURLWithPath: lock), atomically: false, encoding: .utf8)
  }
} else {
  try String(pid).write(to: URL(fileURLWithPath: lock), atomically: false, encoding: .utf8)
}


var reasonForActivity: CFString = "SpringHack macOS sleep preventer" as NSString
var assertionID: IOPMAssertionID = IOPMAssertionID(0)
let success = IOPMAssertionCreateWithName((kIOPMAssertPreventUserIdleDisplaySleep as NSString), IOPMAssertionLevel(kIOPMAssertionLevelOn), reasonForActivity, &assertionID)
if success == kIOReturnSuccess {
  print("Started ...")
}
while true {
  // Prevent exit
  sleep(10000000)
}
