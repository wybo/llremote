#--#
# Copyright: (c) 2009 The LogiLogi Foundation <foundation@logilogi.org>
#
# License:
#   This file is part of the LLRemote Library. LLRemote is Free 
#   Software. You can run/distribute/modify LLRemote under the terms 
#   of the GNU Lesser General Public License version 3. This license
#   states that you can use LLRemote in applications that are not Free 
#   Software but LLRemote itself remains Free Software. (LICENSE contains 
#   the full text of the legally binding license).
#++#
#
# LLRemote::Logi is a logi that can be read and saved remotely

class LLRemote::Logi
  attr_accessor :link, :title, :body

  # Initializes a logi.
  #
  # Options:
  # * <tt>link</tt> = link of the logi (can have different tags 
  #   for existing logis to update it's tags)
  # * <tt>title</tt> = the title (optional for existing logi)
  # * <tt>body</tt> = the body (optional for existing logi)
  #
  def initialize(options)
    self.link = options[:link]
    self.title = options[:title]
    self.body = options[:body]
  end

  # Loads the logi with it's remote data
  #
  def reload
    entry = LLRemote.load_entry(self.link)
    self.set_from_entry(entry)
  end

  # Saves the logi. It creates it if it doesn't exist, and updates
  # it if it does.
  #
  def save
    if self.link =~ /=/
      return self.update
    else
      return self.create
    end
  end

  protected

  def create
    if self.link.nil? or self.link.empty? or
        self.title.nil? or self.title.empty? or
        self.body.nil? or self.body.empty?
      raise 'Logi needs link, body and title to be created'
    end
    collection = Atom::Pub::Collection.new(
        :href => LLRemote.server_url + "/do/logis/" + self.link + "/do.xml")
    entry = Atom::Entry.new do |e|
      e.title = self.title
      e.content = self.parse_body(self.body)
      e.categories = self.parse_tags(self.link)
    end
    begin
      entry = collection.publish(entry, :user => LLRemote.access_token, :pass => "")
    rescue
      raise 'Error: Could not create logi: ' + self.link +
          '. Wrong credentials ?'
    end

    self.set_from_entry(entry)
    return self
  end

  def update
    if self.link.nil? or self.link.empty?
      raise 'Logi needs link to be updated'
    end

    entry = LLRemote.load_entry(self.link)
    entry.title = self.title if self.title
    entry.content = self.parse_body(self.body) if self.body
    entry.categories = self.parse_tags(self.link)

    begin
      entry.save!(:user => LLRemote.access_token, :pass => "")
    rescue
      raise 'Error: Could not update logi: ' + self.link + 
          '. Wrong credentials ?'
    end

    self.set_from_entry(entry)
    return self
  end

  def set_from_entry(entry)
    self.title = entry.title,
    self.body = entry.content.to_s,
    self.link = unparse_link(entry.links.alternate.to_s)
  end

  def parse_tags(link)
    tags_string = link.split('=')[0]
    tag_strings = tags_string.split('/')
    categories = []
    tag_strings.each do |tag_string|
      categories << Atom::Category.new(:term => tag_string)
    end
    return categories
  end

  def unparse_link(raw_link)
    link = raw_link.gsub(LLRemote.server_url + "/","")
    link.strip!
    return link
  end

  def parse_body(raw_body)
    raw_body = raw_body.dup
    raw_body.gsub!(/^(\n|\s)*/,"")
    raw_body.gsub!(/(\n|\s)*$/,"")
    return Atom::Content::Html.new(
        "<p>" + raw_body.split("\n").join("</p> <p>") + "</p>")
  end
end
