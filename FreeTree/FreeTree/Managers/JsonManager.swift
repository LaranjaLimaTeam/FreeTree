import Foundation

struct JsonManager {
    static public func decoding<T: Decodable>(fileName nomeArquivo: String) -> T? {
        let caminhoDoArquivo = Bundle.main.url(forResource: nomeArquivo, withExtension: "json")
        if let arquivo = caminhoDoArquivo {
            do {
                let data = try Data(contentsOf: arquivo)
                let resultado = try JSONDecoder().decode(T.self, from: data)
                return resultado
            } catch {
                print(error)
            }
        }
        return nil
    }

    static public func saveJson<T: Encodable>(data: T) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let codableJSON = try encoder.encode(data)
            let fileManager = FileManager.default
            // Pego o diretorio de documentos
            let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            // Adiciono a pasta JSON ao path e o arquivo myJsonData
            print(directory)
            let filePath = directory.appendingPathComponent("JSON").appendingPathComponent("myJsonData.json")
            do {
                // Tento escrever no JSON
                try codableJSON.write(to: filePath, options: [.atomic])
                print("JSON updated")
            } catch {
                // handle error
                print("Error while saving to path. Error: \(error)")
                do {
                    //Tento criar o diretorio caso nao exista
                    try fileManager.createDirectory(at: directory.appendingPathComponent("JSON"),
                                                    withIntermediateDirectories: false)
                    try codableJSON.write(to: filePath, options: [.atomic])
                    print("File created")
                } catch {
                    print("Error when creating file, Error: \(error)")
                }
            }
        } catch {
            print("Failed to encode, error: \(error)")
        }
    }
}
