deployment_target = '13.0'

keychain_access_version = '~> 4.2.1'

swifty_rsa_version = '1.6.0'
swift_date_version = '6.3.1'
swift_iq_keyboard = '6.5.6'
nuke_version = '9.5.0'

platform :ios, deployment_target
workspace 'App.xcworkspace'
use_frameworks!

def is_pod_binary_cache_enabled
  ENV['IS_POD_BINARY_CACHE_ENABLED'] == 'true'
end

#HOME = ENV['HOME']

#prebuild_path = "#{HOME}/Library/Developer/Xcode/_PreBuild"

if is_pod_binary_cache_enabled
  plugin 'cocoapods-binary-cache'

  config_cocoapods_binary_cache(
    cache_repo: {
      'default' => {
        'remote' =>
          'git@bitbucket.org:ascendcorp/ami-ios-consumer-cache.git',
        'local' => '~/.cocoapods-binary-cache/prebuilt-frameworks',
      },
    },
    prebuild_config: 'Release',
    device_build_enabled: true,
    xcframework: true,
    bitcode_enabled: true,
    dev_pods_enabled: true,
#    prebuild_sandbox_path: prebuild_path,
  )
end

def binary_pod(name, *args)
  if is_pod_binary_cache_enabled
    pod name, args, binary: true
  else
    pod name, args
  end
end

def netFox
  swift_netfox_version = '1.19.0'

  if is_pod_binary_cache_enabled
    pod 'netfox',
        swift_netfox_version,
        configurations: ['Debug'],
        binary: true
  else
    pod 'netfox', swift_netfox_version, configurations: ['Debug']
  end
end

def module_binary_pod(name)
  if is_pod_binary_cache_enabled
    pod name, path: name, binary: true
  else
    pod name, path: name
  end
end


def rxSwift
  rx_version = '~> 5.1.1'

  binary_pod 'RxSwift', rx_version
  binary_pod 'RxCocoa', rx_version
end

def swiftInject
  swinject_version = '~> 2.7.0'

  binary_pod 'Swinject', swinject_version
  binary_pod 'SwinjectAutoregistration', swinject_version
end

def firebase
  firebase_analytic_version = '8.0.0'
  firebase_crashlytic_version = '8.0.0'
  firebase_cloud_messaging_version = '8.0.0'
  google_utilities_version = '7.4.1'
  gtm_session_fetcher_version = '1.5.0'
  
  binary_pod 'Firebase/Analytics', firebase_analytic_version
  binary_pod 'Firebase/Crashlytics', firebase_crashlytic_version
  binary_pod 'Firebase/Messaging', firebase_cloud_messaging_version
#  binary_pod 'GoogleUtilities', google_utilities_version
#  binary_pod 'GTMSessionFetcher', gtm_session_fetcher_version
end


target 'Utility' do
  project 'Utility/Utility.xcodeproj'
  binary_pod 'SwiftDate', swift_date_version
end

target 'Networking' do
  project 'Networking/Networking.project'
end

target 'Core' do
  project 'Core/Core.project'
  rxSwift
  binary_pod 'KeychainAccess', keychain_access_version
  binary_pod 'SwiftyRSA', swifty_rsa_version
end

target 'UIComponent' do
  project 'UIComponent/UIComponent.project'
  binary_pod 'Nuke', nuke_version
end

target 'Logger' do
  project 'Logger/Logger.project'
end

target 'App' do
  project 'App/App.project'
  swiftInject
  rxSwift
  netFox
  firebase
  binary_pod 'KeychainAccess', keychain_access_version
  binary_pod 'SwiftyRSA', swifty_rsa_version
  binary_pod 'SwiftDate', swift_date_version
  binary_pod 'IQKeyboardManagerSwift', swift_iq_keyboard
  binary_pod 'Nuke', nuke_version
 
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.build_configurations.each do |config|
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] =
        deployment_target
    end
  end

  installer
    .pods_project
    .targets
    .each do |target|
      target.build_configurations.each do |config|
        config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] =
          deployment_target
      end
    end
end

