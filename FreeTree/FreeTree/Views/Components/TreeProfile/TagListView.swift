import SwiftUI

struct TagView: View {
    let tagText: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(.green, lineWidth: 1.5)
                .opacity(0.9)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.green)
                        .opacity(0.4)
                )
                
            Text(tagText)
                .font(.footnote)
                .foregroundColor(.green)
        }
    }
}

struct TagList: View {
    let tree: Tree
    let cellSize: CGSize
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(0..<tree.tags.count) { tagIndex in
                    TagView(tagText: tree.tags[tagIndex])
                        .frame(width: cellSize.width, height: cellSize.height)
                    
                }
            }
        }
    }
}
