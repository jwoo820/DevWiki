//
//  ZoomableScrollView.swift
//  DevWikiUI
//
//  Created by yuraMacBookPro on 12/12/24.
//

import SwiftUI
import UIKit

public struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    var content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()

        // ScrollView 설정
        scrollView.minimumZoomScale = 1.0  // 최소 줌 비율
        scrollView.maximumZoomScale = 5.0  // 최대 줌 비율
        scrollView.delegate = context.coordinator

        // SwiftUI 콘텐츠를 호스팅하는 UIHostingController 추가
        let hostedView = UIHostingController(rootView: content)
        hostedView.view.translatesAutoresizingMaskIntoConstraints = false
        hostedView.view.backgroundColor = .clear

        scrollView.addSubview(hostedView.view)

        // 제약 조건 설정 (스크롤과 확대를 모두 지원하기 위해 제약 조건을 제대로 설정)
        NSLayoutConstraint.activate([
            hostedView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostedView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostedView.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostedView.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            // ScrollView의 너비에 맞추기
            hostedView.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

        ])

        return scrollView
    }

    public func updateUIView(_ uiView: UIScrollView, context: Context) {
        // 스크롤 뷰의 콘텐츠 크기 업데이트
        if let hostedView = uiView.subviews.first {
            hostedView.invalidateIntrinsicContentSize()
        }
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    public class Coordinator: NSObject, UIScrollViewDelegate {
        public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            // 확대/축소할 뷰를 반환
            return scrollView.subviews.first
        }
    }
}

// MARK: - For Preview Test

public struct ZoomableScrollView_Previews: PreviewProvider {
    public init() { }
    
    public static var previews: some View {
        ZoomableScrollView {
            Text(ZoomableScrollText.dummyText)
        }
    }
}

public enum ZoomableScrollText {
    public static let dummyText = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur turpis ex, maximus nec felis dignissim, placerat vestibulum lacus. Nullam dui nunc, vestibulum ut placerat quis, faucibus sed metus. Pellentesque aliquet risus non justo blandit pellentesque. Fusce vel efficitur velit. Integer semper eu massa a vestibulum. Cras laoreet odio at massa ullamcorper accumsan. Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut pulvinar felis sed libero porttitor iaculis. Ut facilisis mauris et nisl ultrices blandit. Maecenas metus augue, ultricies at metus ut, hendrerit aliquam ligula. Vestibulum condimentum sodales metus in tincidunt. Donec ut blandit arcu.

Sed quis lectus dictum, ultricies ante non, pharetra mi. Aenean fermentum nisi eget placerat aliquet. Donec mattis scelerisque dolor, ut fringilla dolor. Integer at dolor cursus, euismod odio et, viverra mauris. Proin hendrerit sem placerat lacus tristique ornare. Etiam cursus scelerisque sapien, non ultricies felis ullamcorper vel. Nunc luctus eget arcu eu commodo.

Aliquam tempus risus enim, non consectetur est sollicitudin quis. Vestibulum imperdiet fringilla massa quis mattis. Nullam accumsan quam id nisi mattis cursus. Curabitur malesuada ex ac ante commodo elementum. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed felis felis, congue a sagittis in, euismod sit amet ex. Duis porta, arcu et pellentesque viverra, quam ante sodales odio, vitae volutpat diam nulla maximus felis. Phasellus egestas faucibus nunc, eget finibus sapien rutrum ut. Nunc ut faucibus sapien. Nam et neque orci. Quisque vel mauris mauris. Morbi tempus quam nec turpis malesuada vehicula. Donec convallis nibh nisi, sit amet mattis neque rutrum et. Nunc massa enim, lobortis id enim eget, fermentum congue lorem. Morbi tincidunt mollis velit at malesuada.

Cras rhoncus pretium elementum. Nam iaculis augue vel diam iaculis, et maximus ante tincidunt. Morbi imperdiet venenatis gravida. Fusce a congue diam. Maecenas sit amet accumsan orci. Nunc in velit dolor. Mauris consectetur, nunc a malesuada mollis, orci dolor varius felis, eu suscipit ligula nisl at nisi.

Etiam erat turpis, lacinia eget lacus et, vulputate porttitor lorem. In dapibus eget felis lacinia dictum. Suspendisse pulvinar in ipsum at dapibus. Morbi dignissim libero in nisl finibus condimentum. Fusce vestibulum malesuada erat, ac aliquam lectus porttitor ac. Nulla mattis gravida magna at feugiat. Maecenas convallis porttitor sapien, sed interdum lacus bibendum vitae. Donec congue, nisl quis luctus tristique, erat dui porta enim, id finibus dui turpis vel odio. Ut ut augue at turpis porta finibus sit amet consectetur nibh. Cras efficitur libero eu tempus efficitur. Praesent ornare pulvinar metus vitae accumsan. Proin nibh lorem, ornare sit amet risus eu, fermentum finibus turpis. Duis vel mi sed lectus rhoncus vulputate in ut ex. Duis id metus porttitor, tincidunt turpis a, consectetur metus. Maecenas vehicula arcu elementum nunc aliquet, et rhoncus felis imperdiet.
"""
}
