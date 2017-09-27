import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import MySQL

/// 1.创建Server
let server = HTTPServer()
server.documentRoot = "./webroot"
/// 1.1 监听8181端口
server.serverPort = 8181
/// 1.2 服务端地址
//server.serverAddress = "127.0.0.0"
/// 2.创建路由表
var routes = Routes()
/// 3.添加路由到路由表
routes.add(method: .post, uri: "/users/login") { (request, response) in
    guard (request.param(name: "phone") != nil) else{
        response.appendBody(string: "缺少用户名参数")
        response.completed()
        return
    }
    guard (request.param(name: "password") != nil) else{
        response.appendBody(string: "缺少密码参数")
        response.completed()
        return
    }
    response.appendBody(string:UserOprator.userLogin(phone:request.param(name: "phone")!,password:request.param(name: "password")!)!)
    response.completed()
}
routes.add(method: .post, uri: "/users/register") { (request, response) in
    guard (request.param(name: "verify") != nil) else{
        response.appendBody(string: "缺少验证码参数")
        response.completed()
        return
    }
    guard (request.param(name: "phone") != nil) else{
        response.appendBody(string: "缺少用户名参数")
        response.completed()
        return
    }
    guard (request.param(name: "password") != nil) else{
        response.appendBody(string: "缺少密码参数")
        response.completed()
        return
    }
    guard (request.param(name: "nickname") != nil) else{
        response.appendBody(string: "缺少昵称参数")
        response.completed()
        return
    }
    response.appendBody(string:UserOprator.userRegister(phone: request.param(name: "phone")!, nickname: request.param(name: "nickname")!, password: request.param(name: "password")!,uuid:request.header(HTTPRequestHeader.Name.custom(name: "uuid"))!)!)
        response.completed()
}
routes.add(method: .put, uri: "/users/updateInfo") { (request, response) in
    response.appendBody(string:UserOprator.updateUserInfo(request: request)!)
    response.completed()
}
routes.add(method: .get, uri: "/articles/article") { (request, response) in
    response.appendBody(string:articleOprator.articleInfo(request: request)!)
    response.completed()
}
/// 4.将路由表添加到Server
server.addRoutes(routes)
/// 5.启动Server
do {
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("网络出现错误：\(err) \(msg)")
}


