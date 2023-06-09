//
//  stage2_View.swift
//  chick_game
//
//  Created by kaito on 2023/05/20.
//

import SwiftUI

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
                                self.isTapped2 = false
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
