import Foundation

struct JsonManager {
    static let defaultJson = "myJsonData.json"
    
    public func decodingJson<T: Decodable>(fileName: String) -> [T]? {
        let fileManager = FileManager.default
        let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = directoryURL.appendingPathComponent("JSON").appendingPathComponent(fileName)
        do {
            let data = try Data(contentsOf: fileURL)
            let jsonData = try JSONDecoder().decode([T].self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
        
        return nil
    }
    
    public func saveJson<T: Codable>(data: T, fileName: String) -> T? {
        var dataArray: [T]? = decodingJson(fileName: fileName)
        if var safeDataArray = dataArray {
            safeDataArray.append(contentsOf: [data])
            dataArray = safeDataArray
        } else {
            dataArray = [data]
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let codableJSON = try encoder.encode(dataArray)
            let fileManager = FileManager.default
            let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = directoryURL.appendingPathComponent("JSON").appendingPathComponent(fileName)
            do {
                try codableJSON.write(to: fileURL, options: [.atomic])
                return data
            } catch {
                print("Error while saving to path. Error: \(error)")
                do {
                    try fileManager.createDirectory(at: directoryURL.appendingPathComponent("JSON"),
                                                    withIntermediateDirectories: false)
                    try codableJSON.write(to: fileURL, options: [.atomic])
                    return data
                } catch {
                    print("Error when creating file, Error: \(error)")
                    return nil
                }
            }
        } catch {
            print("Failed to encode, error: \(error)")
            return nil
        }
    }
}
