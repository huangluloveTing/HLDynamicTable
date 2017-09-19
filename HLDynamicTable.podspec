#
#  Be sure to run `pod spec lint SelectItemView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

 s.name         = "HLDynamicTable"

 s.version      = "0.0.2"

 s.ios.deployment_target = '8.0'

 s.summary      = "一个可以随意添加列数的表格视图,添加项目视图，可以去git主页，下载demo"

 s.homepage     = "https://github.com/huangluloveTing/HLDynamicTable.git"

 s.license              = "MIT"

 s.author             = { "huanglu" => "583699255@qq.com" }

 s.social_media_url   = "https://github.com/huangluloveTing/HLDynamicTable.git"

 s.source       = { :git => "https://github.com/huangluloveTing/HLDynamicTable.git", :tag => "0.0.2" }

 s.source_files  = "HLDynamicTable/DynamicTable/**/*"

 s.requires_arc = true

end
