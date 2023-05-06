//
//  chick_gameApp.swift
//  chick_game
//
//  Created by kaito on 2023/04/30.
//

import SwiftUI

//前ひよこでゲットされているひよことゲットされていないひよこ
var chicks_that_are_getting_or_not: [String:String] = ["赤ひよこ": "not_get", "青ひよこ": "get", "黄ひよこ": "not_get"]

@main
struct chick_gameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
