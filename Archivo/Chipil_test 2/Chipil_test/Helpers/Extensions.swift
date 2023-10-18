//
//  Extensions.swift
//  Chipil_test
//
//  Created by ximena juana mejia jacobo on 11/10/23.
//

import SwiftUI
extension View{
    
    func convertToScrollView<Content: View>(@ViewBuilder content: @escaping ()->Content)->UIScrollView{
        
        let scrollView = UIScrollView()
        
        let hostingController = UIHostingController(rootView: content()).view!
        hostingController.translatesAutoresizingMaskIntoConstraints = false
        
        
        let constraints = [
        
            hostingController.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        
           hostingController.widthAnchor.constraint(equalToConstant: screenBounds().width)
            
        ]
        scrollView.addSubview(hostingController)
        scrollView.addConstraints (constraints)
        scrollView.layoutIfNeeded()
        
        return scrollView
    }
    
    func exportPDF<Content: View>(@ViewBuilder content: @escaping ()->Content,completion: @escaping(Bool,URL?)->() ){
        
        let seze = convertToScrollView{
            content()
        }.contentSize
        
        let documentoDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let outputFileURL = documentoDirectory.appendingPathComponent("YOURPDFNAME\(UUID().uuidString).pdf")
        let pdfView = convertToScrollView{
            content()
        }
        pdfView.tag = 1009
        
        let size = pdfView.contentSize
        pdfView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height )
        getRootController().view.insertSubview(pdfView, at: 0)
        
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        do{
            try renderer.writePDF(to: outputFileURL, withActions: {context in
                
                context.beginPage()
                pdfView.layer.render(in: context.cgContext)
            })
            completion(true,outputFileURL)
            }//do
        catch {
            completion(false,nil)
            print(error.localizedDescription)
            }
        getRootController().view.subviews.forEach { view in
            if view.tag == 1009{
                print("removed")
                view.removeFromSuperview()
                }
            
            }
        
        }
    
    
    func screenBounds()->CGRect{
        return UIScreen.main.bounds
    }
    
    func getRootController()->UIViewController{
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }
    
    
    
}
