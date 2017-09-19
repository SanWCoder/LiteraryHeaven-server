import MySQL

/// 数据库操作类
class DataBaseOprator {
    let dataBaseName = "LiteraryDB"
    var mysql : MySQL{
        get{
            return DataBaseConnect.shareInstance.mysql
        }
    }
    init() {
        guard mysql.selectDatabase(named: dataBaseName) else {
            return
        }
    }
}

/// 用户操作类
class UserOprator: DataBaseOprator {
    
    /// 查询用户名密码是否匹配
    ///
    /// - Parameters:
    ///   - userName: 用户名
    ///   - password: 密码
    /// - Returns: 返回json
    func queryUserInfo(userName:String,password:String) -> String {
        let query = mysql.query(statement: "SELECT * FROM tb_user where user_name = '\(userName)' and user_pws = '\(password)'")
        guard query else {
            return "查询失败"
        }
        let result = mysql.storeResults()!
        guard result.numRows() != 0 else{
            return "没有此信息"
        }
        do {
            return try ["code":0,"msg":"succes"].jsonEncodedString()
        } catch{
            return "Jason转化错误"
        }
    }
}
