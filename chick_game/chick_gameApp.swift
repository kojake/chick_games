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
var number_of_stars_in_each_stage = ["0","0","0","0","0"]
//現在装着しているひよこの色
var chick_selected_color = Color.white
//前ひよこでゲットされているひよことゲットされていないひよこ
var chicks_that_are_getting_or_not: [String:String] = ["赤ひよこ": "not_get", "青ひよこ": "not_get","黄ひよこ": "not_get", "緑ひよこ": "not_get", "紫ひよこ": "not_get", "オレンジひよこ": "not_get"]
//ガチャ結果
var clatter_single_result = 0
var clatter_therrd_result = [Int]()
var single_or_Third = ""

@main
struct chick_gameApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
