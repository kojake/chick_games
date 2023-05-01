//
//  main_View.swift
//  chick_game
//
//  Created by kaito on 2023/04/30.
//

import SwiftUI
import UIKit

struct main_View: View {
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
    @State var goal_y_position = -280
    //clear_alert
    @State private var clear_alert = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.green.ignoresSafeArea()
                VStack{
                    NavigationLink(destination: menu_View(interrupt_the_game: $interrupt_the_game), isActive: $showShould_menu_View) {
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
                        Image("hiyoko").resizable().scaledToFit().frame(width: 100, height: 100).position(x: CGFloat(x_position), y: CGFloat(y_position))
                        Image("goal_frag").resizable().scaledToFit().frame(width: 100, height: 100).position(x: CGFloat(goal_x_position), y: CGFloat(goal_y_position))
                    }
                    
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
                                }
                            }
                            print(y_position)
                        }.onEnded { _ in
                            self.isTapped2 = false
                        })
                    }.frame(width: 180, height: 90).overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.red, lineWidth: 5))
                }.onAppear{
                    print("反応")
                    print(interrupt_the_game)
                    if interrupt_the_game == 1{
                        interrupt_the_game = 0
                        dismiss2()
                        sleep(1)
                        dismiss2()
                    }
                }
            }
        }
        .alert(isPresented: $clear_alert) {
            Alert(title: Text("CLEAR!"),
                  message: Text("ゴールしましたリザルト画面に移動します"),
                  dismissButton: .default(Text("OK"),
                                          action: {
                
            }))
        }
    }
}
struct main_View_Previews: PreviewProvider {
    static var previews: some View {
        main_View()
    }
}
