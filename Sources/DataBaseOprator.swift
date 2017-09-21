import MySQL
import PerfectLib
/// 0 : 成功 1：失败
let codeKey = "code"
let msgKey = "msg"
let dataKey = "data"
var baseResponseJson :[String:Any] = [codeKey:0,dataKey:[],msgKey:""]
/// 数据库操作类
class DataBaseOprator {
    
    class var mysql : MySQL{
        get{
            return DataBaseConnect.shareInstance.mysql
        }
    }
}
/// 用户操作类
class UserOprator: DataBaseOprator {
    
    /// 查询用户名密码是否匹配
    ///
    /// - Parameters:
    ///   - phone: 用户名
    ///   - password: 密码
    /// - Returns: 返回json
    class func userLogin(phone:String,password:String) -> String? {
        if !queryRegisted(phone: phone) {
            baseResponseJson[codeKey] = 1
            baseResponseJson[msgKey] = "账号尚未注册，请先注册"
            baseResponseJson[dataKey] = []
            Log.info(message: "账号尚未注册" + "SELECT * FROM tb_user where phone = '\(phone)' and password = '\(password)'")
        }else if !mysql.query(statement: "SELECT * FROM tb_user where phone = '\(phone)' and password = '\(password)'"){
            baseResponseJson[codeKey] = 1
            baseResponseJson[msgKey] = "查询出错"
            baseResponseJson[dataKey] = []
            Log.info(message: "查询出错 " + "SELECT * FROM tb_user where phone = '\(phone)' and password = '\(password)'")
        }
        else {
            let results = mysql.storeResults()!

            if results.numRows() == 0{
                baseResponseJson[codeKey] = 1
                baseResponseJson[msgKey] = "手机号或密码错误"
                baseResponseJson[dataKey] = []
                Log.info(message: "手机号或密码错误 " + "SELECT * FROM tb_user where phone = '\(phone)' and password = '\(password)'")
            }
            else{
                baseResponseJson[codeKey] = 0
                baseResponseJson[msgKey] = "成功"
                var responseDict :[String:Any] = [:]
                results.forEachRow(callback: { (row) in
                   responseDict["userId"] = row[0]
                    responseDict["nickName"] = row[2]
                    responseDict["number"] = row[3]
                })
                baseResponseJson[dataKey] = responseDict
                Log.info(message: "成功 " + "SELECT * FROM tb_user where phone = '\(phone)' and password = '\(password)'")
            }

        }
        do {
            return try baseResponseJson.jsonEncodedString()
        } catch{
            return nil
        }
    }
    
    /// 注册
    ///
    /// - Parameters:
    ///   - phone: 账号
    ///   - nickname: 昵称
    ///   - password: 密码
    /// - Returns: <#return value description#>
    class func userRegister(phone:String,nickname : String,password:String) -> String? {
        if queryRegisted(phone: phone) {
            baseResponseJson[codeKey] = 1
            baseResponseJson[msgKey] = "账号已注册，请登录"
            baseResponseJson[dataKey] = []
            Log.info(message: "账号已注册" + "INSERT INTO tb_user (phone,nickname,password) VALUES ('\(phone)','\(nickname)','\(password)')")
        }else if !mysql.query(statement: "INSERT INTO tb_user (phone,nickname,password) VALUES ('\(phone)','\(nickname)','\(password)')") {
            baseResponseJson[codeKey] = 1
            baseResponseJson[msgKey] = "插入失败"
            baseResponseJson[dataKey] = []
            Log.info(message: "插入失败 " + "INSERT INTO tb_user (phone,nickname,password) VALUES ('\(phone)','\(nickname)','\(password)')")
        }
        else{
            baseResponseJson[codeKey] = 0
            baseResponseJson[msgKey] = "成功"
            baseResponseJson[dataKey] = []
            Log.info(message: "成功 " + "INSERT INTO tb_user (phone,nickname,password) VALUES ('\(phone)','\(nickname)','\(password)')")
        }
        do {
            return try baseResponseJson.jsonEncodedString()
        } catch{
            return nil
        }
    }
    /// 查询账号是否已经注册
    ///
    /// - Parameter phone: 账号
    /// - Returns: <#return value description#>
    class func queryRegisted(phone:String) -> Bool {
        if !mysql.query(statement: "SELECT * FROM tb_user where phone = '\(phone)'") {
            return false
        }
        else if (mysql.storeResults()?.numRows())! >= 1{
            return true
        }
        else{
            return false
        }
    }
}
