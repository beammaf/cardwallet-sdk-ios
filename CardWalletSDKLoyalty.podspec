Pod::Spec.new do |s|
    s.name              = 'CardWalletSDKLoyalty'
    s.version           = '1.0.17'
    s.summary           = 'Card Management SDK Provided by Beam UAE'
    s.homepage          = 'http://beamuae.app/'
    s.dependency        'Moya/RxSwift', '14.0.0'
    s.dependency        'Stripe', '~>  14.0.0'
    s.dependency        'MBProgressHUD', '~> 1.1.0'
    s.dependency        'SkyFloatingLabelTextField', '~> 3.0'

    s.author            = { 'Name' => 'developer@beamuae.app' }
    s.license           = { :type => 'MIT', :file => 'LICENSE' }

    s.platform          = :ios
    s.source            = { :git => 'https://github.com/beammaf/cardwallet-sdk-ios.git',:branch => 'loyalty'}

    s.ios.deployment_target = '11.0'
    s.swift_version = '4.2'
    s.ios.vendored_frameworks = 'CardWalletSDKLoyalty.framework', 'CardIO.framework'
    s.requires_arc = true
end
