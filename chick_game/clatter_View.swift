//
//  clatter_View.swift
//  chick_game
//
//  Created by kaito on 2023/05/03.
//

import SwiftUI

struct clatter_View: View {
    //画面を閉じるために使う
    @Environment(\.dismiss) var dismiss
    
    //ルーレットitem
    @State private var roulette_color_list = [1,2,3,4,5,6,7,8,9]
    @State var roulette_color_1 = Color.white
    @State var timer_count2 = 0
    @State var button_text = "ガチャを回す"
    @State private var roulette_popup = false
    
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.yellow)
                        .frame(width:350,height: 430)
                        .shadow(radius: 30)
                    VStack{
                        Text("ガチャを回す").font(.largeTitle).fontWeight(.black)
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 30)
                                .fill(roulette_color_1)
                                .frame(width:100,height: 100)
                                .shadow(radius: 30)
                            
                            if button_text == "ガチャを回す"{
                                Text("?").font(.largeTitle).fontWeight(.black)
                            }
                            else if button_text == "ガチャを止める"{
                                Text("\(timer_count2)").font(.largeTitle).fontWeight(.black)
                            }
                        }
                        Button(action: {
                            if button_text == "ガチャを回す"{
                                button_text = "ガチャを止める"
                                var timer: Timer? = nil
                                timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { _ in
                                    timer_count2 += 1
                                    if button_text == "ガチャを回す"{
                                        timer?.invalidate()
                                    }
                                    if timer_count2 == 9{
                                        timer_count2 = 0
                                    }
                                }
                            }
                            else if button_text == "ガチャを止める"{
                                button_text = "ガチャを回す"
                                roulette_popup = true
                            }
                        }
                        ) {
                            VStack{
                                Text(button_text)
                            }.bold()
                                .padding()
                                .frame(width: 200, height: 50)
                                .foregroundColor(Color.white)
                                .background(Color.gray)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .alert(isPresented: $roulette_popup) {
                Alert(
                    title: Text("ガチャ結果"),
                    message: Text("あなたがゲットしたひよこは"),
                    primaryButton: .default(Text("ゲットしない"),action: {
                        dismiss()
                    }),
                    secondaryButton: .default(Text("ゲットする"),action: {
                        dismiss()
                    })
                )
            }
        }.navigationBarBackButtonHidden(true)
    }
}
struct clatter_View_Previews: PreviewProvider {
    static var previews: some View {
        clatter_View()
    }
}
