import Foundation
import Combine
import CoreLocation

class TreeProfileViewModel: ObservableObject {
    
    @Published var tree: Tree
    @Published var distance: Double = 0
    @Published var comments: [Comment] = []
    
    private let locationManager = LocationManager.shared
    private let commentRepository: CommentRepository
    
    var cancellable: Cancellable?

    init(tree: Tree) {
        self.tree = tree
        self.commentRepository = FirebaseCommentRepository()
        
        cancellable =  self.locationManager.$locationCoordinate
            .map { coordinate in
                let distance = self.getDistance(coordinate: tree.coordinates)
                return distance
            }.sink(receiveValue: { distance in
                self.distance = distance
            })
    }
    
    private func orderCommentsFromMostRecent(_ comments: [Comment]) -> [Comment] {
        return comments.sorted { c1, c2 in
            Date.from(c1.date) >= Date.from(c2.date)
        }
    }
    
    public func fetchComments() {
        guard let treeId = self.tree.id else { return }
        
        commentRepository.fetchComments(for: treeId) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let comments):
                strongSelf.comments = strongSelf.orderCommentsFromMostRecent(comments)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func insertComment(comment: Comment) {
        commentRepository.add(comment) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let comment):
                strongSelf.comments.insert(comment, at: 0)
            case .failure(let failure):
                print(failure)
            }
        }
    }

    func getStringDate(inputDate: String) -> String {
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
}
