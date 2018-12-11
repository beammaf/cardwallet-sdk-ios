Pod::Spec.new do |s|
    s.name              = 'CardWalletSDK'
    s.version           = '0.0.1'
    s.summary           = 'Credit card management sdk provided by Beam UAE'
    s.homepage          = 'https://beamuae.app/'

    s.author            = { 'Name' => 'developer@beamuae.app' }
    s.license           = { :type => 'MIT', :file => 'LICENSE' }

    s.platform          = :ios
    s.source            = { :http => 'link to your cocoapods .zip attachment' }
    s.source_files      = "CardWalletSDK.h"
    s.ios.deployment_target = '12.0'
    s.ios.vendored_frameworks = 'CardWalletSDK.framework'
end
