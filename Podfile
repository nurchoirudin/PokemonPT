# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'PokemonPT' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  def user_interface
    pod 'SkeletonView', :git => 'https://github.com/Juanpe/SkeletonView', :tag => '1.8.2'
    pod 'IQKeyboardManagerSwift', '~> 6.5.6'
    pod 'NVActivityIndicatorView'
    pod 'FloatingPanel'
  end

  def utilities
    pod 'RxSwift', '~> 5.1.3'
    pod 'RxCocoa', '~> 5.1.3'
    pod 'RxBlocking', '~> 5.1.3'
    pod 'Swinject', '2.8.0'
    pod 'Kingfisher', '~> 6.3.1'
  end
  
  def unit_test_dependencies
    pod 'Swinject', '2.8.0'
    pod 'RxSwift', '~> 5.1.3'
    pod 'RxCocoa', '~> 5.1.3'
    pod 'RxBlocking', '~> 5.1.3'
  end

  # Pods for PokemonPT
  user_interface
  utilities
  target 'PokemonPTTests' do
    inherit! :search_paths
    # Pods for testing
    unit_test_dependencies
  end

  target 'PokemonPTUITests' do
    # Pods for testing
   unit_test_dependencies
  end

end
