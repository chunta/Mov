#source 'https://github.com/CocoaPods/Specs.git'

#Add the following line to prevent "cocoapods [!] [Xcodeproj] Generated duplicate UUIDs" console warnings
install! 'cocoapods', :deterministic_uuids => false

platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!
def common_pods
    pod 'EVReflection/MoyaRxSwift'
    pod 'SwiftSpinner', '~> 1.4'
    pod 'UILoadControl'
    pod 'GearRefreshControl', '~> 1.0.0'
    pod 'SDWebImage', '~> 4.1'
end


target 'MovieSearch' do
    common_pods
end
