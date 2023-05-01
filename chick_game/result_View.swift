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
    @State var coin_up = coin
    
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
                        //コインの獲得数
                        Text("").frame(height: 10)
                        Text("獲得コイン").font(.largeTitle).fontWeight(.black)
                        HStack{
                            Image("money").resizable().scaledToFit().frame(width: 100)
                            Text("x10").font(.largeTitle).fontWeight(.black)
                        }
                    }
                    if result == "out_of_time"{
                        Text("結果").font(.largeTitle).fontWeight(.black)
                        
                        //goal_text
                        Text("時間切れ").font(.largeTitle).fontWeight(.black)
                        Text("").frame(height: 10)
                        //残り秒数
                        HStack{
                            Text("残り秒数：").font(.largeTitle).fontWeight(.black)
                            Text("\(remaining_timer)").font(.largeTitle).fontWeight(.black)
                        }
                        //コインの獲得数
                        Text("").frame(height: 10)
                        Text("獲得コイン").font(.largeTitle).fontWeight(.black)
                        HStack{
                            Image("money").resizable().scaledToFit().frame(width: 100)
                            Text("x0").font(.largeTitle).fontWeight(.black)
                        }
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}
