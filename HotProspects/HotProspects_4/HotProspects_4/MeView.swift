//
//  MeView.swift
//  HotProspects_4
//
//  Created by David Stanton on 4/25/24.
//
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @AppStorage("name") private var name = "Anonymous"
    @AppStorage("emailAddress") private var emailAddress = "me@email.com"
    @State private var qrCode = UIImage()
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.headline)
                TextField("Email", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.headline)
                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .contextMenu {
                        ShareLink(item: Image(uiImage: qrCode), preview: SharePreview("QR Code", image: Image(uiImage: qrCode)))
                    }
            }
            .navigationTitle(name)
            .onAppear(perform: updateCode)
            .onChange(of: name, updateCode)
            .onChange(of: emailAddress, updateCode)
        }
    }
    func updateCode() {
        qrCode = generateQRCode(for: "\(name)\n\(emailAddress)")
    }
    
    func generateQRCode(for string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    MeView()
}
