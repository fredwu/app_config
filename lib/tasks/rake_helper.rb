module ApplicationConfiguration
  module Rake
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      # Copies the initializer file to `config/initializers`
      # 
      # @param [String] message optional output message
      def copy_initializer_file(message = "")
        orig_dir  = "#{File.dirname(__FILE__)}/initializer/"
        orig_file = Dir.entries(orig_dir).last
        orig_path = orig_dir + orig_file
        
        dest_path = "config/initializers/#{orig_file}"
        
        copy_file(orig_path, dest_path, message)
      end
      
      # Copies a file
      # 
      # @param [String] orig_path original file path, absolute
      # @param [String] dest_path destination file path, relative to `Rails.root`
      # @param [String] message optional output message
      def copy_file(orig_path, dest_path, message = "")
        dest_path = "#{Rails.root}/#{dest_path}"
        
        if File.exists?(dest_path)
          puts "'#{dest_path}' already exists, therefore it is skipped."
        else
          FileUtils.cp(orig_path, dest_path)
          puts message unless message.nil?
        end
      end
    end
  end
end