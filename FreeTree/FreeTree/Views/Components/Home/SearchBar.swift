import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @Binding var searching: Bool
    let searchAction: () -> Void
    let cleanData: () -> Void
<<<<<<< HEAD
    let placeHolderText: String
=======
>>>>>>> Componente da SearchBar implementado
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .foregroundColor(Color.init(uiColor: UIColor.lightGray))
                    .opacity(0.4)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.gray)
                        .padding(.leading, 8)
<<<<<<< HEAD
                    TextField(placeHolderText, text: $searchText).onSubmit {
=======
                    TextField("Digite o nome do livro", text: $searchText).onSubmit {
>>>>>>> Componente da SearchBar implementado
                        searching = true
                        searchAction()
                    }
                    Spacer()
                    Button {
                        searching = false
                        cleanData()
                        searchText = ""
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(Color.gray)
                            .padding(.trailing, 13)
                    }
                }
            }
            .cornerRadius(8)
            .padding(.leading, 16)
        }.frame(height: 38)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(
            searchText: .constant(""),
            searching: .constant(true),
            searchAction: {return},
<<<<<<< HEAD
            cleanData: {return},
            placeHolderText: "Pesquisar"
        )
=======
            cleanData: {return})
>>>>>>> Componente da SearchBar implementado
    }
}
