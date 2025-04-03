//
//  StorageManager.swift
//  BillMinder
//
//  Created by Gabriel on 01/04/25.
//

import Foundation
import Supabase
import UIKit

final class StorageManager {
    static let shared = StorageManager()
    
    private init() {}
    
    func uploadPhoto(_ photoData: Data, fileName: String) async throws -> FileUploadResponse {
        let path = "\(fileName)-\(Int.random(in: 1...10000)).png"
        let result = try await supabaseStorageClient.from("service-images").upload(path, data: photoData)
        
        return result
    }
    
    func downloadPhoto(path: String) async throws -> UIImage {
        let data = try await supabaseStorageClient.from("service-images").download(path: path)
        if let uiImage = UIImage(data: data) {
            return uiImage
        }
        
        return UIImage(named: "image-placeholder")!
    }
}
