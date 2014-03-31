module FlyingRubySaucer
  module Generator
    def self.string_to_pdf(html)      
      # Set the paths and build the java class path
      tmp_path    = defined?(Rails) ? Rails.root.join('tmp') : ['/tmp/']
      java_path   = File.join(File.expand_path(File.dirname(__FILE__)), "../../vendor/java").to_s.gsub(/\&/, '\\\&').gsub(/\s/, '\ ')
      class_path  = ".:#{java_path}/bin"

      Dir.glob("#{java_path}/jar/*.jar") do |jar|
        class_path << ":#{jar.to_s.gsub(/\&/, '\\\&').gsub(/\s/, '\ ')}"
      end

      # File names
      file_name   = Digest::MD5.hexdigest(html + Time.now.to_i.to_s + Time.now.usec.to_s)
      input_file  = tmp_path.join("#{file_name}.html")
      output_file = tmp_path.join("#{file_name}.pdf")
    
      # Write the HTML content on disk
      File.open(input_file, 'w') { |f| f << html }

      # Hack together the java command and fire it
      if output = %x[java -cp #{class_path} Xhtml2Pdf \"#{input_file}\" \"#{output_file}\"]
        # Read the output file and parse that up to the controller
        # to send it to the user
        return File.read(output_file)
      else
        raise StandardError, output
      end
  
    # Make sure the files get deleted after we're
    # done, no matter what
    ensure
      FileUtils.rm_f(input_file)
      FileUtils.rm_f(output_file)
    end
  end
end