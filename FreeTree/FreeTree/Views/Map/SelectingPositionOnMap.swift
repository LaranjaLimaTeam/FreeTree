import SwiftUI

struct SelectingPositionOnMap: View {
    
    @ObservedObject var mapViewModel: MapViewModel
    
    @State var distanceError = false
    
    var body: some View {
        
        if mapViewModel.selectingPosition == true {
            ZStack(alignment: .center) {
                Image("tree-placemark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                VStack {
                    Spacer()
                    HStack {
                        Button {
                            print("Cancelei arvore")
                            mapViewModel.currentCenterLocation = nil
                            mapViewModel.selectingPosition = false
                        } label: {
                            Text("Cancelar")
                                .font(.body)
                                .fontWeight(.semibold)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(16)
                        }
                        
                        Button {
                            print("To pegando localizaçao")
                            print(mapViewModel.currentCenterLocation)
                            let result = mapViewModel.verifyAvailableDistance()
                            if result {
                                mapViewModel.selectingPosition = false
                                mapViewModel.showAddTreeSheet.toggle()
                            } else {
                                self.distanceError = true
                                print("Erro")
                            }
                        } label: {
                            Text("Posicionar Árvore")
                                .font(.body)
                                .fontWeight(.semibold)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(16)
                        }
                        
                    }
                }
            }
            .alert(isPresented: $distanceError) {
                Alert(title: Text("Erro!"),
                      message: Text("Você está muito longe da posição selecionada."),
                      dismissButton: .default(
                        Text("OK")
                      )
                )
            }
        } else {
            EmptyView()
        }
        
    }
}

struct SelectingPositionOnMap_Previews: PreviewProvider {
    static var previews: some View {
        SelectingPositionOnMap(mapViewModel: MapViewModel())
    }
}

