//
//  stage3_View.swift
//  chick_game
//
//  Created by kaito on 2023/05/20.
//

import SwiftUI

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
