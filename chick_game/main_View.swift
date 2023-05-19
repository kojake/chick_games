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
                else if select_stage == 3{
                    stage3(select_stage: $select_stage)
                }
                else if select_stage == 4{
                    stage4(select_stage: $select_stage)
                }
                else if select_stage == 5{
                    stage5(select_stage: $select_stage)
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

//各ステージ
struct stage1: View{
    //画面を閉じるために使う
    @Environment(\.dismiss) var dismiss2
    //contentview画面へ遷移
    @State private var showShould_Content_View = false
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
                    NavigationLink(destination: ContentView(), isActive: $showShould_Content_View) {
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
                            showShould_Content_View = true
                            result = "interruption"
                        }) {
                            Text("ゲームを中断")
                                .bold()
                                .padding()
                                .frame(width: 100, height: 50)
                                .foregroundColor(Color.white)
                                .background(Color.purple)
                                .cornerRadius(10)
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
    @State private var showShould_Content_View = false
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
    @State var goal_y_position = 100
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
                    NavigationLink(destination: ContentView(), isActive: $showShould_Content_View) {
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
                        Image("goal_frag").resizable().scaledToFit().frame(width: 100, height: 100).position(x: CGFloat(goal_x_position), y: CGFloat(goal_y_position))
                        ZStack{
                            Image("car_road").resizable().scaledToFit().position(x: CGFloat(150), y: CGFloat(200)).rotationEffect(.degrees(270)).frame(width: 200, height: 400)
                            Image("hiyoko").resizable().scaledToFit().frame(width: 100, height: 100).position(x: CGFloat(chick_x_position), y: CGFloat(chick_y_position)).colorMultiply(chick_selected_color)
                            Image("car").resizable().scaledToFit().frame(width: 250, height: 200).position(carPosition)
                                .onAppear{
                                    var timer2: Timer?
                                    timer2 = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
                                        if (abs(chick_y_position - Int(carPosition.y)) <= 110) && ((abs(chick_x_position - Int(carPosition.x + -150)) <= 10)){
                                            alert_message = "くるまにあたってやられてしまいました。車が端につき止まりましたら、okボタンを押しリザルト画面に移動して下さい"
                                            result = "collision"
                                            clear_alert = true
                                        }
                                        if carPosition.x == -100{
                                            if result == "collision" || result == "clear" || result == "interruption"{
                                                timer2?.invalidate()
                                            }
                                            else{
                                                carPosition.x = 400
                                                timer2 = nil
                                            }
                                        }
                                        else{
                                            carPosition.x -= 1
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
                                    
                                    if chick_y_position == 0{
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
                                alert_message = "時間切れになりました。車が端につき止まりましたら、okボタンを押しリザルト画面に移動して下さい"
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
                            alert_message = "ゴール旗に触れましたクリアです、車が端につき止まりましたら、okボタンを押しリザルト画面に移動して下さい"
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

//ステージ3
struct stage3: View{
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
    @State var chick_y_position = 100
    //ゴールフラッグの座標
    @State var goal_x_position = 190
    @State var goal_y_position = 120
    //隕石の座標
    @State var meteorite_x_position = 210
    @State var meteorite_y_position = -200
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
    //バリアが適用されているかされていないか
    @State var Are_barriers_applied = 0
    @State var barriers_button_text = "バリア"
    @State var image_text = ""
    
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
                            Text("STAGE3").font(.title3).fontWeight(.black)
                            Text("隕石をバリアで守りながら").font(.title).fontWeight(.black)
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
                        Image("goal_frag").resizable().scaledToFit().frame(width: 100, height: 100).position(x: CGFloat(goal_x_position), y: CGFloat(goal_y_position))
                        Image("meteorite").resizable().scaledToFit().frame(width: 150, height: 150).position(x: CGFloat(meteorite_x_position), y: CGFloat(meteorite_y_position))
                            .onAppear{
                                var timer2: Timer?
                                timer2 = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
                                    if result == "interruption" || result == "collision2" || result == "clear"{
                                        timer2?.invalidate()
                                    }
                                    if (chick_y_position - meteorite_y_position) <= -70{
                                        //バリア検出
                                        if Are_barriers_applied == 1{
                                            meteorite_y_position = -200
                                        }
                                        else{
                                            result = "collision2"
                                            alert_message = "隕石に衝突してしまいました。リザルト画面に移動します"
                                            clear_alert = true
                                        }
                                    }
                                    else{
                                        meteorite_x_position = Int(Float.random(in: 180...210))
                                        meteorite_y_position += 1
                                    }
                                }
                            }
                        ZStack{
                            Image(image_text).resizable().scaledToFit().frame(width: 250, height: 250).position(x: CGFloat(chick_x_position), y: CGFloat(chick_y_position))
                            Image("hiyoko").resizable().scaledToFit().frame(width: 100, height: 100).position(x: CGFloat(chick_x_position + -10), y: CGFloat(chick_y_position + -10)).colorMultiply(chick_selected_color)
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
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(isTapped ? Color.yellow : Color.red)
                                
                            }
                            .simultaneousGesture(LongPressGesture().onChanged { _ in
                                if Are_barriers_applied == 0{
                                    self.isTapped = false
                                    if chick_y_position == 480{
                                    }
                                    else{
                                        chick_y_position += 10
                                    }
                                }
                                else{
                                    
                                }
                            }.onEnded { _ in
                                self.isTapped = true
                            })
                            
                            Button(action: {
                                self.isTapped2.toggle()
                            }) {
                                Image(systemName: "arrowtriangle.up.fill")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(isTapped2 ? Color.yellow : Color.red)
                                
                            }
                            .simultaneousGesture(LongPressGesture().onChanged { _ in
                                if Are_barriers_applied == 0{
                                    self.isTapped2 = true
                                    if chick_y_position == -180{
                                    }
                                    else{
                                        chick_y_position -= 10
                                        
                                        if chick_y_position == -180{
                                            clear_alert = true
                                            clear_or_not_clear = "clear"
                                        }
                                    }
                                }
                                else{
                                    
                                }
                            }.onEnded { _ in
                                self.isTapped2 = false
                            })
                            Button(action: {
                                if Are_barriers_applied == 0{
                                    Are_barriers_applied = 1
                                    barriers_button_text = "解除"
                                    image_text = "barrier"
                                }
                                else{
                                    Are_barriers_applied = 0
                                    barriers_button_text = "バリア"
                                    image_text = ""
                                }
                            }) {
                                Text(barriers_button_text)
                                    .bold()
                                    .padding()
                                    .font(.footnote)
                                    .frame(width: 75, height: 75)
                                    .foregroundColor(Color.white)
                                    .background(Color.yellow)
                                    .clipShape(Circle())
                            }
                        }.frame(width: 220, height: 90).overlay(
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
                        }.frame(width: 160, height: 130).overlay(
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
                            else if result == "collision2"{
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
                            else if result == "collision2"{
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
                            else if result == "collision2"{
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
                                alert_message = "時間切れになりました。隕石が恥についたらokボタンを押しリザルト画面に移動して下さい"
                                result = "out_of_time"
                            }
                            else if clear_or_not_clear == "clear"{
                                timer?.invalidate()
                            }
                            else if result == "collision2"{
                                timer?.invalidate()
                            }
                            else if result == "interruption"{
                                timer?.invalidate()
                            }
                        }
                        if clear_or_not_clear == "clear"{
                            timer?.invalidate()
                            alert_message = "ゴール旗に触れましたクリアです。リザルト画面に移動して下さい"
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

//ステージ5
struct stage5: View{
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
    
    //カード
    @State var card_status = ["card1": "not_overturned","card2": "not_overturned","card3": "not_overturned","card4": "not_overturned","card5": "not_overturned","card": "not_overturned"]
    @State var card_designation = ["card1": "","card2": "","card3": "","card4": "","card5": "","card6": ""]
    //カードめくりアニメーション
    @State var isFront = false
    
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
                            Text("STAGE5").font(.title3).fontWeight(.black)
                            Text("ひよこを揃えながら").font(.title).fontWeight(.black)
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
                    Spacer()
                    VStack{
                        HStack{
                            Button(action: {
                                isFront = true
                            }) {
                                Flip(isFront: isFront,
                                     front: {
                                    Image("神経衰弱_カード_1")
                                },
                                     back: {
                                    Image("神経衰弱_カード_?")
                                })
                            }
                            Button(action: {

                            }) {
                                Image("神経衰弱_カード_?").resizable().scaledToFit()
                            }
                            Button(action: {

                            }) {
                                Image("神経衰弱_カード_?").resizable().scaledToFit()
                            }
                        }
                        HStack{
                            Button(action: {

                            }) {
                                Image("神経衰弱_カード_?").resizable().scaledToFit()
                            }
                            Button(action: {

                            }) {
                                Image("神経衰弱_カード_?").resizable().scaledToFit()
                            }
                            Button(action: {

                            }) {
                                Image("神経衰弱_カード_?").resizable().scaledToFit()
                            }
                        }
                    }.onAppear{
                        //何のカードかを決める
                        for i in 0..<6 {
                            let card_random = Int.random(in: 1..<3)
                            
                            if i == 1{
                                
                            }
                            
                        }
                    }
                    Spacer()
                    HStack{
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
//ステージ5のカードめくりアニメーション
struct Flip<Front: View, Back: View>: View {
    var isFront: Bool
    @State var canShowFrontView: Bool
    let duration: Double
    let front: () -> Front
    let back: () -> Back

    init(isFront: Bool,
         duration: Double = 1.0,
         @ViewBuilder front: @escaping () -> Front,
         @ViewBuilder back: @escaping () -> Back) {
        self.isFront = isFront
        self._canShowFrontView = State(initialValue: isFront)
        self.duration = duration
        self.front = front
        self.back = back
    }

    var body: some View {
        ZStack {
            if self.canShowFrontView {
                front()
            }
            else {
                back()
                    .rotation3DEffect(Angle(degrees: 180), axis: (x: 0, y: 1, z: 0))
            }
        }
        .onChange(of: isFront, perform: {
            value in
            DispatchQueue.main.asyncAfter(deadline: .now() + duration/2.0) {
                self.canShowFrontView = value
            }
        })
        .animation(nil)
        .rotation3DEffect(isFront ? Angle(degrees: 0): Angle(degrees: 180), axis: (x: CGFloat(0), y: CGFloat(10), z: CGFloat(0)))
        .animation(.easeInOut(duration: duration))
    }
}
