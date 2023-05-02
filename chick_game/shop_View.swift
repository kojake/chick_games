//
//  shop_View.swift
//  chick_game
//
//  Created by kaito on 2023/05/02.
//

import SwiftUI
import UIKit

struct shop_View: View {
    //画面を閉じるために使う
    @Environment(\.dismiss) var dismiss
    
    //ルーレットitem
    @State private var roulette_color_list = [1,2,3,4,5,6,7,8,9]
    @State var roulette_color_1 = Color.white
    @State var timer_count2 = 0
    @State var button_text = "ルーレットを回す"
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Button(action: {
                        dismiss()
                    }) {
                        Text("戻る")
                            .bold()
                            .padding()
                            .frame(width: 100, height: 50)
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    Spacer()
                    Text("SHOP").font(.largeTitle).fontWeight(.black)
                    
                }
                //色々な色のひよこ
                VStack{
                    HStack{
                        ZStack{
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.red)
                                .frame(width:190,height: 260)
                                .shadow(radius: 30)
                            
                            VStack{
                                Text("赤ひよこ").font(.largeTitle).fontWeight(.black)
                            }
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.blue)
                                .frame(width:190,height: 260)
                                .shadow(radius: 30)
                            
                            VStack{
                                Text("青ひよこ").font(.largeTitle).fontWeight(.black)
                            }
                        }
                    }
                }
                Spacer()
                //ルーレットバージョン
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.yellow)
                        .frame(width:350,height: 430)
                        .shadow(radius: 30)
                    VStack{
                        Text("ルーレット").font(.largeTitle).fontWeight(.black)
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 30)
                                .fill(roulette_color_1)
                                .frame(width:100,height: 100)
                                .shadow(radius: 30)
                            Text(String(timer_count2)).font(.largeTitle).fontWeight(.black)
                        }
                        Button(action: {
                            if button_text == "ルーレットを回す"{
                                button_text = "ルーレットを止める"
                                var timer: Timer? = nil
                                timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                                    timer_count2 += 1
                                    if button_text == "ルーレットを回す"{
                                        timer?.invalidate()
                                    }
                                    if timer_count2 == 9{
                                        timer_count2 = 0
                                    }
                                }
                            }
                            else if button_text == "ルーレットを止める"{
                                button_text = "ルーレットを回す"
                            }
                        }
                        ) {
                            Text(button_text)
                                .bold()
                                .padding()
                                .frame(width: 200, height: 50)
                                .foregroundColor(Color.white)
                                .background(Color.purple)
                                .cornerRadius(10)
                        }
                    }
                }
            }.navigationBarBackButtonHidden(true)
        }
    }
}

struct shop_View_Previews: PreviewProvider {
    static var previews: some View {
        shop_View()
    }
}
