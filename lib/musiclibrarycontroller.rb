
require "pry"
class MusicLibraryController

  def initialize(path = "./db/mp3s")
    library = MusicImporter.new(path)
    library.import
    library
  end
  def call
    input = ""
    while input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.chomp
    end
  end
  def list_songs
    i = 0
    sorted = Song.all.uniq.sort_by{|song| song.name}
    sorted.each {|song|
      i += 1
      puts "#{i}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    }
  end
  def list_artists
    i = 0
    sorted = Artist.all.uniq.sort_by{|artist| artist.name}
    sorted.each {|artist|
      i += 1
      puts "#{i}. #{artist.name}"
    }
  end
  def list_genres
    i = 0
    sorted = Genre.all.uniq.sort_by{|genre| genre.name}
    sorted.each {|genre|
      i += 1
      puts "#{i}. #{genre.name}"
    }
  end
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.chomp
    if artist = Artist.find_by_name(input)
      i = 0
      sorted = artist.songs.sort_by{|song| song.name}
      sorted.each {|song|
        i += 1
        puts "#{i}. #{song.name} - #{song.genre.name}"
      }
    end
  end
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.chomp
    if genre = Genre.find_by_name(input)
      i = 0
      sorted = genre.songs.sort_by{|song| song.name}
      sorted.each {|song|
        i += 1
        puts "#{i}. #{song.artist.name} - #{song.name}"
      }
    end
  end
  def play_song
    puts "Which song number would you like to play?"
    input = gets.chomp
    num = input.strip.to_i
    songs = Song.all.uniq.sort_by{|song| song.name}
    if (1..songs.length).include?(num)
      play = songs[num + 1]
      puts "Playing #{play.name} by #{play.artist.name}" #if play != nil
    end
  end
end
