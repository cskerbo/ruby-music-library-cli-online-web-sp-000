require_relative '../lib/concerns/findable'

class Genre
  extend Concerns::Findable
  attr_accessor :name, :artist, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def songs
    @songs
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

  def add_song(song)
    @songs << song
    song.genre = self unless song.genre
  end

  def artists
    songs.map(&:artist).uniq
  end

end
