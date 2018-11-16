
Pod::Spec.new do |s|

  s.name         = "LXSignal"
  s.version      = "0.0.1"
  s.summary      = "多个网络请求同时回调并发解决"
  s.homepage     = "https://github.com/985589477/Signal.git"
  s.description  = <<-DESC 
                     多个网络请求同时回调并发解决,通知一个回调执行最终的函数方法
                   DESC
  s.license      = "MIT"
  s.author       = { "lixuan" => "lx985589477@sina.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/985589477/Signal.git", :tag => "0.0.1" }
  s.source_files  = "LXSingle/LXSignal"

  s.requires_arc = true

end
