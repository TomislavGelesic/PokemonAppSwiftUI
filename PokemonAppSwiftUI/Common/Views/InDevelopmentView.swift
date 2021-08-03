//
//  InDevelopmentView.swift
//  PokemonAppSwiftUI
//
//  Created by Tomislav Gelesic on 03.08.2021..
//

import SwiftUI
import Lottie

struct InDevelopmentView: View {
    var body: some View {
            VStack(spacing: 20) {
                Text("COMING SOON ...")
                    .foregroundColor(.orange)
                LottieView(name: "PikachuAnimation", loopMode: .loop)
            }.padding()
    }
}

struct InDevelopmentView_Previews: PreviewProvider {
    static var previews: some View {
        InDevelopmentView()
    }
}
