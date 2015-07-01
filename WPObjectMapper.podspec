Pod::Spec.new do |s|
  s.name         = "WPObjectMapper"
  s.version      = "0.0.2"
  s.summary      = "This is a drop-in category of NSObject that makes it easy to initialize custom objects from JSON or XML."
  s.description  = <<-DESC
                   This was originally sourced from the NSObject-ObjectMap category. Used mostly in PostKit for ingestion of content.
                   DESC

  s.homepage     = "https://github.com/WPMedia"
  s.license      = { :type => 'UA', :file => 'LICENSE' }
  s.author       = "The Washington Post"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/WPMedia/ios-object-mapper.git", :tag => s.version.to_s }

  s.source_files = 'WPObjectMapper'
end