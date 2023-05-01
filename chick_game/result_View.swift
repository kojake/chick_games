//
//  result_View.swift
//  chick_game
//
//  Created by kaito on 2023/05/01.
//

import SwiftUI

struct result_View: View {
    var body: some View {
        NavigationView{
            ZStack{
                Color.green.ignoresSafeArea()
                VStack{
                    Text("結果").font(.largeTitle).fontWeight(.black)
                    
                    //goal_text
                    Text("!GOAL!").font(.largeTitle).fontWeight(.black)
                    Text("").frame(height: 10)
                    //残り秒数
                    Text("残り秒数：").font(.largeTitle).fontWeight(.black)
                    //コインの獲得数
                    Text("").frame(height: 10)
                    Text("獲得コイン").font(.largeTitle).fontWeight(.black)
                    HStack{
                        Image("money").resizable().scaledToFit().frame(width: 100)
                        Text("x10").font(.largeTitle).fontWeight(.black)
                    }
                }
            }
        }
    }
}
struct result_View_Previews: PreviewProvider {
    static var previews: some View {
        result_View()
    }
}
