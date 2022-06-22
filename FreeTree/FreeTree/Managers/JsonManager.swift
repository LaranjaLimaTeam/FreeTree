import Foundation

struct JsonManager {
    static public func decoding<T: Decodable>(fileName: String) -> T? {
        let filePath = Bundle.main.url(forResource: fileName, withExtension: "json")
        if let file = filePath {
            do {
                let data = try Data(contentsOf: file)
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
            let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            print(directory)
            let filePath = directory.appendingPathComponent("JSON").appendingPathComponent("myJsonData.json")
            do {
                try codableJSON.write(to: filePath, options: [.atomic])
                print("JSON updated")
            } catch {
                print("Error while saving to path. Error: \(error)")
                do {
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
