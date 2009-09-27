module CouchRest
	module Mixins
		module AttributeProtection
	    def self.included(base)
			  base.extend(ClassMethods)
			end

			module ClassMethods
			  def accessable_properties
          properties.select { |prop| prop.options[:accessable] }
				end
			end

      def accessable_properties
			  self.class.accessable_properties
			end

      def remove_protected_attributes(hash)
        accessable_names = accessable_properties.map { |prop| prop.name }
				return hash if accessable_names.empty?

			  hash.reject! do |key, value|
          ! accessable_names.include?(key.to_s)
				end
				hash || {}
			end
		end
	end
end
