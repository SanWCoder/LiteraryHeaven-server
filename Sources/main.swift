import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import MySQL
let testHost = "127.0.0.1"
let testUser = "root"
let testPassword = "123456"
let testDB = "LiteraryDB"

func fetchData(response:HTTPResponse) {
    let mysql = MySQL() // 创建一个MySQL连接实例
    let connected = mysql.connect(host: testHost, user: testUser, password: testPassword)
    guard connected else {
        // 验证一下连接是否成功
        print(mysql.errorMessage())
        return
    }
    defer {
        mysql.close() //这个延后操作能够保证在程序结束时无论什么结果都会自动关闭数据库连接
    }
    // 选择具体的数据Schema
    guard mysql.selectDatabase(named: testDB) else {
        Log.info(message: "数据库选择失败。错误代码：\(mysql.errorCode()) 错误解释：\(mysql.errorMessage())")
        return
    }
    // 运行查询（比如返回在options数据表中的所有数据行）
    let querySuccess = mysql.query(statement: "SELECT * FROM tb_user")
    // 确保查询完成
    guard querySuccess else {
        return
    }
    // 在当前会话过程中保存查询结果
    let results = mysql.storeResults()! //因为上一步已经验证查询是成功的，因此这里我们认为结果记录集可以强制转换为期望的数据结果。当然您如果需要也可以用if-let来调整这一段代码。
    results.forEachRow { row in
        Log.info(message: "\(row)")
    }
    Log.info(message: "连接成功")
    response.appendBody(string: "mysql连接成功")
    response.completed()
}
/// 1.创建Server
let server = HTTPServer()
/// 2.创建路由表
var routes = Routes()
/// 3.添加路由到路由表
routes.add(method: .get, uri: "/login") { (request, response) in
    fetchData(response: response)
}
/// 4.将路由表添加到Server
server.addRoutes(routes)
/// 1.1 监听8181端口
server.serverPort = 8181
/// 5.启动Server
do {
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("网络出现错误：\(err) \(msg)")
}


