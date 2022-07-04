import Foundation
import Combine
import CoreLocation
import UIKit
import SwiftUI

import FirebaseStorage

class TreeProfileViewModel: ObservableObject {
    @Published var tree: Tree
    @Published var distance: Double = 0
    @Published var comments: [Comment] = []
    @Published var photos: [Image] = []
    @Published var dbPhotos: [Photo] = []
    private let locationManager = LocationManager.shared
    var cancellable: Cancellable?
    private let treeManager = TreeManagerImplementation.shared

    init(tree: Tree) {
        self.tree = tree
        cancellable =  self.locationManager.$locationCoordinate
            .map { coordinate in
                let distance = self.getDistance(coordinate: tree.coordinates)
                return distance
            }.sink(receiveValue: { distance in
                self.distance = distance
            })
    }

    func getStringDate(inputDate: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
//        let date =  dateFormatter.date(from: tree.creationTimeStamp)!
//        var newDate = date.formatted()
        var newDate = inputDate
        let start = newDate.index(newDate.startIndex, offsetBy: 0)
        let end = newDate.index(newDate.startIndex, offsetBy: 10)
        let range = start..<end
        let newDateSubstring = newDate[range]
        newDate = String(newDateSubstring)
        return newDate
    }

    func getDistance(coordinate: Coordinate) -> Double {
        guard let distanceInMeters = locationManager.getDistance(coordinates: coordinate) else {return 0}
        let distanceInKm: Double = distanceInMeters*1.0/1000
        return distanceInKm
    }
    
    func insertComment(comment: Comment) {
        print("Comentário inserido")
        self.comments.insert(comment, at: 0)
        self.updateComment(comment: comment)
    }
    
    func addPhoto(photo: UIImage?) {
        if let takenImage = photo {
            let fireBaseManager = FireBaseManager()
            guard let treeId = self.tree.id else { return }
            guard let imageData = takenImage.pngData() else { return }
            let photo = Photo(treeId: treeId)
            self.dbPhotos.append(photo)
            fireBaseManager.addData(data: photo, collection: FireBaseManager.photoCollection)
            
            let storageRef = Storage.storage().reference().child("images/\(photo.treeId)/\(photo.id!).png")
            storageRef.putData(imageData, metadata: nil){ (metadata, error) in
                guard let metaData = metadata else {
                    print("encontramos um erro aqui")
                    return
                }
                if let err = error {
                    print("Erro ao salvar foto: \(err)")
                }
                storageRef.downloadURL(completion: { (url, error) in
                    guard let downloadURL = url?.absoluteString else { return }
                    // save this URL to your database as usual
                })
            }
            
        }
        
        
    }
    
    func fetchPhotos() {
        let fireBaseManager = FireBaseManager()
        fireBaseManager.getData(collection: FireBaseManager.photoCollection) { (dbPhotos: [Photo]?) in
            if let safePhotos = dbPhotos {
                guard let treeId = self.tree.id else { return }
                let treePhotosIds = safePhotos.filter { item in
                    item.treeId == treeId
                }
                for photo in treePhotosIds {
                    let photoReference = Storage.storage().reference().child("images/\(photo.treeId)/\(photo.id!).png")
                    photoReference.getData(maxSize: 30*1024*1024) { data, err in
                        if let error = err {
                            print("Erro ao baixar arquivo")
                        } else {
                            let image = UIImage(data: data!)!
                            if !self.photos.contains(Image(uiImage: image)) {
                                self.photos.append(Image(uiImage: image))
                                self.dbPhotos.append(photo)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func deletePhotos() {
        let fireBaseManager = FireBaseManager()
        fireBaseManager.getData(collection: FireBaseManager.photoCollection) { (dbPhotos: [Photo]?) in
            if let safePhotos = dbPhotos {
                guard let treeId = self.tree.id else { return }
                let treePhotosIds = safePhotos.filter { item in
                    item.treeId == treeId
                }
                for photo in treePhotosIds {
                    let photoReference = Storage.storage().reference().child("images/\(photo.treeId)/\(photo.id!).png")
                    photoReference.delete { error in
                        if let err = error {
                            print("Failed to delete \(err)")
                        }
                    }
                }
            }
        }
    }
    
    func updateComment(comment: Comment) {
        let fireBaseManager = FireBaseManager()
        fireBaseManager.addData(data: comment, collection: FireBaseManager.commentCollection)
    }
    
    func fetchComment() {
        let fireBaseManager = FireBaseManager()
        fireBaseManager.getData(collection: FireBaseManager.commentCollection) { (comments: [Comment]?) in
            if let safeComments = comments {
                self.comments = safeComments.filter({ item in
                    if let treeId = self.tree.id {
                        return treeId == item.treeId
                    }
                    return false
                })
            }
        }
    }
}
