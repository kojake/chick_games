//
//  chick_gameApp.swift
//  chick_game
//
//  Created by kaito on 2023/04/30.
//

import SwiftUI

//リザルト画面で増やされるコインを保存する
var coin_up = 0
//ステージごとの星の数
var number_of_stars_in_each_stage = ["0","2"]
//現在装着しているひよこの色
var chick_selected_color = Color.white
//前ひよこでゲットされているひよことゲットされていないひよこ
var chicks_that_are_getting_or_not: [String:String] = ["赤ひよこ": "not_get", "青ひよこ": "get"]

@main
struct chick_gameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
