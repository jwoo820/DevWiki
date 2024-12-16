import SwiftUI
import DevWikiUI
import DevWikiCore

public struct ContentView: View {
    public init() {}

    @State var id: String = "OK"
    
    public var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
            CommonView()
            RadioButtonGroup(items: ["OK", "NG"], selectedId: $id) { result in
                id = result
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
