# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'film-list' do
 pod 'Alamofire', '4.9.1'
 pod 'AlamofireImage', '3.6.0'
 pod 'RxSwift', '5.1.1'
 pod 'RxCocoa', '5.1.1'
 pod 'SwiftyJSON', '~> 4.0'


end
post_install do |installer|
     installer.pods_project.targets.each do |target|
         target.build_configurations.each do |config|
            if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 9.0
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
            end
         end
     end
end