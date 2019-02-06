Pod::Spec.new do |s|
    s.name              = 'CardWalletSDK'
    s.version           = '0.1.23'
    s.summary           = 'Card Management SDK Provided by Beam UAE'
    s.homepage          = 'http://beamuae.app/'
    s.dependency = 'BeamCore'


    s.author            = { 'Name' => 'developer@beamuae.app' }
    s.license           = { :type => 'MIT', :file => 'LICENSE' }

    s.platform          = :ios
    s.source            = { :git => 'https://github.com/beammaf/cardwallet-sdk-ios.git',:branch => 'master'}

    s.ios.deployment_target = '11.0'
    s.ios.vendored_frameworks = 'CardWalletSDK.framework'
    s.requires_arc = true
end
