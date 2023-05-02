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
    @State var coin_up = coin
    @State var result_coin = 0
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.green.ignoresSafeArea()
                VStack{
                    if result == "clear"{
                        Text("結果").font(.largeTitle).fontWeight(.black)
                        
                        //goal_text
                        Text("!GOAL!").font(.largeTitle).fontWeight(.black)
                        Text("").frame(height: 10)
                        //残り秒数
                        HStack{
                            Text("残り秒数：").font(.largeTitle).fontWeight(.black)
                            Text("\(remaining_timer)").font(.largeTitle).fontWeight(.black)
                        }
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
                        }
                        
                        //コインの獲得数
                        Text("").frame(height: 10)
                        Text("獲得コイン").font(.largeTitle).fontWeight(.black)
                        HStack{
                            Image("money").resizable().scaledToFit().frame(width: 100)
                            Text("x\(result_coin)").font(.largeTitle).fontWeight(.black)
                        }
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
                    }
                }
            }.onAppear{
                result_coin = remaining_timer * result_star_count
            }
        }.navigationBarBackButtonHidden(true)
    }
}
