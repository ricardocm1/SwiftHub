//
//  NumericInfoView.swift
//  SwiftHub
//
//  Created by Ricardo Carra Marsilio on 29/10/20.
//

import SwiftUI

struct NumericInfoView: View {
    let value: Int
    let title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(value.description)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(title)
                .font(.footnote)
                .foregroundColor(.discreteGray)
        }
    }
}

struct NumericInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NumericInfoView(value: 22, title: "test title")
    }
}
