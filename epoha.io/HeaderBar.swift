//
//  HeaderBar.swift
//  epoha.io
//
//  Created by constantine kos on 03.06.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import SwiftUI

struct HeaderBar: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .foregroundColor(Color("Golden"))
                .frame(width: 52, height: 52)
                .background(Color("Background"))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .shadow(color: Color("DarkShadow"), radius: 6, x: 6, y: 6)
                .shadow(color: Color("LightShadow"), radius: 6, x: -6, y: -6)
        }
    }
}

struct HeaderBar_Previews: PreviewProvider {
    static var previews: some View {
        HeaderBar()
    }
}
