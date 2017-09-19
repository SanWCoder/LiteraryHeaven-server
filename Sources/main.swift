import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import MySQL

/// 1.创建Server
let server = HTTPServer()
server.documentRoot = "./webroot"
/// 2.创建路由表
var routes = Routes()
/// 3.添加路由到路由表
routes.add(method: .get, uri: "/login") { (request, response) in
    guard (request.param(name: "username") != nil) else{
        response.appendBody(string: "缺少用户名参数")
        response.completed()
        return
    }
    guard (request.param(name: "password") != nil) else{
        response.appendBody(string: "缺少密码参数")
        response.completed()
        return
    }
    let userOprator = UserOprator()
    response.appendBody(string:userOprator.queryUserInfo(userName:request.param(name: "username")!,password:request.param(name: "password")!))
    response.completed()
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


