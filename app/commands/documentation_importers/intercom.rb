module DocumentationImporters
  class Intercom
    attr_accessor :project, :user

    def initialize(user)
      self.user = user
    end

    def import
      `cd /tmp && wget -r -l2 https://intercom.help/sofar-sounds`
      files = []
      Find.find("/tmp/intercom.help/#{user}") do |path|
        next if FileTest.directory?(path)
        files << path unless path =~/\.html/
      end

      puts files

      files.each do |file|
        documentation = read_file(file)
        next unless documentation
        title = find_title(documentation) || convert_to_title(file)

        Document.create(title: title, source: 'intercom', original_documentation: convert_to_original_url(file), assigned_to: User.all.sample)
      end

      FileUtils.remove_dir('/tmp/intercom.help')
    #   return "Import Complete"
    # # rescue
    # #   FileUtils.remove_dir(destination_directory)
    # #   return "Import Failed"
    end

    private

    # def destination_directory
    #   "/tmp/#{project}"
    # end

    def find_title(documentation)
      html = documentation[/\<title>.*?\<\/title>/]
      if html
        html.gsub!(/\<title\>/, '').gsub!(/\<\/title>/, '')
        html.gsub!(/\| Sofar Sounds Platform Help Center/, '')
      end
    end

    def read_file(file_name)
      file = File.open(file_name, "r")
      data = file.read
      file.close
      return data
    end

    def convert_to_title(file)
      file.gsub(/\.md/, '').gsub(/\-/, ' ')
    end

    def convert_to_original_url(file)
      file.gsub(/\/tmp\//, 'https://')
    end

    # def markdown
    #   @renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
    # end
  end
end