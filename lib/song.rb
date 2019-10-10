require_relative '../lib/concerns/findable'
require 'pry'

class Song
  extend Concerns::Findable
  attr_accessor :name, :artist, :genre

  @@all = []

  def initialize(name, artist = omitted = true, genre = omitted2 = true)
    self.name = name
    if !omitted
      self.artist = artist
    end
    if !omitted2
      self.genre = genre
    end
  end

  def save
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    creation = self.new(name)
    creation.save
    creation
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self) unless artist.songs.include?(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self) unless genre.songs.include?(self)
  end

  def self.new_from_filename(filename)
    artist, song, genre_name = filename.split(" - ")
    fixed_genre = genre_name.gsub('.mp3', "")
    artist = Artist.find_or_create_by_name(artist)
    genre = Genre.find_or_create_by_name(fixed_genre)
    new(song, artist, genre)
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).save
  end

end
