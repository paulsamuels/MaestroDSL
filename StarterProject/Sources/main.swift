import MaestroDSL

try! maestroRun("com.apple.MobileAddressBook") {
    LaunchApp("com.apple.MobileAddressBook")
    
    HomePage {
        $0.tapAdd()
        
        EditFormPage {
            $0.setFirstName("John")
            $0.setLastName("Appleseed")
            $0.tapDone()
        }
    }
}
