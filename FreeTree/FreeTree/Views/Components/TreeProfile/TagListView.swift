import SwiftUI

struct TagView: View {
    let tagText: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.green)
            Text(tagText)
                .font(.footnote)
                .foregroundColor(.white)
        }
    }
}

struct TagList: View {
    let tags: [String]
    let tagLimit: Int
    let cellWidth: CGFloat
    var tagsSize: Int {
        return tags.count
    }

    var body: some View {
        ForEach(0..<tagLimit) { tagIndex in
            if (tagIndex == tagLimit-1) && (tagsSize > tagLimit) {
                TagView(tagText: "+\(tagsSize - (tagLimit-1))")
                    .frame(width: cellWidth)
            } else if tagIndex <= tagsSize-1 {
                TagView(tagText: tags[tagIndex])
                    .frame(width: cellWidth)
            } else {
                EmptyView()
            }
        }
    }
}
