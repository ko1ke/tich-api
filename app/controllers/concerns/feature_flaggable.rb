module FeatureFlaggable
  extend ActiveSupport::Concern

  Flipper.features.map(&:name).each do |name|
    define_method "#{name}_flag_enabled?" do |arg = nil, &b|
      if b.present?
        b.call if Flipper.enabled? name, arg
      else
        Flipper.enabled? name, arg
      end
    end
  end
end
