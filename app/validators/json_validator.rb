class JsonValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    JSON::Validator.validate!(options[:schema], value, strict: false)
  rescue JSON::Schema::ValidationError => e
    record.errors.add attribute, (options[:message] || e.message)
  end
end
