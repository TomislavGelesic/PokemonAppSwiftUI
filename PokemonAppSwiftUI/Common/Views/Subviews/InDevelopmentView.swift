//
//  InDevelopmentView.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 03.08.2021..
//

import SwiftUI
import Lottie

struct InDevelopmentView: View {
    let lottieView: LottieView = LottieView(animationJsonFileName: "PikachuAnimation", loopMode: .loop)
    var body: some View {
        VStack(spacing: 20) {
            Text("COMING SOON ...")
                .foregroundColor(Color("ThemeForegroundColor"))
                .font(.system(size: 30))
            lottieView
                .onAppear(perform: {
                    lottieView.startAnimation()
                })
        }
        .padding()
    }
}

struct InDevelopmentView_Previews: PreviewProvider {
    static var previews: some View {
        InDevelopmentView()
    }
}
