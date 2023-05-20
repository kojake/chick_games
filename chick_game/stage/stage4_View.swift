//
//  stage4_View.swift
//  chick_game
//
//  Created by kaito on 2023/05/20.
//

import SwiftUI

//ステージ4
struct stage4: View{
    //画面を閉じるために使う
    @Environment(\.dismiss) var dismiss2
    //menu画面へ遷移
    @State private var showShould_Content_View = false
    //ゲーム中断
    @State var interrupt_the_game = 0
    //button_color
    @State private var isTapped = true
    @State private var isTapped2 = true
    //ひよこ座標
    @State var chick_x_position = 200
    @State var chick_y_position = 290
    //ゴールフラッグの座標
    @State var goal_x_position = 200
    @State var goal_y_position = 30
    //clear_alert
    @State private var clear_alert = false
    @State var alert_message = ""
    //timer
    @State var timer_count = 15
    //result_View
    @State private var showShould_result_View = false
    //結果
    @State var result = ""
    @State var clear_or_not_clear = ""
    //スターの数
    @State var star_count = 3
    //選択されたステージを取得する
    @Binding var select_stage: Int
    
    //パズル
    //青ブロックの位置
    @State var blue_block_position1 = CGPoint(x:CGFloat(190), y:CGFloat(30))
    @State var blue_block_position2 = CGPoint(x:CGFloat(190), y:CGFloat(-180))
    //黄ブロックの位置
    @State var yellow_block_position1 = CGPoint(x:CGFloat(190), y:CGFloat(-80))
    @State var yellow_block_position2 = CGPoint(x:CGFloat(190), y:CGFloat(-280))
    //青黄ブロックの保管庫座標
    @State var storage_blue_position = CGPoint(x:CGFloat(55), y:CGFloat(-30))
    @State var storage_yellow_position = CGPoint(x:CGFloat(335), y:CGFloat(-60))
    @State var Number_of_times_removed = ["blue1": "no", "blue2": "no","yellow1": "no", "yellow2": "no"]
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.green.ignoresSafeArea()
                VStack{
                    NavigationLink(destination: ContentView(), isActive: $showShould_Content_View) {
                        EmptyView()
                    }.navigationBarBackButtonHidden(true)
                    NavigationLink(destination: result_View(result: $result, remaining_timer: $timer_count, result_star_count: $star_count, select_stage: $select_stage), isActive: $showShould_result_View) {
                        EmptyView()
                    }.navigationBarBackButtonHidden(true)
                    HStack{
                        VStack{
                            Text("STAGE4").font(.title3).fontWeight(.black)
                            Text("頭を使いながら").font(.title).fontWeight(.black)
                        }
                        Spacer()
                        Button(action: {
                            showShould_Content_View = true
                            result = "interruption"
                        }) {
                            Text("ゲーム中断")
                                .bold()
                                .padding()
                                .frame(width: 140, height: 50)
                                .foregroundColor(Color.white)
                                .background(Color.purple)
                                .cornerRadius(10)
                        }
                    }
                    VStack{
                        if Number_of_times_removed["yellow1"] == "yes" && Number_of_times_removed["yellow2"] == "yes" && Number_of_times_removed["blue1"] == "yes" && Number_of_times_removed["blue2"] == "yes"{
                            Image("goal_frag").resizable().scaledToFit().frame(width: 100, height: 100).position(x: CGFloat(goal_x_position), y: CGFloat(goal_y_position))
                        }
                        Image("hiyoko").resizable().scaledToFit().frame(width: 100, height: 100).position(x: CGFloat(chick_x_position), y: CGFloat(chick_y_position)).colorMultiply(chick_selected_color)
                        
                        VStack{
                            VStack{
                                Button(action: {
                                    blue_block_position1 = CGPoint(x:CGFloat(55), y:CGFloat(155))
                                    Number_of_times_removed["blue1"] = "yes"
                                }) {
                                    Text("←")
                                        .bold()
                                        .font(.title)
                                        .fontWeight(.black)
                                        .padding()
                                        .frame(width: 100, height: 50)
                                        .foregroundColor(Color.white)
                                        .background(Color.blue)
                                        
                                }
                            }.position(blue_block_position1).zIndex(1)
                            VStack{
                                Button(action: {
                                    yellow_block_position1 = CGPoint(x:CGFloat(335), y:CGFloat(90))
                                    Number_of_times_removed["yellow1"] = "yes"
                                }) {
                                    Text("→")
                                        .bold()
                                        .font(.title)
                                        .fontWeight(.black)
                                        .padding()
                                        .frame(width: 100, height: 50)
                                        .foregroundColor(Color.white)
                                        .background(Color.yellow)
                                        
                                }
                            }.position(yellow_block_position1).zIndex(1)
                            VStack{
                                Button(action: {
                                    blue_block_position2 = CGPoint(x:CGFloat(55), y:CGFloat(30))
                                    Number_of_times_removed["blue2"] = "yes"
                                }) {
                                    Text("←")
                                        .bold()
                                        .font(.title)
                                        .fontWeight(.black)
                                        .padding()
                                        .frame(width: 100, height: 50)
                                        .foregroundColor(Color.white)
                                        .background(Color.blue)
                                        
                                }
                            }.position(blue_block_position2).zIndex(1)
                            VStack{
                                Button(action: {
                                    yellow_block_position2 = CGPoint(x:CGFloat(335), y:CGFloat(-35))
                                    Number_of_times_removed["yellow2"] = "yes"
                                }) {
                                    Text("→")
                                        .bold()
                                        .font(.title)
                                        .fontWeight(.black)
                                        .padding()
                                        .frame(width: 100, height: 50)
                                        .foregroundColor(Color.white)
                                        .background(Color.yellow)
                                }
                            }.position(yellow_block_position2).zIndex(1)
                            ZStack{
                                //青ブロック保管庫
                                Image("Storage_of_blue_blocks_image").resizable().scaledToFit().frame(width: 100, height: 220).position(storage_blue_position)
                                //黄ブロック保管庫
                                Image("Storage_of_yellow_blocks_image").resizable().scaledToFit().frame(width: 100, height: 220).position(storage_yellow_position)
                            }
                        }
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        HStack{
                            Button(action: {
                                self.isTapped.toggle()
                            }) {
                                Image(systemName: "arrowtriangle.down.fill")
                                    .resizable()
                                    .frame(width: 75, height: 75)
                                    .foregroundColor(isTapped ? Color.yellow : Color.red)
                                
                            }
                            .simultaneousGesture(LongPressGesture().onChanged { _ in
                                self.isTapped = false
                                if chick_y_position == 480{
                                }
                                else{
                                    if Number_of_times_removed["yellow1"] == "yes" && Number_of_times_removed["yellow2"] == "yes" && Number_of_times_removed["blue1"] == "yes" && Number_of_times_removed["blue2"] == "yes"{
                                        chick_y_position += 10
                                    }
                                }
                            }.onEnded { _ in
                                self.isTapped = true
                            })
                            
                            Button(action: {
                                self.isTapped2.toggle()
                            }) {
                                Image(systemName: "arrowtriangle.up.fill")
                                    .resizable()
                                    .frame(width: 75, height: 75)
                                    .foregroundColor(isTapped2 ? Color.yellow : Color.red)
                                
                            }
                            .simultaneousGesture(LongPressGesture().onChanged { _ in
                                self.isTapped2 = true
                                if Number_of_times_removed["yellow1"] == "yes" && Number_of_times_removed["yellow2"] == "yes" && Number_of_times_removed["blue1"] == "yes" && Number_of_times_removed["blue2"] == "yes"{
                                    chick_y_position -= 10
                                    
                                    if chick_y_position == -140{
                                        clear_alert = true
                                        clear_or_not_clear = "clear"
                                    }
                                }
                            }.onEnded { _ in
                                self.isTapped2 = false
                            })
                        }.frame(width: 180, height: 90).overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.red, lineWidth: 5))
                        Spacer()
                        VStack{
                            HStack{
                                if star_count == 3{
                                    Image(systemName: "star.fill").font(.title)
                                    Image(systemName: "star.fill").font(.title)
                                    Image(systemName: "star.fill").font(.title)
                                }
                                else if star_count == 2{
                                    Image(systemName: "star").font(.title)
                                    Image(systemName: "star.fill").font(.title)
                                    Image(systemName: "star.fill").font(.title)
                                }
                                else if star_count == 1{
                                    Image(systemName: "star").font(.title)
                                    Image(systemName: "star").font(.title)
                                    Image(systemName: "star.fill").font(.title)
                                }
                                else if star_count == 0{
                                    Image(systemName: "star").font(.title)
                                    Image(systemName: "star").font(.title)
                                    Image(systemName: "star").font(.title)
                                }
                            }.foregroundColor(Color.yellow)
                            HStack{
                                Image(systemName: "clock").font(.largeTitle).fontWeight(.black)
                                Text("\(timer_count)").font(.title2).fontWeight(.black)
                            }
                        }.frame(width: 180, height: 130).overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 5))
                        Spacer()
                    }
                }.onAppear{
                    //timerstart
                    var timer: Timer? = nil
                    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                        timer_count -= 1
                        
                        if star_count == 3{
                            if timer_count == 0 {
                                timer = nil
                                timer_count = 15
                                star_count -= 1
                            }
                            else if clear_or_not_clear == "clear"{
                                timer?.invalidate()
                            }
                            else if result == "collision"{
                                timer?.invalidate()
                            }
                            else if result == "interruption"{
                                timer?.invalidate()
                            }
                        }
                        else if star_count == 2{
                            if timer_count == 0 {
                                timer = nil
                                timer_count = 15
                                star_count -= 1
                            }
                            else if clear_or_not_clear == "clear"{
                                timer?.invalidate()
                            }
                            else if result == "collision"{
                                timer?.invalidate()
                            }
                            else if result == "interruption"{
                                timer?.invalidate()
                            }
                        }
                        else if star_count == 1{
                            if timer_count == 0 {
                                timer = nil
                                timer_count = 15
                                star_count -= 1
                            }
                            else if clear_or_not_clear == "clear"{
                                timer?.invalidate()
                            }
                            else if result == "collision"{
                                timer?.invalidate()
                            }
                            else if result == "interruption"{
                                timer?.invalidate()
                            }
                        }
                        else if star_count == 0{
                            if timer_count == 0 {
                                timer?.invalidate()
                                timer = nil
                                clear_alert = true
                                alert_message = "時間切れになりました。リザルト画面に移動します"
                                result = "out_of_time"
                            }
                            else if clear_or_not_clear == "clear"{
                                timer?.invalidate()
                            }
                            else if result == "collision"{
                                timer?.invalidate()
                            }
                            else if result == "interruption"{
                                timer?.invalidate()
                            }
                        }
                        if clear_or_not_clear == "clear"{
                            timer?.invalidate()
                            alert_message = "ゴール旗に触れましたクリアです、リザルト画面に移動します"
                            result = "clear"
                        }
                    }
                }
                .alert(isPresented: $clear_alert) {
                    Alert(title: Text("結果"),
                          message: Text(alert_message),
                          dismissButton: .default(Text("OK"),
                                                  action: {showShould_result_View = true}))
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}
