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
        
        let titleMenuItem = NSMenuItem(title: "🔐 keysmith v1.0.0", action: nil, keyEquivalent: "")
        titleMenuItem.isEnabled = false
        menu?.addItem(titleMenuItem)
        
        menu?.addItem(NSMenuItem.separator())
            
        let openMenuItem = NSMenuItem()
        openMenuItem.title = "Open 1Password"
        openMenuItem.action = #selector(readOnePasswordMetadataFolder)
        openMenuItem.target = self
        menu?.addItem(openMenuItem)
        
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
    
    @objc func readOnePasswordMetadataFolder() -> Bool {
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
