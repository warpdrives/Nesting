Pod::Spec.new do |s|
  s.name             = 'Nesting'
  s.version          = '0.1.0.beta.1'
  s.summary          = 'An excellent nested view controller for iOS'
  s.description      = <<-DESC
iOS Nesting viewController, UIViewController, UIScrollView, UITableView
                       DESC

  s.homepage         = 'https://github.com/warpdrives/Nesting'
  s.license          = { :type => ' Apache 2.0', :file => 'LICENSE' }
  s.author           = { 'warpdrives' => 'warpdrives.team@gmail.com' }
  s.source           = { :git => 'git@github.com:warpdrives/Nesting.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'Nesting/Source/**/*'
  s.swift_version = '5.0
end
