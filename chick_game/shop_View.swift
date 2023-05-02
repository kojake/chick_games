//
//  shop_View.swift
//  chick_game
//
//  Created by kaito on 2023/05/02.
//

import SwiftUI

struct shop_View: View {
    //画面を閉じるために使う
    @Environment(\.dismiss) var dismiss
    
    //ルーレットitem
    @State private var rotation: Double = 0
    @State private var spinDegrees: Double = 0
    
    let rouletteNumbers: [Int] = Array(0...36)
    
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
                        .frame(width:350,height: 350)
                        .shadow(radius: 30)
                    Text("ルーレット").font(.largeTitle).fontWeight(.black)
                    VStack{
                        
                        
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct shop_View_Previews: PreviewProvider {
    static var previews: some View {
        shop_View()
    }
}
