//
//  RadioButton.swift
//  DevWikiUI
//
//  Created by yuraMacBookPro on 12/13/24.
//

import SwiftUI

struct RadioButton: View {

    @Environment(\.colorScheme) var colorScheme

    let id: String
    let callback: (String)->()
    let selectedID : String

    let subLabel: String?
    var isSelected: Bool {
        get {
            return selectedID == id
        }
    }
    
    init(_ id: String, selectedID: String, subLabel: String? = nil, callback: @escaping (String)->()) {
        self.id = id
        self.selectedID = selectedID
        self.callback = callback
        self.subLabel = subLabel
    }
    
    var body: some View {
        Button {
            callback(self.id)
        } label: {
            HStack(alignment: .center, spacing: 8) {
                Image(systemName: isSelected ? "inset.filled.circle" : "circle")
//                Image(isSelected ? R.Icon.Assets.radioButtonEnable : R.Icon.Assets.radioButtonDisable)
                
                Text(id)
//                    .font(isSelected ? R.Font.medium1 : R.Font.body0)
//                    .foregroundStyle(isSelected ? R.Color.gray800 : R.Color.gray600)
                    
                Spacer()
                if let subLabel = subLabel {
                    Text(subLabel)
//                        .font(R.Font.medium1)
//                        .foregroundStyle(R.Color.orange500)
                }
            }
        }
        .padding([.top, .bottom], 11)
    }
}

struct RadioButtonGroup: View {
    let items: [String]
    @Binding var selectedId: String
    let callback: (String) -> ()
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(items, id: \.self) { id in
                RadioButton(id, selectedID: selectedId, callback: radioGroupCallback)
                    .padding(0)
            }
        }
    }
    
    func radioGroupCallback(id: String) {
        selectedId = id
        callback(id)
    }
}

struct RadioButton_Previews: PreviewProvider {
    @State private static var selectedId: String = "NG"
    
    static var previews: some View {
        RadioButtonGroup(items: ["OK","NG"], selectedId: $selectedId) { result in
            print(result)
            selectedId = result
        }
    }
}
