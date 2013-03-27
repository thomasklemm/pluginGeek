# Protect all models with strong_parameters
ActiveRecord::Base.send(:include, ActiveModel::ForbiddenAttributesProtection)
