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

				def protected_properties
          properties.select { |prop| prop.options[:protected] }
				end
			end

      def accessable_properties
			  self.class.accessable_properties
			end

      def protected_properties
			  self.class.protected_properties
			end

      def remove_protected_attributes(attributes)
				protected_names = properties_to_remove_from_mass_assignment.map { |prop| prop.name }
				return attributes if protected_names.empty?

			  attributes.reject! do |key, value|
          protected_names.include?(key.to_s)
				end

				attributes || {}
			end

			private

			def properties_to_remove_from_mass_assignment
				has_protected = !protected_properties.empty?
				has_accessable = !accessable_properties.empty?

				if !has_protected && !has_accessable
					[]
				elsif has_protected && !has_accessable
					protected_properties
				elsif has_accessable && !has_protected
					properties.reject { |prop| prop.options[:accessable] }
				else
					raise "Set either :accessable or :protected, but not both"
				end
			end
		end
	end
end
