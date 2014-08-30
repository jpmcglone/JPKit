Pod::Spec.new do |s|
  s.name = 'JPKit'
  s.version = '0.1.0'
  s.platform = 'ios'
  s.ios.deployment_target = '7.0'
  s.prefix_header_file = 'src/JPKit/JPKit-Prefix.pch'
  s.source_files = 'src/JPKit/**/*.{h,m}'
  s.requires_arc = true
end

