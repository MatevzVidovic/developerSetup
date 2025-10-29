




## Managing terminal settings

In terminal settings (ctrl + ,) click on "Open JSON file" at the bottom left corner.
Close the terminal.
Paste stuff into settings.json.
On next opening of terminal, settings will be applied (settings.json changes and properly uses the stuff you pasted in).

(This didn't work for me tho - couldn't find Reload Settings in the command palette)
or, don't close the terminal, paste into settings.json, and then reload with:
(Ctrl+Shift+P) → “Reload Settings” so the bindings take effect

## Reset terminal settings

Go to settings.json.
Close terminal app.
Empty the settings.json file (delete everything in it).
Or delete the file entirely.
On next opening of terminal, settings will be reset to default.




## Features

ctrl shift t opens a new tab with ubuntu profile
ctrl t also, and alt t also.

ctrl + c, alt+v, alt+x do copy, paste, cut
ctrl u deletes the current line
ctrl 1/2/3/... to move to the correct tab.
ctrl 9 to move to the last (rightmost) tab.
ctrl arrowLeft/right to move in tabs
ctrl f to search in the terminal

Alt commands should exist as well for all ctrl commands.
But, I already remap alt + key to ctrl + key using AutoHotkey, so they probably won't be important.


## Reordering profile list

In settings.json, in the "profiles" -> "list" array, reorder the profiles as you want them to appear in the new tab menu.


## Keybinding settings


On the top level of the JSON, put ths like this:
"actions": [
{ "command": { "action": "splitPane", "split": "vertical", "profile": "{guid-2}" }, "keys": "alt+shift+d" }
],

It later gets transformed by the windows terminal as:
"keybindings": [
{ "id": "Terminal.DuplicatePaneAuto", "keys": "alt+shift+d" }
],
etc.





### Settings:

    !!! Change profile name "Ubuntu" to whatever your ubuntu profile is called in your terminal !!!

    !!! Due to autohotkey, many of these alt commands actually get mapped into ctrl + key commands !!!
    !!! So we need their duplicate versions here as well !!!

    "actions": [
        { "keys": "alt+t",         "command": { "action": "newTab", "profile": "Ubuntu 24.04.1 LTS" } },

        { "keys": "alt+c",  "command": { "action": "copy", "singleLine": false } },
        { "keys": "alt+v",  "command": "paste" },
        { "keys": "alt+x",  "command": "cut" },

        { "keys": "alt+u", "command": { "action": "sendInput", "input": "\u0015" } },  // delete line
        { "keys": "alt+f", "command": "find" },
        { "keys": "alt+w", "command": "closeTab" },

        { "keys": "alt+1",  "command": { "action": "switchToTab", "index": 0 } },
        { "keys": "alt+2",  "command": { "action": "switchToTab", "index": 1 } },
        { "keys": "alt+3",  "command": { "action": "switchToTab", "index": 2 } },
        { "keys": "alt+4",  "command": { "action": "switchToTab", "index": 3 } },
        { "keys": "alt+5",  "command": { "action": "switchToTab", "index": 4 } },
        { "keys": "alt+6",  "command": { "action": "switchToTab", "index": 5 } },
        { "keys": "alt+7",  "command": { "action": "switchToTab", "index": 6 } },
        { "keys": "alt+8",  "command": { "action": "switchToTab", "index": 7 } },
        
        { "keys": "alt+9", "command": "lastTab" },

        { "keys": "alt+left",  "command": "prevTab" },
        { "keys": "alt+right", "command": "nextTab" },







        { "keys": "ctrl+t",         "command": { "action": "newTab", "profile": "Ubuntu 24.04.1 LTS" } },

        { "keys": "ctrl+c",  "command": { "action": "copy", "singleLine": false } },
        { "keys": "ctrl+v",  "command": "paste" },
        { "keys": "ctrl+x",  "command": "cut" },

        { "keys": "ctrl+u", "command": { "action": "sendInput", "input": "\u0015" } },
        { "keys": "ctrl+f", "command": "find" },
        { "keys": "ctrl+w", "command": "closeTab" },

        { "keys": "ctrl+1",  "command": { "action": "switchToTab", "index": 0 } },
        { "keys": "ctrl+2",  "command": { "action": "switchToTab", "index": 1 } },
        { "keys": "ctrl+3",  "command": { "action": "switchToTab", "index": 2 } },
        { "keys": "ctrl+4",  "command": { "action": "switchToTab", "index": 3 } },
        { "keys": "ctrl+5",  "command": { "action": "switchToTab", "index": 4 } },
        { "keys": "ctrl+6",  "command": { "action": "switchToTab", "index": 5 } },
        { "keys": "ctrl+7",  "command": { "action": "switchToTab", "index": 6 } },
        { "keys": "ctrl+8",  "command": { "action": "switchToTab", "index": 7 } },

        { "keys": "ctrl+9", "command": "lastTab" },

        { "keys": "ctrl+left",  "command": "prevTab" },
        { "keys": "ctrl+right", "command": "nextTab" },

    ],





















































