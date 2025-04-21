//
//  ContentView.swift
//  Instafilter
//
//  Created by Carlos Eduardo Witte on 09/04/25.
//

import SwiftUI
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins
import StoreKit

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 10.00
    @State private var filterScale = 10.0
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingFilters = false
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    @State private var currentFilter : CIFilter = CIFilter.sepiaTone()
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
                
                if selectedItem != nil {
                    Text(currentFilter.name)
                        .padding()
                }
                
                Spacer()
                
                // Challenge 2: Experiment with having more than one slider, to control each of the input keys you care about. For example, you might have one for radius and one for intensity.
                if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
                    HStack {
                        Text("Intensity")
                        Slider(value: $filterIntensity, in: 0...1)
                            .onChange(of: filterIntensity, applyProcessing)
                            .disabled(selectedItem == nil) // Challenge 1: Try making the Slider and Change Filter buttons disabled if there is no image selected.
                    }
                }
                
                // Challenge 2: Experiment with having more than one slider, to control each of the input keys you care about. For example, you might have one for radius and one for intensity.
                if currentFilter.inputKeys.contains(kCIInputScaleKey) {
                    HStack {
                        Text("Scale")
                        Slider(value: $filterScale, in: 1...100)
                            .onChange(of: filterScale, applyProcessing)
                            .disabled(selectedItem == nil) // Challenge 1: Try making the Slider and Change Filter buttons disabled if there is no image selected.
                    }
                }
                
                // Challenge 2: Experiment with having more than one slider, to control each of the input keys you care about. For example, you might have one for radius and one for intensity.
                if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
                    HStack {
                        Text("Radius")
                        Slider(value: $filterRadius, in: 100...1000)
                            .onChange(of: filterRadius, applyProcessing)
                            .disabled(selectedItem == nil) // Challenge 1: Try making the Slider and Change Filter buttons disabled if there is no image selected.
                    }
                }
                
                HStack {
                    Button("Change Filter", action: changeFilter)
                        .disabled(selectedItem == nil) // Challenge 1: Try making the Slider and Change Filter buttons disabled if there is no image selected.
                    
                    Spacer()
                    
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle(Text("Instafilter"))
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Cystallize") { setFilter(CIFilter.crystallize())}
                Button("Edges") { setFilter(CIFilter.edges())}
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur())}
                Button("Pixellate") { setFilter(CIFilter.pixellate())}
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone())}
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask())}
                Button("Vignette") { setFilter(CIFilter.vignette())}
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func changeFilter() {
        showingFilters = true
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {
                return
            }
            
            guard let inputImage = UIImage(data: imageData) else {
                return
            }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            
            applyProcessing()
        }
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) // Challenge 2: Experiment with having more than one slider, to control each of the input keys you care about. For example, you might have one for radius and one for intensity.
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey) // Challenge 2: Experiment with having more than one slider, to control each of the input keys you care about. For example, you might have one for radius and one for intensity.
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale, forKey: kCIInputScaleKey) // Challenge 2: Experiment with having more than one slider, to control each of the input keys you care about. For example, you might have one for radius and one for intensity.
        }
        
        
        guard let outputImage = currentFilter.outputImage else {
            return
        }
        
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return
        }
        
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        
        filterCount += 1
        
        if filterCount >= 20 {
            requestReview()
        }
    }
    
    init() {
        filterCount = 0
    }
}

#Preview {
    ContentView()
}
