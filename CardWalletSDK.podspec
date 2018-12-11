Pod::Spec.new do |s|
    s.name              = 'CardWalletSDK'
    s.version           = '0.0.1'
    s.summary           = 'Card Management SDK Provided by Beam UAE'
    s.homepage          = 'http://example.com/'

    s.author            = { 'Name' => 'developer@beamuae.app' }
    s.license           = { :type => 'MIT', :file => 'LICENSE' }

    s.platform          = :ios
    s.source            = { :http => 'https://github.com/beammaf/cardwallet-sdk-ios/blob/CocoaPods/CardWalletSDK.zip?raw=true'}

    s.ios.deployment_target = '11.0'
    s.ios.vendored_frameworks = 'CardWalletSDK.framework'
    s.requires_arc = true
end
