//
//  HalfSheetController.swift
//  DevWikiUI
//
//  Created by yuraMacBookPro on 12/16/24.
//

import SwiftUI
import UIKit

extension View {
    public func halfSheet<SheetView: View>(
        showSheet: Binding<Bool>,
        @ViewBuilder sheetView: @escaping () -> SheetView,
        onConfirm: @escaping () -> (),
        onEnd: @escaping () -> (),
        onFail: @escaping () -> ()
    ) -> some View {
        
        return self
            .background(
                HalfSheetHelper(
                                sheetView: sheetView(),
                                showSheet: showSheet,
                                onConfirm: onConfirm,
                                onEnd: onEnd,
                                onFail: onFail)
            )
    }
}


public struct HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable {
    var sheetView: SheetView
    @Binding var showSheet: Bool
    var onConfirm: () -> ()
    var onEnd: () -> ()
    var onFail: () -> ()
    
    let controller = UIViewController()

    public func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    
    public func makeUIViewController(context: Context) -> some UIViewController {
        controller.view.backgroundColor = .clear

        return controller
    }
    
    public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if showSheet && uiViewController.presentedViewController == nil {
            let sheetController = CustomHostingController(rootView: rootViewWithHeader(context: context))
            sheetController.presentationController?.delegate = context.coordinator
            uiViewController.present(sheetController, animated: true)
        }
    }
    
    public class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        var parent: HalfSheetHelper
        
        init(parent: HalfSheetHelper) {
            self.parent = parent
        }
        
        public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            parent.showSheet = false
            parent.onEnd()
        }
    }
    
    func rootViewWithHeader(context: Context) -> some View {
        ZStack {
            Color.white
            VStack {
                sheetView
                Spacer()
                
            }
            .padding()
        }
        .ignoresSafeArea()
    }
    
    func dismissSheet() async {
        await MainActor.run {
            // UIWindowScene을 통해 dismiss 호출
            if let windowScene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                
                if let rootVC = windowScene.windows.first?.rootViewController {
                    rootVC.dismiss(animated: true) {
                        self.showSheet = false
                    }
                }
            }
        }
    }
}

class CustomHostingController<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        
        view.backgroundColor = .clear
        
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium(), .large()]
            
            presentationController.prefersGrabberVisible = true
        }
    }
}
