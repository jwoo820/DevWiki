//
//  CommonView.swift
//  Config
//
//  Created by yuraMacBookPro on 12/12/24.
//

import SwiftUI

public struct CommonView: View {
    public init() {}
    
    @State private var showSheet: Bool = false
    public var body: some View {
        VStack {
            Text("CommonView 입니다")
            
            Button {
                showSheet.toggle()
            } label: {
                Text("하프시트")
            }

        }
        .halfSheet(showSheet: $showSheet) {
            Text("하프시트 입니다")
        } onConfirm: {
            
        } onEnd: {
            
        } onFail: {
            
        }

        
    }
}

#Preview {
    CommonView()
}
