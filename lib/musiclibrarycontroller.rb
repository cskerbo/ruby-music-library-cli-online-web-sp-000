require 'pry'

class MusicLibraryController

  attr_accessor :path

  def initialize(path = "./db/mp3s")
    new_import = MusicImporter.new(path)
    new_import.import
  end

  def call
    user_input = nil
    while user_input != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      user_input = gets.strip

      case user_input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end

    end
  end

  def list_songs
    Song.all.sort_by(&:name).each.with_index(1) do |song, index|
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    Artist.all.sort_by(&:name).each.with_index(1) do |song, index|
      puts "#{index}. #{song.name}"
    end
  end

  def list_genres
    Genre.all.sort_by(&:name).each.with_index(1) do |song, index|
      puts "#{index}. #{song.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets.strip

    if artist = Artist.find_by_name(user_input)
      artist.songs.sort_by(&:name).each.with_index(1) do |song, index|
        puts "#{index}. #{song.name} - #{song.genre.name}"
      end
    end
  end

    def list_songs_by_genre
      puts "Please enter the name of a genre:"
      user_input = gets.strip

      if genre = Genre.find_by_name(user_input)
        genre.songs.sort_by(&:name).each.with_index(1) do |song, index|
          puts "#{index}. #{song.artist.name} - #{song.name}"
        end
      end
    end

    def play_song
      puts "Which song number would you like to play?"
      user_input = gets.strip.to_i - 1

      if (1..Song.all.length).include?(user_input)
        song = Song.all.sort_by(&:name)[user_input]
        puts "Playing #{song.name} by #{song.artist.name}" if song
      end
    end


end
