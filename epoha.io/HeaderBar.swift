//
//  HeaderBar.swift
//  epoha.io
//
//  Created by constantine kos on 03.06.2020.
//  Copyright © 2020 constantine kos. All rights reserved.
//

import SwiftUI

struct HeaderBar: View {
    @State var showLoginView = false
    
    var body: some View {
        HStack {
            Button(action: {
                self.showLoginView.toggle()
            }) {
                Image(systemName: "person.circle")
                    .modifier(SquereButtons())
                
            }.sheet(isPresented: $showLoginView) {
                LoginView()
            }
            
        }
    }
}

struct HeaderBar_Previews: PreviewProvider {
    static var previews: some View {
        HeaderBar()
    }
}
