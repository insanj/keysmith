//
//  AppDelegate.swift
//  keysmith
//
//  Created by Julian Weiss on 8/28/20.
//  Copyright © 2020 Julian Weiss. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var keysmithStatusItem: NSStatusItem?
    var menu: NSMenu?
        
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        keysmithStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        keysmithStatusItem?.button?.title = "🔐"
        
        menu = NSMenu()
        menu?.delegate = self
        keysmithStatusItem?.menu = menu
        
        let titleMenuItem = NSMenuItem(title: "🔐 keysmith v0.1.1", action: nil, keyEquivalent: "")
        titleMenuItem.isEnabled = false
        menu?.addItem(titleMenuItem)
        
        menu?.addItem(NSMenuItem.separator())
            
        let openMenuItem = NSMenuItem()
        openMenuItem.title = "Open 1Password"
        openMenuItem.action = #selector(readOnePasswordMetadataFolder)
        openMenuItem.target = self
        menu?.addItem(openMenuItem)
        
        menu?.addItem(NSMenuItem.separator())
            
        let tutorialMenuItem = NSMenuItem(title: "Make sure to grant permission\nfor keysmith in System Preferences > Security > Accessibility AND Automation.", action: nil, keyEquivalent: "")
        tutorialMenuItem.isEnabled = false
        menu?.addItem(tutorialMenuItem)
        
        menu?.addItem(NSMenuItem.separator())

        let quitMenuItem = NSMenuItem()
        quitMenuItem.title = "Quit"
        quitMenuItem.action = #selector(quitKeysmith(_:))
        quitMenuItem.target = self
        menu?.addItem(quitMenuItem)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    // ux
    @objc func quitKeysmith(_ sender: Any) -> Bool {
        NSApplication.shared.terminate(self)
        return true
    }
    
//    let OnePasswordPathComponents = ["Library", "Containers", "com.agilebits.onepassword7", "Data", "Library", "Caches", "Metadata", "1Password"];
//
//    let OpenOnePassworldScriptPath = "OpenOnePassword.scpt"
    
    @objc func readOnePasswordMetadataFolder() -> Bool {
//        let fileManager = FileManager.default
//
//        guard let userUrl = fileManager.urls(for: .userDirectory, in: .allDomainsMask).first else {
//            return false
//        }
//
//        guard let desktopUrl = fileManager.urls(for: .desktopDirectory, in: .allDomainsMask).first else {
//            return false
//        }
//
//        guard desktopUrl.pathComponents.count > 2 else {
//            return false
//        }
//
//        let username = desktopUrl.pathComponents[2]
//        var url = userUrl.appendingPathComponent(username)
//
//        for component in OnePasswordPathComponents {
//            url = url.appendingPathComponent(component)
//        }
//
//        print(url)
//        var isDirectory: ObjCBool = false
//        let fileExists = FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory)
//
//        if fileExists && isDirectory.boolValue {
//            print("YES")
//        } else {
//            print("NO")
//        }
                 
        
        
//        let task = Process()
//        task.launchPath = "/usr/bin/osascript"
//
//        let scriptPath = fileManager.homeDirectoryForCurrentUser.deletingLastPathComponent().appendingPathComponent(OpenOnePassworldScriptPath).absoluteString
//        task.arguments = [ scriptPath ]
//        task.launch()
        
      
        
//        let task = Process()
//        task.launchPath = "/usr/bin/env"
//        task.arguments = ["open /Applications/1Password 7.app"]
//        task.launch()
//        task.waitUntilExit()
        

        guard let url = URL(string: "onepassword7://view/") else {
            return false
        }
              
        NSWorkspace.shared.open(url)
        
        let myAppleScript = """
        tell application "1Password 7"  to reopen
        tell application "1Password 7"  to activate
        tell application "System Events" to keystroke "N" using {shift down, command down}
        """
        
        var error: NSDictionary?
        guard let scriptObject = NSAppleScript(source: myAppleScript) else {
            return false
        }

        let _: NSAppleEventDescriptor = scriptObject.executeAndReturnError(&error)
        
        return true
    }
}

extension AppDelegate: NSMenuDelegate, NSMenuItemValidation {
    func validateMenuItem(_ menuItem: NSMenuItem) -> Bool {
        return true
    }
    

}
