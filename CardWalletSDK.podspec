Pod::Spec.new do |s|
    s.name              = 'CardWalletSDK'
    s.version           = '0.2.1'
    s.summary           = 'Card Management SDK Provided by Beam UAE'
    s.homepage          = 'http://beamuae.app/'
    s.dependency        'Moya/RxSwift', '~> 12.0'
    s.dependency        'Stripe', '~>  14.0.0'
    s.dependency        'MBProgressHUD', '~> 1.1.0'
    s.dependency        'SwiftyRSA', '~> 1.5.0'

    s.author            = { 'Name' => 'developer@beamuae.app' }
    s.license           = { :type => 'MIT', :file => 'LICENSE' }

    s.platform          = :ios
    s.source            = { :git => 'https://github.com/beammaf/cardwallet-sdk-ios.git',:branch => 'refactorDependencies'}

    s.ios.deployment_target = '11.0'
    s.ios.vendored_frameworks = 'CardWalletSDK.framework', 'CardIO.framework'
    s.requires_arc = true
end
