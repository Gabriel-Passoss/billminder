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
    
    var path: String
    
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
                   // Properly handle the async call with try and await
                   let image = try await StorageManager.shared.downloadPhoto(path: path)
                   
                   // Update UI on the main thread
                   await MainActor.run {
                       self.uiImage = image
                   }
                   
                   isLoading = false
               } catch {
                   print("Failed to load image: \(error)")
                   // Handle error appropriately
               }
           }
       }
}

#Preview {
    ServiceImageView(path: "hbo-logo.png")
}
