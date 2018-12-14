Pod::Spec.new do |s|
    s.name              = 'CardWalletSDK'
    s.version           = '0.1.4'
    s.summary           = 'Card Management SDK Provided by Beam UAE'
    s.homepage          = 'http://beamuae.app/'
    s.dependency 'Moya/ReactiveSwift', '~> 12.0'
    s.dependency 'Moya/RxSwift', '~> 12.0'
    s.dependency 'Stripe'
    s.dependency 'RxCocoa'
    s.dependency 'MBProgressHUD', '~> 1.1.0'
    s.dependency 'SwiftyRSA'
    s.dependency 'RxBlocking'



    s.author            = { 'Name' => 'developer@beamuae.app' }
    s.license           = { :type => 'MIT', :file => 'LICENSE' }

    s.platform          = :ios
    s.source            = { :git => 'https://github.com/beammaf/cardwallet-sdk-ios.git',:branch => 'CocoaPods'}

    s.ios.deployment_target = '11.0'
    s.ios.vendored_frameworks = 'CardWalletSDK.framework', 'ReactiveMoya.framework', 'RxMoya.framework'
    s.requires_arc = true
end
