import Foundation
import Combine
import CoreLocation

class TreeProfileViewModel: ObservableObject {
    @Published var tree: Tree
    @Published var distance: Double = 0
    @Published var comments:[Comment] = []
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
    
    func updateTree() {
        treeManager.addTree(tree: self.tree) { result in
            switch result {
            case .success(let tree):
                print("Salvo com sucesso")
            case .failure(let error):
                print("Erro ao atualizar arvore")
            }
        }
    }
    
    func updateComment(comment: Comment) {
        let jsonManager = JsonManager()
        _ = jsonManager.saveJson(data: comment, fileName: "comment.json")
    }
    
    func fetchComment() {
        let jsonManager = JsonManager()
        self.comments = jsonManager.decodingJson(fileName: "comment.json") ?? []
    }
}
