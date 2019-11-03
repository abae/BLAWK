{
    "id": "b9ba7177-74aa-4530-bf33-5f7d7a299659",
    "modelName": "GMExtension",
    "mvc": "1.2",
    "name": "window_command_hook",
    "IncludedResources": [
        
    ],
    "androidPermissions": [
        
    ],
    "androidProps": true,
    "androidactivityinject": "",
    "androidclassname": "",
    "androidinject": "",
    "androidmanifestinject": "",
    "androidsourcedir": "",
    "author": "",
    "classname": "",
    "copyToTargets": 113497714299118,
    "date": "2019-22-03 03:11:14",
    "description": "",
    "exportToGame": true,
    "extensionName": "",
    "files": [
        {
            "id": "b6415454-05b6-4109-b985-b3bc17365c60",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                
            ],
            "copyToTargets": 113497714299118,
            "filename": "window_command_hook.dll",
            "final": "window_command_cleanup",
            "functions": [
                {
                    "id": "407f8726-6708-4758-a81f-cf7faf09e054",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        1,
                        2,
                        2
                    ],
                    "externalName": "window_command_run_raw",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "window_command_run_raw",
                    "returnType": 2
                },
                {
                    "id": "bc932739-ab2f-41ee-ad28-4298a4818e62",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "window_command_cleanup",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "window_command_cleanup",
                    "returnType": 2
                },
                {
                    "id": "517fc32b-20f3-45c2-abf8-f493053a015a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "window_command_init_raw",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "window_command_init_raw",
                    "returnType": 2
                },
                {
                    "id": "9903ae67-3ae3-4093-96a6-abcc531851ad",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "window_command_bind_raw",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "window_command_bind_raw",
                    "returnType": 2
                },
                {
                    "id": "b6d33cc3-62f5-448f-8396-57eaa12c4abb",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "window_command_hook_raw",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "window_command_hook_raw",
                    "returnType": 2
                },
                {
                    "id": "906399f5-880c-4c86-a23a-42859d863fe2",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "window_command_unhook_raw",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "window_command_unhook_raw",
                    "returnType": 2
                },
                {
                    "id": "ec042644-f8c6-4a89-9d91-25ac085162e2",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "window_command_get_active_raw",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "window_command_get_active_raw",
                    "returnType": 2
                },
                {
                    "id": "04be260d-5a5d-41f1-bc26-825bf3502624",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 3,
                    "args": [
                        1,
                        2,
                        2
                    ],
                    "externalName": "window_command_set_active_raw",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "window_command_set_active_raw",
                    "returnType": 2
                },
                {
                    "id": "deec71be-8eb2-4ab1-a6ee-fb673b852721",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "window_command_check",
                    "help": "window_command_check(button) : Returns whether the given button was pressed since the last call to this function.",
                    "hidden": false,
                    "kind": 1,
                    "name": "window_command_check",
                    "returnType": 2
                },
                {
                    "id": "caab6474-ec36-4f4a-a7f0-82817537b296",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "window_set_topmost_raw",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "window_set_topmost_raw",
                    "returnType": 2
                },
                {
                    "id": "01737236-6565-4f84-9239-be34d61ccbdb",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "window_get_background_redraw",
                    "help": "window_get_background_redraw()",
                    "hidden": false,
                    "kind": 1,
                    "name": "window_get_background_redraw",
                    "returnType": 2
                },
                {
                    "id": "cb57720c-d5ae-465c-8cca-8a925dbbc34e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "window_set_background_redraw_raw",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "window_set_background_redraw_raw",
                    "returnType": 2
                },
                {
                    "id": "df8faa2d-2a5d-4035-b142-4c861d39f719",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "window_set_taskbar_button_raw",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "window_set_taskbar_button_raw",
                    "returnType": 2
                },
                {
                    "id": "35b446b9-247c-4b16-bc4c-a288bb340dcf",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        1
                    ],
                    "externalName": "window_get_taskbar_button_visible_raw",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "window_get_taskbar_button_visible_raw",
                    "returnType": 2
                },
                {
                    "id": "df06fcc3-4507-4010-98c4-122d9cc2a061",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        1,
                        2
                    ],
                    "externalName": "window_set_taskbar_button_visible_raw",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "window_set_taskbar_button_visible_raw",
                    "returnType": 2
                }
            ],
            "init": "",
            "kind": 1,
            "order": [
                
            ],
            "origname": "extensions\\window_command_hook.dll",
            "uncompress": false
        },
        {
            "id": "1a413e2f-ba2c-47c3-92ab-d89d6984f43b",
            "modelName": "GMExtensionFile",
            "mvc": "1.0",
            "ProxyFiles": [
                
            ],
            "constants": [
                {
                    "id": "d4d10505-d44e-464e-9195-f72b1e887d74",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "window_command_close",
                    "hidden": false,
                    "value": "$F060"
                },
                {
                    "id": "130762a0-63fa-4beb-bdbf-a86c644b251d",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "window_command_maximize",
                    "hidden": false,
                    "value": "$F030"
                },
                {
                    "id": "d1088dee-1216-4789-b4fc-eab35bf920ba",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "window_command_minimize",
                    "hidden": false,
                    "value": "$F020"
                },
                {
                    "id": "1f91017a-e590-4995-bb1f-e7af88012ead",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "window_command_restore",
                    "hidden": false,
                    "value": "$F120"
                },
                {
                    "id": "e28d0ad1-24d4-49ed-b395-465f2ffee8c1",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "window_command_resize",
                    "hidden": false,
                    "value": "$F000"
                },
                {
                    "id": "062a26d7-6819-4531-8ff7-e928a697439d",
                    "modelName": "GMExtensionConstant",
                    "mvc": "1.0",
                    "constantName": "window_command_move",
                    "hidden": false,
                    "value": "$F010"
                }
            ],
            "copyToTargets": 9223372036854775807,
            "filename": "window_command_hook.gml",
            "final": "",
            "functions": [
                {
                    "id": "d5803d8f-3d77-43de-ba48-ee092fb30f3c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "window_command_init",
                    "help": "",
                    "hidden": false,
                    "kind": 11,
                    "name": "window_command_init",
                    "returnType": 2
                },
                {
                    "id": "ff0b7518-68c2-4bfe-8c23-e83a3183337c",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "window_command_hook",
                    "help": "window_command_hook(index): Hooks the specified command ",
                    "hidden": false,
                    "kind": 2,
                    "name": "window_command_hook",
                    "returnType": 2
                },
                {
                    "id": "d2343fa6-9eb6-4d5b-8c61-e0a09324b02b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "window_command_unhook",
                    "help": "window_command_unhook(index):",
                    "hidden": false,
                    "kind": 2,
                    "name": "window_command_unhook",
                    "returnType": 2
                },
                {
                    "id": "25b94923-cd9c-436f-905d-af39a6e254a5",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": -1,
                    "args": [
                        
                    ],
                    "externalName": "window_command_run",
                    "help": "window_command_run(index, param = 0):",
                    "hidden": false,
                    "kind": 2,
                    "name": "window_command_run",
                    "returnType": 2
                },
                {
                    "id": "0a76bc9a-054c-43df-a52e-23ab68a5ba92",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "window_command_get_active",
                    "help": "window_command_get_active(command): Returns whether the given command is currently available.",
                    "hidden": false,
                    "kind": 2,
                    "name": "window_command_get_active",
                    "returnType": 2
                },
                {
                    "id": "2d76f2db-1446-44cf-a8d3-0ce5ded322b7",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 2,
                    "args": [
                        2,
                        2
                    ],
                    "externalName": "window_command_set_active",
                    "help": "window_command_set_active(command, status:bool): Enables\/disables the command. Returns -1 if not possible.",
                    "hidden": false,
                    "kind": 2,
                    "name": "window_command_set_active",
                    "returnType": 2
                },
                {
                    "id": "7c06736b-fe0e-43fe-9440-4e83af7df14e",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "window_set_topmost",
                    "help": "window_set_topmost(stayontop:bool): Allows to set a window to show on top of the rest like with GM8.",
                    "hidden": false,
                    "kind": 2,
                    "name": "window_set_topmost",
                    "returnType": 2
                },
                {
                    "id": "1585a898-c4b1-44d7-9c71-e0c5400ef28a",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "window_set_background_redraw",
                    "help": "window_set_background_redraw(redraw_enabled:bool)",
                    "hidden": false,
                    "kind": 2,
                    "name": "window_set_background_redraw",
                    "returnType": 2
                },
                {
                    "id": "55b52850-2579-46dc-9045-1cd87783237b",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "window_set_taskbar_button",
                    "help": "window_set_taskbar_button(enable:bool)",
                    "hidden": false,
                    "kind": 2,
                    "name": "window_set_taskbar_button",
                    "returnType": 2
                },
                {
                    "id": "ae5cbc74-4ddf-49e2-bae7-6eac678d4644",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 1,
                    "args": [
                        2
                    ],
                    "externalName": "window_set_taskbar_button_visible",
                    "help": "window_set_taskbar_button_visible(enable:bool)",
                    "hidden": false,
                    "kind": 2,
                    "name": "window_set_taskbar_button_visible",
                    "returnType": 2
                },
                {
                    "id": "5c0bbf60-3126-41ee-80c7-e65b783aa677",
                    "modelName": "GMExtensionFunction",
                    "mvc": "1.0",
                    "argCount": 0,
                    "args": [
                        
                    ],
                    "externalName": "window_get_taskbar_button_visible",
                    "help": "window_get_taskbar_button_visible()->enabled?",
                    "hidden": false,
                    "kind": 2,
                    "name": "window_get_taskbar_button_visible",
                    "returnType": 2
                }
            ],
            "init": "",
            "kind": 2,
            "order": [
                
            ],
            "origname": "extensions\\gml.gml",
            "uncompress": false
        }
    ],
    "gradleinject": "",
    "helpfile": "",
    "installdir": "",
    "iosProps": true,
    "iosSystemFrameworkEntries": [
        
    ],
    "iosThirdPartyFrameworkEntries": [
        
    ],
    "iosdelegatename": "",
    "iosplistinject": "",
    "license": "Proprietary",
    "maccompilerflags": "",
    "maclinkerflags": "",
    "macsourcedir": "",
    "options": null,
    "optionsFile": "options.json",
    "packageID": "",
    "productID": "ACBD3CFF4E539AD869A0E8E3B4B022DD",
    "sourcedir": "",
    "supportedTargets": 113497714299118,
    "tvosProps": false,
    "tvosSystemFrameworkEntries": [
        
    ],
    "tvosThirdPartyFrameworkEntries": [
        
    ],
    "tvosclassname": "",
    "tvosdelegatename": "",
    "tvosmaccompilerflags": "",
    "tvosmaclinkerflags": "",
    "tvosplistinject": "",
    "version": "1.0.0"
}