import Foundation

struct JsonManager {
    static public func decoding<T: Decodable>(fileName: String) -> T? {
        let filePath = Bundle.main.url(forResource: fileName, withExtension: "json")
        if let safeFilePath = filePath {
            do {
                let data = try Data(contentsOf: safeFilePath)
                let result = try JSONDecoder().decode(T.self, from: data)
                return result
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
            let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = directoryURL.appendingPathComponent("JSON").appendingPathComponent("myJsonData.json")
            do {
                try codableJSON.write(to: fileURL, options: [.atomic])
            } catch {
                print("Error while saving to path. Error: \(error)")
                do {
                    try fileManager.createDirectory(at: directoryURL.appendingPathComponent("JSON"),
                                                    withIntermediateDirectories: false)
                    try codableJSON.write(to: fileURL, options: [.atomic])
                } catch {
                    print("Error when creating file, Error: \(error)")
                }
            }
        } catch {
            print("Failed to encode, error: \(error)")
        }
    }
}
