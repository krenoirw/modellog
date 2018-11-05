module Test
  extend ActiveSupport::Concern

  included do
    before_create :write_log
  end

  class_methods do
    def model_log(text)
      define_method(:write_log) do
        Rails.logger.info(text) if text.present?
      end
    end

    # example
    # class User < ApplicationRecord
    #   include Test
    #   model_log "Hello World"
    # end

  end
end