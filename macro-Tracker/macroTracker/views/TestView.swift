//
//  TestView.swift
//  macroTracker
//
//  Created by Serdar Onur KARADAĞ on 16.09.2022.
//

import SwiftUI

struct TestView: View {
    @State var number = 0
    var body: some View {
        VStack {
            Text("Deneme yazısı yazıyorum")
            Text("Umarın her şey düzelir.")
            Text("\(number)")
            Button("Tıkla", action: {
                number += 1
            })
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
