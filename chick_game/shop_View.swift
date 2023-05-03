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
    //お金が足りないアラート
    @State private var money_shortage_alert = false
    @State var money_shortage = 0
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: clatter_View(), isActive: $showShould_clatter_View) {
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
                }
                Spacer()
                //自分の所持金
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
                                print("Button")
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

struct shop_View_Previews: PreviewProvider {
    static var previews: some View {
        shop_View()
    }
}
