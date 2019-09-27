class Genre
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
    creation = Genre.new(name)
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
      song.genre = self if !song.genre
      @songs << song if !@songs.include?(song)
  end
  def artists
    artist = @songs.collect{|song| song.artist}
    artist.uniq
  end

end
