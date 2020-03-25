#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint learningflutterplugin.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'learningflutterplugin'
  s.version          = '0.0.1'
  s.summary          = 'Learning Flutter Plugin.'
  s.description      = <<-DESC
Learning Flutter Plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.platform = :ios, '9.0'

  s.ios.deployment_target  = '9.0'

  s.dependency 'Flutter'
  s.dependency 'RangeSeekSlider'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
