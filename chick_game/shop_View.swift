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
    
    //ルーレット画面に遷移
    @State private var showShould_clatter_View = false
    @State var clatter_single_or_Third_selected = ""
    //お金が足りないアラート
    @State private var money_shortage_alert = false
    @State var money_shortage = 0
    //buttondesign
    let bgColor = Color.init(red:0.90, green: 0.92, blue: 0.98)
    let buttonColor = Color.init(red: 0.38, green: 0.28, blue: 0.86)
    let lightColor = Color.init(red: 0.54, green: 0.41, blue: 0.95)
    let shadowColor = Color.init(red: 0.25, green: 0.17, blue: 0.75)
    let radius = CGFloat(25)
    
    //coin
    @State var coin = 500
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: clatter_View(single_or_Third_clatter: $clatter_single_or_Third_selected), isActive: $showShould_clatter_View) {
                    EmptyView()
                }.navigationBarBackButtonHidden(true)
                
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
                ScrollView(.horizontal) {
                    VStack{
                        HStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.black)
                                    .frame(width:210,height: 270)
                                    .shadow(radius: 30)
                                
                                VStack{
                                    Text("赤ひよこ").font(.largeTitle).fontWeight(.black).foregroundColor(Color.red)
                                    Image("hiyoko").resizable().scaledToFit().frame(width: 80, height: 80).colorMultiply(Color.red)
                                    let (red_chick, red_chick_value) = chicks_that_are_getting_or_not.first(where: { _ in true })!
                                    
                                    if red_chick_value == "not_get"{
                                        Button(action: {
                                            if coin >= 400{
                                                //お金を減らす
                                                coin -= 400
                                                //赤ひよこをゲットした判定に変える
                                                chicks_that_are_getting_or_not["赤ひよこ"] = "get"
                                            }
                                            else{
                                                money_shortage_alert = true
                                                //どれぐらいお金が足りないのかを計算する
                                                money_shortage = 400 - coin
                                            }
                                        }){
                                            VStack{
                                                Spacer()
                                                Text("購入する")
                                                HStack{
                                                    Image("money").resizable().scaledToFit().frame(width: 30, height: 40)
                                                    Text("400").foregroundColor(Color.black)
                                                }.bold()
                                                    .padding()
                                                    .frame(width: 130, height: 30)
                                                    .foregroundColor(Color.white)
                                                    .background(Color.white)
                                            }.font(.title)
                                                .fontWeight(.black)
                                                .frame(width: 120, height: 50)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 35)
                                                .padding(.vertical, 20)
                                                .background(
                                                    RoundedRectangle(cornerRadius: radius)
                                                        .fill(
                                                            // shadowでボタン上部に光沢を持たせる
                                                            // .innerはiOS16から対応
                                                            .shadow(.inner(color: lightColor, radius: 6, x: 4, y: 4))
                                                            // shadowでボタン下部に影を落とす
                                                                .shadow(.inner(color: shadowColor, radius: 6, x: -2, y: -2))
                                                        )
                                                        .foregroundColor(buttonColor)
                                                    // ボタンのshadowはボタンの色に合わせる
                                                        .shadow(color: buttonColor, radius: 20, y: 10)
                                                )
                                        }
                                    }
                                    else if red_chick_value == "get"{
                                        VStack{
                                            Text("所持済み")
                                        }.font(.title)
                                            .fontWeight(.black)
                                            .frame(width: 120, height: 50)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 35)
                                            .padding(.vertical, 20)
                                            .background(
                                                RoundedRectangle(cornerRadius: radius)
                                                    .fill(
                                                        // shadowでボタン上部に光沢を持たせる
                                                        // .innerはiOS16から対応
                                                        .shadow(.inner(color: lightColor, radius: 6, x: 4, y: 4))
                                                        // shadowでボタン下部に影を落とす
                                                            .shadow(.inner(color: shadowColor, radius: 6, x: -2, y: -2))
                                                    )
                                                    .foregroundColor(buttonColor)
                                                // ボタンのshadowはボタンの色に合わせる
                                                    .shadow(color: buttonColor, radius: 20, y: 10)
                                            )
                                    }
                                }
                            }
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.black)
                                    .frame(width:190,height: 260)
                                    .shadow(radius: 30)
                                VStack{
                                    Text("青ひよこ").font(.largeTitle).fontWeight(.black).foregroundColor(Color.blue)
                                    Image("hiyoko").resizable().scaledToFit().frame(width: 80, height: 80).colorMultiply(Color.blue)
                                    
                                    let (blue_chick, blue_chick_value) = chicks_that_are_getting_or_not.dropFirst().first(where: { _ in true })!
                                    
                                    if blue_chick_value == "not_get"{
                                        Button(action: {
                                            if coin >= 400{
                                                //お金を減らす
                                                coin -= 400
                                                //赤ひよこをゲットした判定に変える
                                                chicks_that_are_getting_or_not["青ひよこ"] = "get"
                                            }
                                            else{
                                                money_shortage_alert = true
                                                //どれぐらいお金が足りないのかを計算する
                                                money_shortage = 400 - coin
                                            }
                                        }){
                                            VStack{
                                                Spacer()
                                                Text("購入する")
                                                HStack{
                                                    Image("money").resizable().scaledToFit().frame(width: 30, height: 40)
                                                    Text("400").foregroundColor(Color.black)
                                                }.bold()
                                                    .padding()
                                                    .frame(width: 130, height: 30)
                                                    .foregroundColor(Color.white)
                                                    .background(Color.white)
                                            }.font(.title)
                                                .fontWeight(.black)
                                                .frame(width: 120, height: 50)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 35)
                                                .padding(.vertical, 20)
                                                .background(
                                                    RoundedRectangle(cornerRadius: radius)
                                                        .fill(
                                                            // shadowでボタン上部に光沢を持たせる
                                                            // .innerはiOS16から対応
                                                            .shadow(.inner(color: lightColor, radius: 6, x: 4, y: 4))
                                                            // shadowでボタン下部に影を落とす
                                                                .shadow(.inner(color: shadowColor, radius: 6, x: -2, y: -2))
                                                        )
                                                        .foregroundColor(buttonColor)
                                                    // ボタンのshadowはボタンの色に合わせる
                                                        .shadow(color: buttonColor, radius: 20, y: 10)
                                                )
                                        }
                                    }
                                    else if blue_chick_value == "get"{
                                        VStack{
                                            Text("所持済み")
                                        }.font(.title)
                                            .fontWeight(.black)
                                            .frame(width: 120, height: 50)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 35)
                                            .padding(.vertical, 20)
                                            .background(
                                                RoundedRectangle(cornerRadius: radius)
                                                    .fill(
                                                        // shadowでボタン上部に光沢を持たせる
                                                        // .innerはiOS16から対応
                                                        .shadow(.inner(color: lightColor, radius: 6, x: 4, y: 4))
                                                        // shadowでボタン下部に影を落とす
                                                            .shadow(.inner(color: shadowColor, radius: 6, x: -2, y: -2))
                                                    )
                                                    .foregroundColor(buttonColor)
                                                // ボタンのshadowはボタンの色に合わせる
                                                    .shadow(color: buttonColor, radius: 20, y: 10)
                                            )
                                    }
                                }
                            }
                        }
                    }
                }
                Spacer()
                //自分の所持金
                HStack{
                    VStack{
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        HStack{
                            Image("money").resizable().scaledToFit().frame(width: 50,height: 40)
                            Text("\(coin)").font(.title).fontWeight(.black)
                        }
                        Text("自分の所持金").fontWeight(.black).font(.title)
                        Spacer()
                    }.bold()
                        .padding()
                        .frame(width: 250, height: 115)
                        .foregroundColor(Color.white)
                        .background(Color.gray).shadow(radius: 10)
                }.onAppear{
                    //リザルト画面で増やされたcoin_upの分をcoinに増やす
                    coin += coin_up
                    //coin_upを0にする
                    coin_up = 0
                }
                Spacer()
                //ルーレットバージョン
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.yellow)
                        .frame(width:350,height: 350)
                        .shadow(radius: 30)
                    VStack{
                        Text("ガチャ").font(.largeTitle).fontWeight(.black)
                        
                        VStack{
                            Button(action: {
                                if coin >= 100{
                                    showShould_clatter_View = true
                                    //お金を減らす
                                    coin -= 100
                                    //シングルに選択されたことを保存する
                                    clatter_single_or_Third_selected = "シングル"
                                }
                                else{
                                    money_shortage_alert = true
                                    //どれぐらいお金が足りないのかを計算する
                                    money_shortage = 100 - coin
                                }
                            }) {
                                VStack{
                                    Text("シングル").fontWeight(.black).font(.title3)
                                    HStack{
                                        Image("money").resizable().scaledToFit().frame(width: 100, height: 50)
                                        Text("100").foregroundColor(Color.black).font(.title2)
                                    }.bold()
                                        .padding()
                                        .frame(width: 180, height: 50)
                                        .foregroundColor(Color.white)
                                        .background(Color.white)

                                }.bold()
                                    .padding()
                                    .frame(width: 200, height: 100)
                                    .foregroundColor(Color.white)
                                    .background(Color.gray)
                            }
                            Button(action: {
                                if coin >= 500{
                                    showShould_clatter_View = true
                                    //お金を減らす
                                    coin -= 500
                                    //シングルに選択されたことを保存する
                                    clatter_single_or_Third_selected = "サード"
                                }
                                else{
                                    money_shortage_alert = true
                                    //どれぐらいお金が足りないのかを計算する
                                    money_shortage = 500 - coin
                                }

                            }) {
                                VStack{
                                    Text("3回").fontWeight(.black).font(.title3)
                                    HStack{
                                        Image("money").resizable().scaledToFit().frame(width: 100, height: 50)
                                        Text("500").foregroundColor(Color.black).font(.title3)
                                    }.bold()
                                        .padding()
                                        .frame(width: 180, height: 50)
                                        .foregroundColor(Color.white)
                                        .background(Color.white)

                                }.bold()
                                    .padding()
                                    .frame(width: 200, height: 100)
                                    .foregroundColor(Color.white)
                                    .background(Color.gray)
                            }
                        }
                    }
                }
                .alert(isPresented: $money_shortage_alert) {
                    Alert(title: Text("お金が足りません"),
                          message: Text("お金が\(money_shortage)コイン足りません"),
                          dismissButton: .default(Text("了解"),action: {print("了解がタップされた")})
                )}
                
            }
        }.navigationBarBackButtonHidden(true)
    }
}
