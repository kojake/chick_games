//
//  clatter_expression_View.swift
//  chick_game
//
//  Created by kaito on 2023/05/18.
//

import SwiftUI

struct clatter_expression_View: View {
    @State var showShould_clatter_result_VIew = false
    @State var degress = 1
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.yellow
                     .ignoresSafeArea()
                NavigationLink(destination: clatter_result(), isActive: $showShould_clatter_result_VIew){
                    EmptyView()
                }
                Image("egg") // 表示する画像の名前を指定
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(Double(degress)))
                    .onAppear {
                        var loop: Timer?
                        loop = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                            if degress >= 0{
                                degress += 1
                            }
                            
                            if degress == 360{
                                showShould_clatter_result_VIew = true
                                loop?.invalidate()
                            }
                        }
                    }
            }
            .edgesIgnoringSafeArea(.all)
        }.navigationBarBackButtonHidden(true)
    }
    func End_processing(){
        showShould_clatter_result_VIew
    }
}

struct clatter_expression_View_Previews: PreviewProvider {
    static var previews: some View {
        clatter_expression_View()
    }
}
