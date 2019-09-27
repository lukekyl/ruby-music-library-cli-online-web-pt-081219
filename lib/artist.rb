class Artist
  extend Concerns::Findable
  attr_accessor :name
  @@all = []
  def initialize(name)
    self.name = name
    @songs = []
  end
  def save
    @@all << self
  end
  def self.all
    @@all
  end

  def self.create(name)
    creation = Artist.new(name)
    creation.save
    creation
  end
  def self.destroy_all
    @@all.clear
  end

  def songs
    @songs
  end
  def add_song(song)
      @songs << song if !@songs.include?(song)
      song.artist = self if !song.artist
  end
  def genres
    genre = @songs.collect{|song| song.genre}
    genre.uniq
  end

end
