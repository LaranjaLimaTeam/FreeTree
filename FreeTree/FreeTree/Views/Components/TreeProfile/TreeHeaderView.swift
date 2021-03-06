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
                    presentationMode.wrappedValue.dismiss()
                    startRoute()
                }
            }
            ImageHeader(treeViewModel: treeViewModel)
            .padding(.horizontal, 16)
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
