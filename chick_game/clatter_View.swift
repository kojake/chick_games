//
//  clatter_View.swift
//  chick_game
//
//  Created by kaito on 2023/05/03.
//

import SwiftUI

struct clatter_View: View {
    @Binding var single_or_Third_clatter: String
    
    var body: some View {
        NavigationView{
            VStack{
                if single_or_Third_clatter == "シングル"{
                    clatter_single()
                }
                else if single_or_Third_clatter == "サード"{
                    clatter_third()
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

//シングルの場合
struct clatter_single: View{
    //画面遷移
    @State private var showShouldclatter_expression_View = false
    
    //ルーレットitem
    @State private var roulette_color_list = [1,2,3,4,5,6]
    @State var roulette_color_1 = Color.white
    @State var timer_count2 = 0
    @State var button_text = "ガチャを回す"
    
    
    var body: some View{
        VStack{
            NavigationLink(destination: clatter_expression_View(), isActive: $showShouldclatter_expression_View) {
                EmptyView()
            }.navigationBarBackButtonHidden(true)
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
                                if timer_count2 == 6{
                                    timer_count2 = 0
                                }
                            }
                        }
                        else if button_text == "ガチャを止める"{
                            button_text = "ガチャを回す"
                            showShouldclatter_expression_View = true
                            clatter_single_result = timer_count2
                            single_or_Third = "シングル"
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
    }
}

//3回の場合
struct clatter_third: View{
    //画面遷移
    @State private var showShouldclatter_expression_View = false
    //ルーレットitem
    @State private var roulette_color_list = [1,2,3,4,5,6]
    @State var roulette_color_1 = Color.white
    @State var timer_count2 = 0
    @State var button_text = "ガチャを回す"
    @State var chick_out_list = [Int]()
    @State var Remaining_number_of_gacha = 3
    
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: clatter_expression_View(), isActive: $showShouldclatter_expression_View) {
                    EmptyView()
                }.navigationBarBackButtonHidden(true)
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
                                    if timer_count2 == 6{
                                        timer_count2 = 1
                                    }
                                }
                            }
                            else if button_text == "ガチャを止める"{
                                button_text = "ガチャを回す"
                                Remaining_number_of_gacha -= 1
                                chick_out_list.append(timer_count2)
                                if Remaining_number_of_gacha == 0{
                                    clatter_therrd_result = chick_out_list
                                    showShouldclatter_expression_View = true
                                    single_or_Third = "サード"
                                }
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
                        VStack{
                            Text("残りガチャを回せる回数").font(.title).fontWeight(.black)
                            Text("\(Remaining_number_of_gacha)回").font(.title).fontWeight(.black)
                        }.padding()
                    }
                }
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.gray)
                        .frame(width:350,height: 250)
                        .shadow(radius: 30)
                    VStack{
                        Text("ガチャから出たひよこ達").font(.title).fontWeight(.black)
                        
                        HStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(roulette_color_1)
                                    .frame(width:100,height: 100)
                                    .shadow(radius: 30)
                                Text("\(chick_out_list.first ?? 0)").font(.largeTitle).fontWeight(.black)
                            }
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(roulette_color_1)
                                    .frame(width:100,height: 100)
                                    .shadow(radius: 30)
                                Text("\(chick_out_list.count >= 2 ? chick_out_list[1] : 0)").font(.largeTitle).fontWeight(.black)
                            }
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(roulette_color_1)
                                    .frame(width:100,height: 100)
                                    .shadow(radius: 30)
                                Text("\(chick_out_list.count >= 3 ? chick_out_list[2] : 0)").font(.largeTitle).fontWeight(.black)
                            }
                        }
                    }
                }
            }
        }
    }
}