### Previous Settings:

    !!! Change profile name "Ubuntu" to whatever your ubuntu profile is called in your terminal !!!

    "actions": [
        { "keys": "ctrl+shift+t", "command": { "action": "newTab", "profile": "Ubuntu" } },
        { "keys": "ctrl+t",        "command": { "action": "newTab", "profile": "Ubuntu" } },
        { "keys": "alt+t",         "command": { "action": "newTab", "profile": "Ubuntu" } },

        { "keys": "ctrl+c", "command": { "action": "copy", "singleLine": false } },
        { "keys": "ctrl+v", "command": "paste" },
        { "keys": "ctrl+x", "command": "cut" },
        { "keys": "alt+c",  "command": { "action": "copy", "singleLine": false } },
        { "keys": "alt+v",  "command": "paste" },
        { "keys": "alt+x",  "command": "cut" },

        { "keys": "ctrl+u", "command": { "action": "sendInput", "input": "\u0015" } },
        { "keys": "alt+u",  "command": { "action": "sendInput", "input": "\u0015" } },

        { "keys": "ctrl+1", "command": { "action": "switchToTab", "index": 0 } },
        { "keys": "ctrl+2", "command": { "action": "switchToTab", "index": 1 } },
        { "keys": "ctrl+3", "command": { "action": "switchToTab", "index": 2 } },
        { "keys": "ctrl+4", "command": { "action": "switchToTab", "index": 3 } },
        { "keys": "ctrl+5", "command": { "action": "switchToTab", "index": 4 } },
        { "keys": "ctrl+6", "command": { "action": "switchToTab", "index": 5 } },
        { "keys": "ctrl+7", "command": { "action": "switchToTab", "index": 6 } },
        { "keys": "ctrl+8", "command": { "action": "switchToTab", "index": 7 } },
        { "keys": "ctrl+9", "command": { "action": "switchToTab", "index": 8 } },
        { "keys": "alt+1",  "command": { "action": "switchToTab", "index": 0 } },
        { "keys": "alt+2",  "command": { "action": "switchToTab", "index": 1 } },
        { "keys": "alt+3",  "command": { "action": "switchToTab", "index": 2 } },
        { "keys": "alt+4",  "command": { "action": "switchToTab", "index": 3 } },
        { "keys": "alt+5",  "command": { "action": "switchToTab", "index": 4 } },
        { "keys": "alt+6",  "command": { "action": "switchToTab", "index": 5 } },
        { "keys": "alt+7",  "command": { "action": "switchToTab", "index": 6 } },
        { "keys": "alt+8",  "command": { "action": "switchToTab", "index": 7 } },
        
        { "keys": "alt+9", "command": "lastTab" }

        { "keys": "ctrl+left", "command": "prevTab" },
        { "keys": "ctrl+right", "command": "nextTab" },
        { "keys": "alt+left",  "command": "prevTab" },
        { "keys": "alt+right", "command": "nextTab" },

        { "keys": "ctrl+f", "command": "find" },
        { "keys": "alt+f",  "command": "find" }
    ],

















































## Previous file:

