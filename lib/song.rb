class Song
  attr_accessor :name
  attr_reader :artist, :genre
  @@all = []
  def initialize(name, artist = nil, genre = nil)
    self.name = name
    if artist
      self.artist = artist
    end
    if genre
      self.genre = genre
    end
  end
  def save
    @@all << self
  end
  def self.all
    @@all
  end
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.create(name)
    creation = Song.new(name)
    creation.save
    creation
  end
  def self.destroy_all
    @@all.clear
  end
  def self.find_by_name(name)
    self.all.detect{|song| song.name == name}
  end
  def self.find_or_create_by_name(name)
      self.find_by_name(name) || self.create(name)
  end
  def self.new_from_filename(file)
    separated = file.chomp(".mp3").split(" - ")
    new_song = self.find_or_create_by_name(separated[1])
    new_song.artist = Artist.find_or_create_by_name(separated[0])
    new_song.genre = Genre.find_or_create_by_name(separated[2])
    new_song
  end
  def self.create_from_filename(file)
    @@all << self.new_from_filename(file)
  end
end
