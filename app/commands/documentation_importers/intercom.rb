require 'find'

module DocumentationImporters
  class Intercom
    attr_accessor :user, :store

    def initialize(store)
      self.store = store
      self.user = store.user
    end

    def import
      `cd /tmp && wget --limit-rate 50k -r -R jpg,png,js,css -l2 https://intercom.help/#{user}`
      files = []
      Find.find("/tmp/intercom.help/#{user}") do |path|
        next if FileTest.directory?(path)
        files << path unless path =~ /\.html/
      end

      puts files

      files.each do |file|
        documentation = read_file(file)
        next unless documentation
        title = find_title(documentation) || convert_to_title(file)

        source_url = convert_to_original_url(file)

        next if Document.find_by(original_documentation: source_url)
        user = User.all.sample
        document = Document.create(title: title,
                                   source: 'intercom',
                                   original_documentation: source_url,
                                   document_store: store,
                                   assigned_to: user)
        DocumentMailer.new_document(user, document).deliver
      end

      FileUtils.remove_dir('/tmp/intercom.help')
      return 'Import Complete'
    rescue
      raise
      FileUtils.remove_dir('/tmp/intercom.help')
      return 'Import Failed'
    end

    private

    def find_title(documentation)
      html = documentation[/\<title>.*?\<\/title>/]
      return unless html

      html.gsub!(/\<title\>/, '').gsub!(/\<\/title>/, '')
      html.gsub!(/\| .*? Help Center/, '')
    end

    def read_file(file_name)
      file = File.open(file_name, 'r')
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
  end
end
