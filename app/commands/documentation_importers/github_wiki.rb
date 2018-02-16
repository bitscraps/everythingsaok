module DocumentationImporters
  class GithubWiki
    attr_accessor :project, :user

    def initialize(user, project)
      self.user = user
      self.project = project
    end

    def import
      `git clone git@github.com:#{user}/#{project}.wiki.git #{destination_directory}`
      files = Dir.entries(destination_directory)

      files.each do |file|
        next unless file =~ /.*\.md$/

        documentation = read_file("#{destination_directory}/#{file}")
        title = find_title(documentation) || convert_to_title(file)

        Document.create(title: title, source: 'github', original_documentation: "https://github.com/#{user}/#{project}/wiki/#{no_extension(file)}", assigned_to: User.all.sample)
      end

      FileUtils.remove_dir(destination_directory)
      return "Import Complete"
    # rescue
    #   FileUtils.remove_dir(destination_directory)
    #   return "Import Failed"
    end

    private

    def destination_directory
      "/tmp/#{project}"
    end

    def find_title(documentation)
      html = markdown.render(documentation)
      html = html[/\<h.\>.*?\<\/h.\>/]
      if html
        html.gsub!(/\<h.\>/, '').gsub!(/\<\/h.>/, '')
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

    def no_extension(file)
      file.gsub(/.md/, '')
    end

    def markdown
      @renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {})
    end
  end
end