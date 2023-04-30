//
//  ContentView.swift
//  chick_game
//
//  Created by kaito on 2023/04/30.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button(action: {
                    print("Button")
                }) {
                    Image(systemName: "gearshape.fill")
                        .padding()
                        .frame(width: 70, height: 70)
                        .imageScale(.large)
                        .foregroundColor(Color.white)
                        .background(Color.green)
                        .clipShape(Circle())
                }
            }
            Spacer()
            HStack{
                Image("hiyoko").resizable().scaledToFit().frame(width: 100, height: 100)
                Text("ひよこゲーム").font(.largeTitle).fontWeight(.black).foregroundColor(.yellow)
                Image("hiyoko").resizable().scaledToFit().frame(width: 100, height: 100).rotation3DEffect(.degrees(180), axis: (0, 1, 0))
            }
            Text("ステージ選択").padding().fontWeight(.black)
            ScrollView(.horizontal) {
                HStack{
                    ForEach(0..<2){index in
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.gray)
                            .frame(width: 250, height: 200)
                    }
                }
            }
            Spacer()
            //スタートボタン
            Button(action: {
                print("Button")
            }) {
                Text("START")
                    .bold()
                    .padding()
                    .frame(width: 200, height: 100)
                    .foregroundColor(Color.white)
                    .background(Color.purple)
                    .cornerRadius(10)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
