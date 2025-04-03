//
//  ServiceImageView.swift
//  BillMinder
//
//  Created by Gabriel on 03/04/25.
//

import SwiftUI

struct ServiceImageView: View {
    @State private var uiImage: UIImage? = nil
    @State private var isLoading = true
    
    // Support both path and data
    var path: String?
    var imageData: Data?
    
    // Initialize with path
    init(path: String) {
        self.path = path
        self.imageData = nil
    }
    
    // Initialize with data
    init(imageData: Data) {
        self.imageData = imageData
        self.path = nil
    }
    
    var body: some View {
        Group {
            if isLoading {
                ProgressView()
                    .frame(width: 50, height: 50)
            } else {
                if let image = uiImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 50, height: 50)
                } else {
                    // Placeholder while loading
                    Image("service-placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .frame(width: 50, height: 50)
                }
            }
        }
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        Task {
            do {
                // Handle different sources
                if let path = path {
                    // Load from path
                    let image = try await StorageManager.shared.downloadPhoto(path: path)
                    
                    await MainActor.run {
                        self.uiImage = image
                    }
                } else if let data = imageData {
                    // Load from data
                    let image = UIImage(data: data)
                    
                    await MainActor.run {
                        self.uiImage = image
                    }
                }
                
                isLoading = false
            } catch {
                print("Failed to load image: \(error)")
                // Handle error appropriately
                isLoading = false
            }
        }
    }
}


#Preview {
    ServiceImageView(path: "hbo-logo.png")
}
