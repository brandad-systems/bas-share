#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'image_share'
  s.version          = '1.0.0'
  s.summary          = 'share images on ios'
  s.description      = <<-DESC
Share to a specified package/appUrl
                       DESC
  s.homepage         = 'https://github.com/organizations/brandad-systems'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Brandad Systems AG' => 'team.javatar@brandad-systems.de' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '8.0'
end

