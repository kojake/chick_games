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
            VStack{
                //シングルの場合
                if single_or_Third == "シングル"{
                    single_clatter_result()
                }
                //サード
                else if single_or_Third == "サード"{
                    Third_clatter_result()
                }
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
    let buttonColor2 = Color.brown
    let lightColor = Color.init(red: 0.54, green: 0.41, blue: 0.95)
    let shadowColor = Color.init(red: 0.25, green: 0.17, blue: 0.75)
    let radius = CGFloat(25)
    //画面遷移
    @State private var showShouldContentView = false
    //ガチャから出たそれぞれのひよこの色
    @State var hiyoko1 = Color.white
    @State var hiyoko2 = Color.white
    @State var hiyoko3 = Color.white
    //ガチャから出たひよこの名前
    @State var hiyoko1_name = ""
    @State var hiyoko2_name = ""
    @State var hiyoko3_name = ""
    //ガチャから出たひよこをゲットするかしないか
    @State var hiyoko1_get_or_not_get: Bool = false
    @State var hiyoko2_get_or_not_get: Bool = false
    @State var hiyoko3_get_or_not_get: Bool = false
    
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
                        .frame(width:390,height: 340)
                        .shadow(radius: 30)
                    VStack{
                        Text("ガチャから出たひよこ達").font(.title).fontWeight(.black)
                        HStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.white)
                                    .frame(width:110,height: 245)
                                    .shadow(radius: 30)
                                VStack{
                                    Text("\(hiyoko1_name)").font(.title3).fontWeight(.black).foregroundColor(hiyoko1)
                                    Image("hiyoko").resizable().scaledToFit().colorMultiply(hiyoko1).frame(width: 100, height: 100)
                                    Button(action: {
                                        self.hiyoko1_get_or_not_get.toggle()
                                    }) {
                                        if hiyoko1_get_or_not_get {
                                            Image(systemName: "checkmark.square")
                                        } else {
                                            Image(systemName: "square")
                                        }
                                    }.font(.title2)
                                        .fontWeight(.black)
                                        .frame(width: 20, height: 30)
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
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.white)
                                    .frame(width:110,height: 245)
                                    .shadow(radius: 30)
                                VStack{
                                    Text("\(hiyoko2_name)").font(.title3).fontWeight(.black).foregroundColor(hiyoko2)
                                    Image("hiyoko").resizable().scaledToFit().colorMultiply(hiyoko2).frame(width: 100, height: 100)
                                    Button(action: {
                                        self.hiyoko2_get_or_not_get.toggle()
                                    }) {
                                        if hiyoko2_get_or_not_get {
                                            Image(systemName: "checkmark.square")
                                        } else {
                                            Image(systemName: "square")
                                        }
                                    }.font(.title2)
                                        .fontWeight(.black)
                                        .frame(width: 20, height: 30)
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
                            ZStack{
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.white)
                                    .frame(width:110,height: 245)
                                VStack{
                                    Text("\(hiyoko3_name)").font(.title3).fontWeight(.black).foregroundColor(hiyoko3)
                                    Image("hiyoko").resizable().scaledToFit().colorMultiply(hiyoko3).frame(width: 100, height: 100)
                                    Button(action: {
                                        self.hiyoko3_get_or_not_get.toggle()
                                    }) {
                                        if hiyoko3_get_or_not_get {
                                            Image(systemName: "checkmark.square")
                                        } else {
                                            Image(systemName: "square")
                                        }
                                    }.font(.title2)
                                        .fontWeight(.black)
                                        .frame(width: 20, height: 30)
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
                VStack{
                    Text("欲しいひよこにチェックマークをつければゲット!")
                }.font(.title2)
                    .fontWeight(.black)
                    .frame(width: 320, height: 100)
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
                            .foregroundColor(buttonColor2)
                        // ボタンのshadowはボタンの色に合わせる
                            .shadow(color: buttonColor2, radius: 20, y: 10)
                    )
                Spacer()
                VStack{
                    Button(action: {
                        //どのひよこをゲットするかを確認する
                        if hiyoko1_get_or_not_get == true{
                            chicks_that_are_getting_or_not[hiyoko1_name] = "get"
                        }
                        else if hiyoko2_get_or_not_get == true{
                            chicks_that_are_getting_or_not[hiyoko2_name] = "get"
                        }
                        else if hiyoko3_get_or_not_get == true{
                            chicks_that_are_getting_or_not[hiyoko3_name] = "get"
                        }
                        //homeに戻る
                        showShouldContentView = true
                    }) {
                        VStack{
                            Text("完了する")
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
            }.onAppear{
                //一つ目
                if clatter_therrd_result.firstIndex(of: 0) != nil {
                    hiyoko1 = .red
                    hiyoko1_name = "赤ひよこ"
                } else if clatter_therrd_result.firstIndex(of: 1) != nil {
                    hiyoko1 = .blue
                    hiyoko1_name = "青ひよこ"
                } else if clatter_therrd_result.firstIndex(of: 2) != nil {
                    hiyoko1 = .yellow
                    hiyoko1_name = "黄ひよこ"
                } else if clatter_therrd_result.firstIndex(of: 3) != nil {
                    hiyoko1 = .green
                    hiyoko1_name = "緑ひよこ"
                } else if clatter_therrd_result.firstIndex(of: 4) != nil {
                    hiyoko1 = .purple
                    hiyoko1_name = "紫ひよこ"
                } else if clatter_therrd_result.firstIndex(of: 5) != nil {
                    hiyoko1 = .orange
                    hiyoko1_name = "オレンジひよこ"
                }
                //二つ目
                if clatter_therrd_result.indices.contains(0) {
                    if clatter_therrd_result[0] == 0 {
                        hiyoko2 = Color.red
                        hiyoko2_name = "赤ひよこ"
                    } else if clatter_therrd_result[0] == 1 {
                        hiyoko2 = Color.blue
                        hiyoko2_name = "青ひよこ"
                    } else if clatter_therrd_result[0] == 2 {
                        hiyoko2 = Color.yellow
                        hiyoko2_name = "黄ひよこ"
                    } else if clatter_therrd_result[0] == 3 {
                        hiyoko2 = Color.green
                        hiyoko2_name = "緑ひよこ"
                    } else if clatter_therrd_result[0] == 4 {
                        hiyoko2 = Color.purple
                        hiyoko2_name = "紫ひよこ"
                    } else if clatter_therrd_result[0] == 5 {
                        hiyoko2 = Color.orange
                        hiyoko2_name = "オレンジひよこ"
                    }
                }
                //三つ目
                if clatter_therrd_result.indices.contains(0) {
                    if clatter_therrd_result[1] == 0 {
                        hiyoko3 = Color.red
                        hiyoko3_name = "赤ひよこ"
                    } else if clatter_therrd_result[1] == 1 {
                        hiyoko3 = Color.blue
                        hiyoko3_name = "青ひよこ"
                    } else if clatter_therrd_result[1] == 2 {
                        hiyoko3 = Color.yellow
                        hiyoko3_name = "黄ひよこ"
                    } else if clatter_therrd_result[1] == 3 {
                        hiyoko3 = Color.green
                        hiyoko3_name = "緑ひよこ"
                    } else if clatter_therrd_result[1] == 4 {
                        hiyoko3 = Color.purple
                        hiyoko3_name = "紫ひよこ"
                    } else if clatter_therrd_result[1] == 5 {
                        hiyoko3 = Color.orange
                        hiyoko3_name = "オレンジひよこ"
                    }
                }
                print("")
                print(hiyoko1)
                print(hiyoko2)
                print(hiyoko3)
            }
        }
    }
}
struct clatter_result_Previews: PreviewProvider {
    static var previews: some View {
        clatter_result()
    }
}
