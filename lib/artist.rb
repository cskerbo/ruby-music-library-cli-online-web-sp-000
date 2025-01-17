require_relative '../lib/concerns/findable'

class Artist
  extend Concerns::Findable
  attr_accessor :name, :genre, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def songs
    @songs
  end

  def add_song(song)
    song.artist = self unless song.artist
    @songs << song unless songs.include?(song)
  end

  def genres
    songs.map(&:genre).uniq
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
end
