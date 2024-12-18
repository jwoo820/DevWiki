import SwiftUI
import Combine
import Core
import Shared

public struct ContentView: View {
    public init() {}

    @State var id: String = "OK"
    @StateObject private var viewModel: ResponseViewModel = ResponseViewModel()
    
    private let cancellables: Set<AnyCancellable> = []
    
    @State private var showSheet: Bool = false
    
    public var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
            CommonView()
            RadioButtonGroup(items: ["OK", "NG"], selectedId: $id) { result in
                id = result
            }
            Button {
                showSheet.toggle()
            } label: {
                Text("메인화면 버튼")
            }

        }
        .halfSheet(showSheet: $showSheet) {
            Text("DevWIki 메인화면")
        } onConfirm: {
             
        } onEnd: {
             
        } onFail: {
             
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
