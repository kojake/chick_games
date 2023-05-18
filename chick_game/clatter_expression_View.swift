//
//  clatter_expression_View.swift
//  chick_game
//
//  Created by kaito on 2023/05/18.
//

import SwiftUI

struct clatter_expression_View: View {
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Color.black // 背景を黒に設定
            
            Image("egg") // 表示する画像の名前を指定
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200) // 画像のサイズを適切に設定
                .rotationEffect(isAnimating ? .degrees(30) : .degrees(0))
                .animation(Animation.easeInOut(duration: 0.5).repeatCount(6))
                .onAppear {
                    isAnimating = true // アニメーションを開始
                }
            if isAnimating {
                Color.white // ものすごい光を表す白いビューを表示
                    .opacity(0.5)
                    .blendMode(.screen)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct clatter_expression_View_Previews: PreviewProvider {
    static var previews: some View {
        clatter_expression_View()
    }
}
