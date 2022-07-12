import SwiftUI
import Combine

struct TreeHeaderView: View {
    let tagLimit: Int
    @ObservedObject var treeViewModel: TreeProfileViewModel
    @State var pageControl = 0
    var startRoute: () -> Void
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(treeViewModel.tree.name)
                .font(.title3)
                .fontWeight(.semibold)
                .padding([.leading, .top], 16)
                Spacer()
                StartRouteButton(iconName: "arrow.triangle.turn.up.right.circle") {
                    startRoute()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            ImageHeader(treeViewModel: treeViewModel)
            .padding(.horizontal, 16)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 2*UIScreen.main.bounds.height/20/3)
                        .foregroundColor(.green)
                    TagList(tags: treeViewModel.tree.tags,
                            tagLimit: tagLimit, cellWidth: UIScreen.main.bounds.width/4)
                }
            }
            .padding(.horizontal, 16)
            .frame(height: UIScreen.main.bounds.height/20)
            DistanceView(distance: treeViewModel.distance)
                .padding(.leading, 16)
           
        }
    }
}

struct TreeHeaderView_Previews: PreviewProvider {
    static var presentationMode: UISheetPresentationController.Detent.Identifier = .medium
    static let tree = Tree()
    static var previews: some View {
        TreeHeaderView(tagLimit: 4,
                       treeViewModel: TreeProfileViewModel(tree: tree),
                       startRoute: {return}
        )
    }
}

struct DistanceView: View {
    let distance: Double
    var body: some View {
        HStack {
            Image(systemName: "mappin.and.ellipse")
                .foregroundColor(.green)
            Text("\(String(format: "%.1f", distance)) km de distância")
                .font(.footnote)
        }
    }
}
