//
//  TestUL_1_Controller.swift
//  strx
//
//  Created by IOS3 on 2018/12/12.
//  Copyright © 2018 IOS3. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa



// MARK: 网络请求
fileprivate class GithubService {
    
    /// 验证用户是否存在
    func usernameValilable(_ username: String) -> Observable<Bool> {
        let url = URL(string: "https://github.com/\(username.URLEscaped)")!
        let request = URLRequest(url: url)
        return URLSession.shared.rx.response(request: request)
            .map { pair in
                return pair.response.statusCode == 404
            }
            .catchErrorJustReturn(false)
    }
    /// 注册用户
    func sigup(_ username: String, password: String) -> Observable<Bool> {
        let signupResult = arc4random() % 3 == 0 ? false : true
        return Observable.just(signupResult)
            .delay(1.5, scheduler: MainScheduler.instance)
    }
}



//MARK: 用户注册验证服务
// 验证结果和信息的枚举
fileprivate enum ValidationResult {
    /// 正在验证中
    case validating
    /// 空输入
    case empty
    /// 验证通过
    case ok(message: String)
    /// 验证失败
    case failed(message: String)
}
// ValidationResult拓展, 对应不同验证结果, 返回成功还是失败
extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}
//扩展ValidationResult，对应不同的验证结果返回不同的文字描述
extension ValidationResult: CustomStringConvertible {
    var description: String {
        switch self {
        case .validating:
            return "正在验证"
        case .empty:
            return ""
        case let .ok(message):
            return message
        case let .failed(message):
            return message
        }
    }
}
//扩展ValidationResult，对应不同的验证结果返回不同的文字颜色
extension ValidationResult {
    var textColor: UIColor {
        switch self {
        case .validating:
            return UIColor.gray
        case .empty:
            return UIColor.black
        case .ok:
            return UIColor(red: 0/255, green: 130/255, blue: 0/255, alpha: 1)
        case .failed:
            return UIColor.red
        }
    }
}




//扩展String
extension String {
    //字符串的url地址转义
    var URLEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}



// MARK: 将用户名、密码等各种需要用到的验证封装起来
// 用户注册服务
fileprivate class GithubSignupService {
    /// 密码最少位数
    let minPasswordCount = 5
    
    /// 网络请求服务
    lazy var networkService = {
        return GithubService()
    }()
    
    ///验证用户名
    func validateUsername(_ username: String) -> Observable<ValidationResult> {
        if username.isEmpty {
            return .just(.empty)
        }
        if username.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            return .just(.failed(message: "用户名只能包含数字和字母"))
        }
        return networkService
            .usernameValilable(username)
            .map { available in
                if available {
                    return .ok(message: "用户名可用")
                }
                else {
                    return .failed(message: "用户名已存在")
                }
        }.startWith(.validating)
    }
    
    /// 验证密码
    func validatePassword(_ password: String) -> ValidationResult {
        let numberOfCharacters = password.count
        if numberOfCharacters == 0 {
            return .empty
        }
        if numberOfCharacters < minPasswordCount {
            return .failed(message: "密码至少需要 \(minPasswordCount) 个字符")
        }
        return .ok(message: "密码有效")
    }
    
    /// 验证二次输入的密码
    func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> ValidationResult {
        if repeatedPassword.count == 0 {
            return .empty
        }
        if repeatedPassword == password {
            return .ok(message: "密码有效")
        }
        else {
            return .failed(message: "两次输入的密码不一致")
        }
    }
}



//MARK: ViewModel
fileprivate class GithubSignupViewModel {
    
    let validatedUsername: Driver<ValidationResult>
    let validatedPassword: Driver<ValidationResult>
    let validatedPasswordRepeated: Driver<ValidationResult>
    
    let signupEnabled: Driver<Bool>
    let signingIn: Driver<Bool>
    let signupResult: Driver<Bool>
    
    init(
        input: (
        username: Driver<String>,
        password: Driver<String>,
        repeatedPassword: Driver<String>,
        loginTaps: Signal<Void>
        ),
        dependency: (
        networkService: GithubService,
        signupService: GithubSignupService
        )) {
        // 验证用户名
        validatedUsername = input.username
            .flatMapLatest { username in
                return dependency.signupService.validateUsername(username)
                    .asDriver(onErrorJustReturn: .failed(message: "服务器发生错误"))
        }
        
        validatedPassword = input.password
            .map { password in
                return dependency.signupService.validatePassword(password)
        }
        validatedPasswordRepeated = Driver.combineLatest(
            input.password,
            input.repeatedPassword,
            resultSelector: dependency.signupService.validateRepeatedPassword
        )
        
        signupEnabled = Driver.combineLatest(
            validatedUsername,
            validatedPassword,
            validatedPasswordRepeated
        ) { username, password, repeatedPassword in
            username.isValid && password.isValid && repeatedPassword.isValid
            }.distinctUntilChanged()
        
        // 获取最新的用户名 和 密码
        let usernameAndPassword = Driver.combineLatest(input.username, input.password) {
            (username: $0, password: $1)
        }
        
        let activityIndicator = ActivityIndicator()
        self.signingIn = activityIndicator.asDriver()
        
        // 注册按钮点击效果
        signupResult = input.loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest { pair in
                return dependency.networkService.sigup(pair.username, password: pair.password)
                    .trackActivity(activityIndicator) // 把当前序列仿佛 signing 序列中进行检查
                    .asDriver(onErrorJustReturn: false)
        }
    }
}


// MARK: ViewModel 与视图的绑定

fileprivate extension Reactive where Base: UILabel {
    var validationResult: Binder<ValidationResult> {
        return Binder(base) { label, result in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}



class TestUL_1_Controller: BaseController {
    
    
    @IBOutlet weak var unTF: UITextField!
    @IBOutlet weak var pwTF: UITextField!
    @IBOutlet weak var pwvTF: UITextField!
    
    @IBOutlet weak var unLB: UILabel!
    @IBOutlet weak var pwLB: UILabel!
    @IBOutlet weak var pwvLB: UILabel!
    
    @IBOutlet weak var rgBtn: UIButton!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewModel = GithubSignupViewModel(
            input: (
                username: unTF.rx.text.orEmpty.asDriver(),
                password: pwTF.rx.text.orEmpty.asDriver(),
                repeatedPassword: pwvTF.rx.text.orEmpty.asDriver(),
                loginTaps: rgBtn.rx.tap.asSignal()
                ),
            dependency: (
                networkService: GithubService(),
                signupService: GithubSignupService()
                )
        )
        
        viewModel.validatedUsername
            .drive(unLB.rx.validationResult)
            .disposed(by: disposeBag)
        viewModel.validatedPassword
            .drive(pwLB.rx.validationResult)
            .disposed(by: disposeBag)
        viewModel.validatedPasswordRepeated
            .drive(pwvLB.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.signupEnabled
            .drive(onNext: { [weak self] valid in
                self?.rgBtn.isEnabled = valid
                self?.rgBtn.alpha = valid ? 1.0 : 0.3
            })
            .disposed(by: disposeBag)
        
        viewModel.signingIn
            // .drive(UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .drive(indicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.signupResult
            .drive(onNext: { [weak self] result in
                self?.showMessage("注册" + (result ? "成功" : "失败") + "!")
            })
            .disposed(by: disposeBag)
    }
    func showMessage(_ message: String) {
        let alertController = UIAlertController(title: nil,
                                                message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

   

}
