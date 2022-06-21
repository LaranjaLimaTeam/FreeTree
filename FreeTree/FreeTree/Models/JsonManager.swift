import Foundation

struct DecodificadorJson {
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

    static public func saveJson<T: Encodable>(fileName nomeArquivo: String, data: T) {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let codableJSON = try encoder.encode(data)
            let fileManager = FileManager.default
            let currentPath = fileManager.currentDirectoryPath
            let jsonPath = (currentPath + "/JSON")
            guard let documentsDirectoryPath = NSURL(string: jsonPath) else { return }
            if let pathWithFileName = documentsDirectoryPath.appendingPathComponent("myJsonData") {
                do {
                    try codableJSON.write(to: pathWithFileName)
                } catch {
                    // handle error
                    print("Error while saving to path. Error: \(error.localizedDescription)")
                }
        }
        } catch {
            print("Failed to encode, error: \(error.localizedDescription)")
        }
    }
}
