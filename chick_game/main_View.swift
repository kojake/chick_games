//
//  main_View.swift
//  chick_game
//
//  Created by kaito on 2023/04/30.
//

import SwiftUI
import UIKit

struct main_View: View {
    //選択されたステージを取得する
    @Binding var select_stage: Int
    
    var body: some View{
        NavigationView{
            VStack{
                //選択されたステージを表示する
                if select_stage == 1{
                    stage1(select_stage: $select_stage)
                }
                else if select_stage == 2{
                    stage2(select_stage: $select_stage)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

//各ステージ
struct stage1: View{
    //画面を閉じるために使う
    @Environment(\.dismiss) var dismiss2
    //menu画面へ遷移
    @State private var showShould_menu_View = false
    //ゲーム中断
    @State var interrupt_the_game = 0
    //button_color
    @State private var isTapped = true
    @State private var isTapped2 = true
    //ひよこ座標&ゴール旗の座標
    @State var x_position = 200
    @State var y_position = 430
    @State var goal_x_position = 200
    @State var goal_y_position = -250
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

    var body: some View {
        NavigationView{
            ZStack{
                Color.green.ignoresSafeArea()
                VStack{
                     NavigationLink(destination: menu_View(), isActive: $showShould_menu_View) {
                        EmptyView()
                    }.navigationBarBackButtonHidden(true)
                    NavigationLink(destination: result_View(result: $result, remaining_timer: $timer_count, result_star_count: $star_count, select_stage: $select_stage), isActive: $showShould_result_View) {
                        EmptyView()
                    }.navigationBarBackButtonHidden(true)
                    HStack{
                        VStack{
                            Text("STAGE1").font(.title3).fontWeight(.black)
                            Text("フラッグを目指して").font(.title).fontWeight(.black)
                        }
                        Spacer()
                        Button(action: {
                            showShould_menu_View = true
                        }) {
                            Text("MENU")
                                .fontWeight(.black)
                                .padding()
                                .frame(width: 100, height: 100)
                                .foregroundColor(Color.white)
                                .background(Color.yellow)
                                .clipShape(Circle())
                        }
                    }
                    
                    VStack{
                        Image("hiyoko").resizable().scaledToFit().frame(width: 100, height: 100).position(x: CGFloat(x_position), y: CGFloat(y_position)).colorMultiply(chick_selected_color)
                        Image("goal_frag").resizable().scaledToFit().frame(width: 100, height: 100).position(x: CGFloat(goal_x_position), y: CGFloat(goal_y_position))
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
                                if y_position == 480{
                                }
                                else{
                                    y_position += 10
                                }
                                print(y_position)
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
                                if y_position == 0{
                                }
                                else{
                                    y_position -= 10
                                    
                                    if y_position == 0{
                                        clear_alert = true
                                        clear_or_not_clear = "clear"
                                    }
                                }
                                print(y_position)
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
                        }
                        
                        
                        if clear_or_not_clear == "clear"{
                            timer?.invalidate()
                            alert_message = "ゴール旗に触れましたクリアです、リザルト画面に移動します"
                            result = "clear"
                        }
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
        .alert(isPresented: $clear_alert) {
            Alert(title: Text("結果"), message: Text(alert_message),
                  dismissButton: .default(Text("OK"),
                                          action: {
                showShould_result_View = true
            }))
        }
    }
}

//ステージ2
struct stage2: View{
    //画面を閉じるために使う
    @Environment(\.dismiss) var dismiss2
    //menu画面へ遷移
    @State private var showShould_menu_View = false
    //ゲーム中断
    @State var interrupt_the_game = 0
    //button_color
    @State private var isTapped = true
    @State private var isTapped2 = true
    //ひよこ座標
    @State var chick_x_position = 200
    @State var chick_y_position = 350
    //ゴールフラッグの座標
    @State var goal_x_position = 200
    @State var goal_y_position = 0
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
    //車の位置
    @State private var carPosition = CGPoint(x: CGFloat(460), y: CGFloat(150))

    var body: some View {
        NavigationView{
            ZStack{
                Color.green.ignoresSafeArea()
                VStack{
                     NavigationLink(destination: menu_View(), isActive: $showShould_menu_View) {
                        EmptyView()
                    }.navigationBarBackButtonHidden(true)
                    NavigationLink(destination: result_View(result: $result, remaining_timer: $timer_count, result_star_count: $star_count, select_stage: $select_stage), isActive: $showShould_result_View) {
                        EmptyView()
                    }.navigationBarBackButtonHidden(true)
                    HStack{
                        VStack{
                            Text("STAGE2").font(.title3).fontWeight(.black)
                            Text("くるまを避けながら").font(.title).fontWeight(.black)
                        }
                        Spacer()
                        Button(action: {
                            showShould_menu_View = true
                        }) {
                            Text("MENU")
                                .fontWeight(.black)
                                .padding()
                                .frame(width: 100, height: 100)
                                .foregroundColor(Color.white)
                                .background(Color.yellow)
                                .clipShape(Circle())
                        }
                    }
                    
                    VStack{
                        Image("goal_frag").resizable().scaledToFit().frame(width: 100, height: 100).position(x: CGFloat(goal_x_position), y: CGFloat(goal_y_position))
                        ZStack{
                            Image("car_road").resizable().scaledToFit().position(x: CGFloat(150), y: CGFloat(200)).rotationEffect(.degrees(270)).frame(width: 200, height: 400)
                            Image("hiyoko").resizable().scaledToFit().frame(width: 100, height: 100).position(x: CGFloat(chick_x_position), y: CGFloat(chick_y_position)).colorMultiply(chick_selected_color)
                            Image("car").resizable().scaledToFit().frame(width: 250, height: 200).position(carPosition).onAppear{
                                Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                                    carPosition.x -= 1
                                    
                                    if ((Int(carPosition.x) - chick_x_position) <= 10) && ((Int(carPosition.y) - chick_y_position) <= 10 ){
                                        clear_alert = true
                                        alert_message = "くるまにあたってやられてしまいました。リザルト画面に移動します"
                                        result = "car_crash"
                                    }
                                    
                                    if carPosition.x == -100{
                                        carPosition.x = 400
                                    }
                                }
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
                                    chick_y_position += 10
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
                                if chick_y_position == 0{
                                }
                                else{
                                    chick_y_position -= 10
                                    
                                    if chick_y_position == goal_y_position{
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
                        }
                        
                        
                        if clear_or_not_clear == "clear"{
                            timer?.invalidate()
                            alert_message = "ゴール旗に触れましたクリアです、リザルト画面に移動します"
                            result = "clear"
                        }
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
        .alert(isPresented: $clear_alert) {
            Alert(title: Text("結果"), message: Text(alert_message),
                  dismissButton: .default(Text("OK"), action: {
                showShould_result_View = true
            }))
        }
    }
}

