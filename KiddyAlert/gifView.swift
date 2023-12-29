//
//  gifView.swift
//  KiddyAlert
//
//  Created by user on 10/12/2023.
//



import SwiftUI
import ImageIO
import MobileCoreServices

struct gifView: View {
    var body: some View {
        VStack {
            GIFImageView(gifName: "list1") // Replace "example_gif" with the name of your GIF file
                .frame(width: 10, height: 10)
        }
    }
}


struct GIFImageView: UIViewRepresentable {
    let gifName: String
    
    func makeUIView(context: Context) -> UIImageView {
        guard let gifURL = Bundle.main.url(forResource: gifName, withExtension: "gif") else {
            fatalError("GIF file not found")
        }
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.loadGif(url: gifURL)
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {}
}

extension UIImageView {
    func loadGif(url: URL) {
        guard let imageSource = CGImageSourceCreateWithURL(url as CFURL, nil) else {
            return
        }
        
        let frameCount = CGImageSourceGetCount(imageSource)
        var frames: [UIImage] = []
        var gifDuration = 0.0
        
        for i in 0..<frameCount {
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else {
                continue
            }
            
            if let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) as? [String: Any],
               let gifInfo = properties[kCGImagePropertyGIFDictionary as String] as? [String: Any] {
                
                if let delayTime = gifInfo[kCGImagePropertyGIFDelayTime as String] as? Double {
                    gifDuration += delayTime
                }
            }
            
            frames.append(UIImage(cgImage: cgImage))
        }
        
        animationImages = frames
        animationDuration = gifDuration
        animationRepeatCount = 0
        startAnimating()
    }
}


#Preview {
    gifView()
}
