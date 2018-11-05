module Test2
	extend ActiveSupport::Concern

	included do
		before_update :write_log
	end

	class_methods do
		def model_log(column)
			define_method(:write_log) do
				if self.class.column_names.include?(column.to_s)
				 value = send(column.to_sym)
				 Rails.logger.info("#{column.to_s}が#{value}に更新されました。") if send("#{column.to_s}_changed?")
				end
			end
		end

		# example
    # class User < ApplicationRecord
    #   include Test2
    #   model_log :name, "Hello World"
    # end

	end
end