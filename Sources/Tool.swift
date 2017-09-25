import Foundation
import PerfectCrypto

extension String{

    func md5() -> String {
        let  digestLen : [UInt8] = self.digest(.md5)!
        let hash = NSMutableString()
        for item in digestLen {
            hash.appendFormat("%02x", item)
        }
        return String(format: hash as String)
    }
}
