class Song
  extend Concerns::Findable
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
  def self.destroy_all
    @@all.clear
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
    song = self.new(name)
    song.save
    song
  end
  def self.new_from_filename(file)
    separated = file.chomp(".mp3").split(" - ")
    song_name = separated[1]
    artist_name = separated[0]
    genre_name = separated[2]
    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)
    self.new(song_name, artist, genre)
  end
  def self.create_from_filename(file)
    @@all << self.new_from_filename(file)
  end
end
