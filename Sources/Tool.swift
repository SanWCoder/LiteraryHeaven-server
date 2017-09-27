import Foundation
import PerfectCrypto


/// 网络错误码
public enum netCode : Int{
    /// 成功
    case success = 0
    /// 失败
    case error = 1
    /// 数据库操作出错
    case oprataError = 2
    /// 参数出错
    case paramError = 3
    /// 用户已注册
    case registered = 100
    /// 用户未注册
    case register = 101
    /// 用户已登录
    case userLogined = 102
    /// 用户未登录
    case userLogin = 103
    /// 用户密码错误
    case pwsError = 104
    public var description: String {
        switch self {
        case .success:  return "success"
        case .error:      return "error"
        case .oprataError:     return "oprata error"
        case .registered:     return "user was registered"
        case .register:    return "user are not registered"
        case .userLogined:      return "user was logined"
        case .userLogin:   return "user are not login"
        case .pwsError:    return "paassword is error"
        case .paramError:    return "param is error"
        }
    }
}

/// 文章
public enum groupType{
    case loveTopic
    case wedding
    case weddingDress
}
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
