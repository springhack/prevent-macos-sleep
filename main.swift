import IOKit.pwr_mgt
import AppKit

let lock = "/tmp/prevent-sleep.lock"
let pid = getpid() as Int32
// let fp = fopen(lock, "w");
// fprintf(fp, "%d\n", pid ?? 0);
// fclose(fp);


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