{
    "$help": "https://aka.ms/terminal-documentation",
    "$schema": "https://aka.ms/terminal-profiles-schema",
    "actions": 
    [
        {
            "command": 
            {
                "action": "sendInput",
                "input": "\u0015"
            },
            "id": "User.sendInput.20B5F36E"
        },
        {
            "command": 
            {
                "action": "switchToTab",
                "index": 9
            },
            "id": "User.switchToTab.ED268D78"
        }
    ],
    "copyFormatting": "none",
    "copyOnSelect": false,
    "defaultProfile": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
    "keybindings": 
    [
        {
            "id": "Terminal.OpenNewTab",
            "keys": "ctrl+shift+t"
        },
        {
            "id": "User.sendInput.20B5F36E",
            "keys": "alt+u"
        },
        {
            "id": "Terminal.FindText",
            "keys": "alt+f"
        },
        {
            "id": "Terminal.SwitchToTab0",
            "keys": "alt+1"
        },
        {
            "id": "Terminal.SwitchToTab4",
            "keys": "alt+5"
        },
        {
            "id": "Terminal.SwitchToTab0",
            "keys": "ctrl+1"
        },
        {
            "id": "Terminal.SwitchToTab3",
            "keys": "alt+4"
        },
        {
            "id": "Terminal.SwitchToTab2",
            "keys": "ctrl+3"
        },
        {
            "id": "Terminal.SwitchToTab2",
            "keys": "alt+3"
        },
        {
            "id": "Terminal.PrevTab",
            "keys": "alt+left"
        },
        {
            "id": "Terminal.SwitchToTab1",
            "keys": "alt+2"
        },
        {
            "id": "Terminal.SwitchToTab1",
            "keys": "ctrl+2"
        },
        {
            "id": "Terminal.SwitchToTab3",
            "keys": "ctrl+4"
        },
        {
            "id": "Terminal.SwitchToTab4",
            "keys": "ctrl+5"
        },
        {
            "id": "Terminal.SwitchToTab5",
            "keys": "alt+6"
        },
        {
            "id": "Terminal.SwitchToTab5",
            "keys": "ctrl+6"
        },
        {
            "id": "Terminal.SwitchToTab6",
            "keys": "alt+7"
        },
        {
            "id": "Terminal.SwitchToTab6",
            "keys": "ctrl+7"
        },
        {
            "id": "Terminal.SwitchToTab7",
            "keys": "alt+8"
        },
        {
            "id": "Terminal.SwitchToTab7",
            "keys": "ctrl+8"
        },
        {
            "id": "User.switchToTab.ED268D78",
            "keys": "alt+9"
        },
        {
            "id": "Terminal.NextTab",
            "keys": "ctrl+right"
        },
        {
            "id": "Terminal.CopyToClipboard",
            "keys": "alt+x"
        },
        {
            "id": "User.switchToTab.ED268D78",
            "keys": "ctrl+9"
        },
        {
            "id": "Terminal.NextTab",
            "keys": "alt+right"
        },
        {
            "id": "Terminal.FindText",
            "keys": "ctrl+f"
        },
        {
            "id": "Terminal.PrevTab",
            "keys": "ctrl+left"
        },
        {
            "id": "Terminal.OpenNewTab",
            "keys": "alt+t"
        },
        {
            "id": "Terminal.DuplicateTab",
            "keys": "ctrl+t"
        },
        {
            "id": "Terminal.OpenNewTab",
            "keys": "alt+shift+t"
        },
        {
            "id": "Terminal.CopyToClipboard",
            "keys": "alt+c"
        },
        {
            "id": "Terminal.PasteFromClipboard",
            "keys": "alt+v"
        },
        {
            "id": null,
            "keys": "ctrl+tab"
        },
        {
            "id": null,
            "keys": "ctrl+shift+d"
        },
        {
            "id": "Terminal.CopyToClipboard",
            "keys": "ctrl+c"
        },
        {
            "id": null,
            "keys": "ctrl+shift+tab"
        },
        {
            "id": "Terminal.PasteFromClipboard",
            "keys": "ctrl+v"
        },
        {
            "id": "Terminal.DuplicatePaneAuto",
            "keys": "alt+shift+d"
        }
    ],
    "newTabMenu": 
    [
        {
            "type": "remainingProfiles"
        },
        {
            "type": "separator"
        }
    ],
    "profiles": 
    {
        "defaults": 
        {
            "bellStyle": "none"
        },
        "list": 
        [
            {
                "commandline": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
                "guid": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
                "hidden": false,
                "name": "Windows PowerShell"
            },
            {
                "commandline": "%SystemRoot%\\System32\\cmd.exe",
                "guid": "{0caa0dad-35be-5f56-a8ff-afceeeaa6101}",
                "hidden": false,
                "name": "Command Prompt"
            },
            {
                "guid": "{b453ae62-4e3d-5e58-b989-0a998ec441b8}",
                "hidden": false,
                "name": "Azure Cloud Shell",
                "source": "Windows.Terminal.Azure"
            },
            {
                "guid": "{d8e96812-b789-5068-a5ae-10b2fb53e95f}",
                "hidden": false,
                "name": "Ubuntu 24.04.1 LTS",
                "source": "CanonicalGroupLimited.Ubuntu24.04LTS_79rhkp1fndgsc"
            },
            {
                "guid": "{963ff2f7-6aed-5ce3-9d91-90d99571f53a}",
                "hidden": true,
                "name": "Ubuntu-24.04",
                "source": "Windows.Terminal.Wsl"
            }
        ]
    },
    "schemes": [],
    "themes": [],
    "warning.confirmCloseAllTabs": false
}