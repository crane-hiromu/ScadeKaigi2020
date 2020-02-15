
import ScadeKit

/* https://app.swaggerhub.com/apis/jmatsu/droidkaigi/2020 */

struct Constants {
    
    // MARK: Structs	
    
    struct API {
        static let baseURL: String = "https://api.droidkaigi.jp/2020/"
    }
    
    struct Tag {
        static let on: String = "res/iconTagOn.png"
        static let off: String = "res/iconTagOff.png"
        
        static func icon(by id: String) -> String {
            let contains = UserDefaultsHelper.sessionIds.arrayString?.contains(id)
            return (contains == true) ? on : off
        }
    }
    
    enum PageType: String {
        case timeTable, speakersList, profile, session, map
        
        var page: String {
            return "\(rawValue).page"
        }
    }
    
    #if os(iOS)
    static var hasNotch: Bool {
        return 20.0 < UIApplication.shared.statusBarFrame.height // todo
    }
    #endif
}


// MARK: - Common Methods

/* https://github.com/scadedoc/UgExamples/blob/master/UgBitmapDemo/src/main.page.swift */

#if os(Android)
func dataToString(data: SF_NSData, isUtf8: Bool) -> String {
    let enc = isUtf8 ? String.Encoding.utf8 : String.Encoding.isoLatin1
    let nsstring = SF_NSString(bytes: data.bytes, length: Int(data.length), encoding: enc.rawValue)
    
    return String(nsstring)
}
#else
func dataToString(data: Data, isUtf8: Bool) -> String {
    return String(data: data, encoding: isUtf8 ? .utf8 : .isoLatin1)!
}
#endif
