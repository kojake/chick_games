//
//  result_View.swift
//  chick_game
//
//  Created by kaito on 2023/05/01.
//

import SwiftUI

struct result_View: View {
    @Binding var result: String
    @Binding var remaining_timer: Int
    @Binding var result_star_count: Int
    @Binding var select_stage: Int
    @State var result_coin = 0
    //画面遷移
    @State private var showShould_home_View = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.green.ignoresSafeArea()
                VStack{
                    NavigationLink(destination: ContentView(), isActive: $showShould_home_View) {
                        EmptyView()
                    }.navigationBarBackButtonHidden(true)
                    
                    if result == "clear"{
                        Text("結果").font(.largeTitle).fontWeight(.black)
                        
                        //goal_text
                        Text("!GOAL!").font(.largeTitle).fontWeight(.black)
                        Text("").frame(height: 10)
                        //星の数
                        HStack{
                            if result_star_count == 3{
                                Image(systemName: "star.fill").font(.title)
                                Image(systemName: "star.fill").font(.title)
                                Image(systemName: "star.fill").font(.title)
                            }
                            else if result_star_count == 2{
                                Image(systemName: "star").font(.title)
                                Image(systemName: "star.fill").font(.title)
                                Image(systemName: "star.fill").font(.title)
                            }
                            else if result_star_count == 1{
                                Image(systemName: "star").font(.title)
                                Image(systemName: "star").font(.title)
                                Image(systemName: "star.fill").font(.title)
                            }
                            else if result_star_count == 0{
                                Image(systemName: "star").font(.title)
                                Image(systemName: "star").font(.title)
                                Image(systemName: "star").font(.title)
                            }
                        }.foregroundColor(Color.yellow)
                        
                        //コインの獲得数
                        Text("").frame(height: 10)
                        Text("獲得コイン").font(.largeTitle).fontWeight(.black)
                        HStack{
                            Image("money").resizable().scaledToFit().frame(width: 100)
                            Text("x\(result_coin)").font(.largeTitle).fontWeight(.black)
                        }
                        Spacer()
                        //home戻る
                        Button(action: {
                            showShould_home_View = true
                        }) {
                            HStack {
                                Image(systemName: "house.fill")
                                Text("ホームに戻る")
                            }
                        }.buttonStyle(GradientButtonStyle())
                    }
                    if result == "out_of_time"{
                        Text("結果").font(.largeTitle).fontWeight(.black)
                        
                        //goal_text
                        Text("時間切れ").font(.largeTitle).fontWeight(.black)
                        Text("").frame(height: 10)
                        //コインの獲得数
                        Text("").frame(height: 10)
                        Text("獲得コイン").font(.largeTitle).fontWeight(.black)
                        HStack{
                            Image("money").resizable().scaledToFit().frame(width: 100)
                            Text("x0").font(.largeTitle).fontWeight(.black)
                        }
                        Spacer()
                        //home戻る
                        Button(action: {
                            showShould_home_View = true
                        }) {
                            HStack {
                                Image(systemName: "house.fill")
                                Text("ホームに戻る")
                            }
                        }.buttonStyle(GradientButtonStyle())
                    }
                }
            }.onAppear{
                result_coin = remaining_timer * result_star_count
                //お金を増やす
                coin_up += result_coin
                //星を増やす
                //ネストは許して下さい
                if select_stage == 1{
                    let stage1_stars = number_of_stars_in_each_stage[0]
                    if Int(stage1_stars)! < result_star_count{
                        if result_star_count == 3{
                            number_of_stars_in_each_stage[0] = "3"
                        }
                        else if result_star_count == 2{
                            number_of_stars_in_each_stage[0] = "2"
                        }
                        else if result_star_count == 1{
                            number_of_stars_in_each_stage[0] = "1"
                        }
                    }
                    else{
                        //何もしない
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
    }
}
