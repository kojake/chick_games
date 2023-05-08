//
//  clatter_result.swift
//  chick_game
//
//  Created by kaito on 2023/05/08.
//

import SwiftUI

struct clatter_result: View {
    var body: some View {
        NavigationView{
            //シングルの場合
            if single_or_Third == "シングル"{
                single_clatter_result()
            }
            //サード
            else if single_or_Third == "サード"{
                Third_clatter_result()
            }
        }.navigationBarBackButtonHidden(true)
    }
}

//シングルガチャの場合
struct single_clatter_result: View{
    //buttondesign
    let bgColor = Color.init(red:0.90, green: 0.92, blue: 0.98)
    let buttonColor = Color.init(red: 0.38, green: 0.28, blue: 0.86)
    let lightColor = Color.init(red: 0.54, green: 0.41, blue: 0.95)
    let shadowColor = Color.init(red: 0.25, green: 0.17, blue: 0.75)
    let radius = CGFloat(25)
    //現在装着されているひよこを検知する
    @State var clatter_result_skin = "赤ひよこ"
    //装着されているひよこの色に変える
    @State var chick_color = Color.red
    //画面遷移
    @State private var showShouldContentView = false
    //ゲットalert
    @State private var get_alert = false
    
    var body: some View{
        NavigationView{
            VStack{
                NavigationLink(destination: ContentView(), isActive: $showShouldContentView) {
                    EmptyView()
                }.navigationBarBackButtonHidden(true)
                Text("ガチャ結果").font(.largeTitle).fontWeight(.black)
                Spacer()
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white)
                        .frame(width:390,height: 260)
                        .shadow(radius: 30)
                    HStack{
                        Image("hiyoko") // 回転させる画像の名前を指定
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 180)
                            .colorMultiply(chick_color)
                        Spacer()
                        ZStack{
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.black)
                                .frame(width:200,height: 200)
                                .shadow(radius: 30)
                            VStack{
                                Text("\(clatter_result_skin)").font(.largeTitle).fontWeight(.black).foregroundColor(chick_color)
                            }
                        }
                        Spacer()
                    }
                }
                HStack{
                    Button(action: {
                        chicks_that_are_getting_or_not[clatter_result_skin] = "get"
                        get_alert = true
                    }) {
                        VStack{
                            Text("ゲットする")
                        }.font(.title2)
                            .fontWeight(.black)
                            .frame(width: 120, height: 70)
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
                    Button(action: {
                        showShouldContentView = true
                    }) {
                        VStack{
                            Text("ゲットしない")
                        }.font(.title2)
                            .fontWeight(.black)
                            .frame(width: 120, height: 70)
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
                Spacer()
            }.onAppear{
                if clatter_single_result == 1{
                    clatter_result_skin = "赤ひよこ"
                    chick_color = Color.red
                }
                else if clatter_single_result == 2{
                    clatter_result_skin = "青ひよこ"
                    chick_color = Color.blue
                }
                else if clatter_single_result == 3{
                    clatter_result_skin = "黄ひよこ"
                    chick_color = Color.yellow
                }
                else if clatter_single_result == 4{
                    clatter_result_skin = "緑ひよこ"
                    chick_color = Color.green
                }
                else if clatter_single_result == 5{
                    clatter_result_skin = "紫ひよこ"
                    chick_color = Color.purple
                }
                else if clatter_single_result == 6{
                    clatter_result_skin = "オレンジひよこ"
                    chick_color = Color.orange
                }
            }
        }
        .alert(isPresented: $get_alert) {
                    Alert(title: Text("ゲットしました"),
                          message: Text("ガチャから出た\(clatter_result_skin)をゲットした"),
                          dismissButton: .default(Text("OK"),
                                                  action: {showShouldContentView = true}))
                }
    }
}
//トリプルガチャの場合
struct Third_clatter_result: View{
    //buttondesign
    let bgColor = Color.init(red:0.90, green: 0.92, blue: 0.98)
    let buttonColor = Color.init(red: 0.38, green: 0.28, blue: 0.86)
    let lightColor = Color.init(red: 0.54, green: 0.41, blue: 0.95)
    let shadowColor = Color.init(red: 0.25, green: 0.17, blue: 0.75)
    let radius = CGFloat(25)
    //画面遷移
    @State private var showShouldContentView = false
    
    @State var hiyoko1 = Color.white
    @State var hiyoko2 = Color.white
    @State var hiyoko3 = Color.white
    
    var body: some View{
        NavigationView{
            VStack{
                NavigationLink(destination: ContentView(), isActive: $showShouldContentView) {
                    EmptyView()
                }.navigationBarBackButtonHidden(true)
                Text("ガチャ結果").font(.largeTitle).fontWeight(.black)
                
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
                                    .fill(Color.white)
                                    .frame(width:100,height: 100)
                                    .shadow(radius: 30)
                                Image("hiyoko").resizable().scaledToFit().frame(width: 100, height: 100)
                            }
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.white)
                                    .frame(width:100,height: 100)
                                    .shadow(radius: 30)
                                Image("hiyoko").resizable().scaledToFit().frame(width: 100, height: 100)
                            }
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.white)
                                    .frame(width:100,height: 100)
                                Image("hiyoko").resizable().scaledToFit().frame(width: 100, height: 100)
                            }
                        }
                    }
                }
            }.onAppear{
                if clatter_therrd_result[0] == 1{
                    
                }
            }
        }
    }
}
struct clatter_result_Previews: PreviewProvider {
    static var previews: some View {
        clatter_result()
    }
}
