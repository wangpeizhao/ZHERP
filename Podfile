# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

platform :ios, '10.0'
inhibit_all_warnings!

def libraries
  # pod 'Alamofire'
  pod 'Moya'
  pod 'Moya/RxSwift'
  # pod 'Moya/ReactiveSwift'
  pod 'Moya-ObjectMapper'
  pod 'ObjectMapper'
  pod 'Result'
  # pod 'RxSwift'
  # pod 'RxCocoa'
  pod 'SwiftyJSON'
  pod 'Moya-Decodable/RxSwift'
  pod 'RxFlow'
  pod 'SCLAlertView'
  pod 'PagingMenuController'
  pod 'SwiftFCXRefresh'
  pod 'SnapKit', '~> 4.0.0'
  # pod 'react-native-camera', path: '../node_modules/react-native-camera'
  pod 'BTNavigationDropdownMenu', :git => 'https://github.com/PhamBaTho/BTNavigationDropdownMenu.git'
  pod 'Charts'
end

target 'ZHERP' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ZHERP
  libraries
  pod 'MJRefresh'
  pod 'CryptoSwift'

  target 'ZHERPTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ZHERPUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
