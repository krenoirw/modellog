module Test3
	extend ActiveSupport::Concern

	included do
		before_save :write_log

		def write_log; end
	end

	class_methods do
		def model_log(&block)
			define_method(:write_log) do
			  stop_watch do
			    instance_exec(&block) if block_given?
			  end
			end
		end

		# class User < ApplicationRecord
		#   include Test3

		# 	model_log do
		# 		Rails.logger.info("Hello World")
		# 	end
		# end
	end

	def stop_watch
		Rails.logger.info("----- start -----")
		start_time = Time.zone.now
		yield
		end_time = Time.zone.now
		Rails.logger.info("----- finished #{end_time - start_time}.seconds -----")
	end
end