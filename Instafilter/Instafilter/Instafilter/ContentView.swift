//
//  ContentView.swift
//  Instafilter
//
//  Created by David Stanton on 3/30/24.
//
// ==== ContentView ====
// import CoreImage / ...CIFilterBuiltins / PhotosUI / SwiftUI
// var for processedImage / filterIntensity / selectedItem / currentFilter (set to Sepia) / showingFilters / filterCount / requestReivew / context
// NavStack with a PhotosPicker showing processedImage or ContentUnavailable
// Intensity Slider
// Change Filter Button
// If we have a processedImage, create a link to show it
// ConfirmationDialog with all options for changing filter: Crystallize, edges, gaussain blur, pixellate, sepia, unsharpen mask, vignette, cancel
//
// func changeFilter() toggles showingFilters
//
// func loadImage
// asyncronously get raw data from selectedItem or return (imageData)
// convert the raw image to UIImage or return (inputImage)
// convert the UIImage to a CIImage (beginImage)
// apply the currentFilter to the CIImage with a kCIInputImageKey
// applyProcessing
//
// func applyProcessing()
// set inputKeys to the currentFilter inputKeys
// for kCIInputIntensity, Radius, Scale, set the filterItensity to that
// apply currentFilter or return (outputImage)
// create a cgImage from context of the output or return (cgImage)
// create uiImage from the cgImage (uiImage)
// assign it to the processedImage
//
// func setFilter that accepts a CIFilter
// sets the currentFilter to that filter, then loadImage()
// increments filterCount, if filterCount >= 20, requestReview

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 3.0
    @State private var filterScale = 5.0
    @State private var selectedItem: PhotosPickerItem?
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var showingFilters = false
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                    HStack {
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity, applyProcessing)
                            .disabled(processedImage == nil)
                    }
                    .padding(.vertical, 1)
                }
                if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                    HStack {
                        Text("Radius")
                        Slider(value: $filterRadius, in: 0...200)
                            .onChange(of: filterRadius, applyProcessing)
                            .disabled(processedImage == nil)
                    }
                    .padding(.vertical, 3)
                }
                if currentFilter.inputKeys.contains(kCIInputScaleKey) {
                    HStack {
                        Text("Scale")
                        Slider(value: $filterScale, in: 0...10)
                            .onChange(of: filterScale, applyProcessing)
                            .disabled(processedImage == nil)
                    }
                    .padding(.vertical, 1)
                }
                
                HStack {
                    Button("Change Filter", action: changeFilter)
                        .disabled(processedImage == nil)
                    
                    Spacer()
                    
                    // share the picture
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter Image", image: processedImage))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Bloom") { setFilter(CIFilter.bloom() )}
                Button("Crystallize") { setFilter(CIFilter.crystallize() )}
                Button("Edges") { setFilter(CIFilter.edges() )}
                Button("Gaussaian Blur") { setFilter(CIFilter.gaussianBlur() )}
                Button("Noir") { setFilter(CIFilter.photoEffectNoir() )}
                Button("Pixellate") { setFilter(CIFilter.pixellate() )}
                Button("Pointillize") { setFilter(CIFilter.pointillize() )}
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone() )}
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask() )}
                Button("Vignette") { setFilter(CIFilter.vignette() )}
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    // func changeFilter() toggles showingFilters
    func changeFilter() {
        showingFilters = true
    }
    // func loadImage
    // asyncronously get raw data from selectedItem or return (imageData)
    // convert the raw image to UIImage or return (inputImage)
    // convert the UIImage to a CIImage (beginImage)
    // apply the currentFilter to the CIImage with a kCIInputImageKey
    // applyProcessing
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
    // func applyProcessing()
    // set inputKeys to the currentFilter inputKeys
    // for kCIInputIntensity, Radius, Scale, set the filterItensity to that
    // apply currentFilter or return (outputImage)
    // create a cgImage from context of the output or return (cgImage)
    // create uiImage from the cgImage (uiImage)
    // assign it to the processedImage
    func applyProcessing() {
        let  inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    // func setFilter that accepts a CIFilter
    // sets the currentFilter to that filter, then loadImage()
    // increments filterCount, if filterCount >= 20, requestReview
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        
        filterCount += 1
        
        if filterCount >= 20 {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
