# frozen_string_literal: true

require 'active_support/concern'

module Devise
  module Models
    # Model that will be authenticatable with the JWT strategy
    #
    # @see [Warden::JWTAuth::Interfaces::UserRepository]
    # @see [Warden::JWTAuth::Interfaces::User]
    module JwtAuthenticatable
      extend ActiveSupport::Concern
      
      module ClassMethods
        def self.find_for_jwt_authentication(sub)
          find_by(primary_key => sub)
        end
        
        Devise::Models.config(self, :jwt_revocation_strategy)
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      def jwt_subject
        id
      end
    end
  end
end
