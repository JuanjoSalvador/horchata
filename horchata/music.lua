--- Module to manage music and sounds
-- @module horchata.music
-- @author Juanjo Salvador
-- @copyright 2020
-- @license MIT

local Music = {}

local tracks = {}

--- Loads a list of tracks from file (default file, tracks.csv, see example bellow)
-- @param base Base directory where audio files are stored, without ending slash
-- @param file CSV file with all tracks and descriptors, should be in the base directory, default tracklist.csv
function Music:load(base, file)
  base = base .. "/"
  file = file or base .. "/tracklist.csv"

  for line in io.lines(file) do
    local values = {}
    local track = {}
    for s in string.gmatch(line, "[^,]+") do
      table.insert(values, s)
    end
    tracks[values[1]] = love.audio.newSource(base .. values[2], values[3])
  end
end

--- Plays the selected track
-- @param track A track listed on tracks.txt
-- @param volume Optional, sets the volume of the play (default 50%)
function Music:play(track, volume)
  volume = volume or 0.5
  tracks[track]:setVolume(volume)
  tracks[track]:play()
end

--- Stop the selected track
-- @param track A track listed on tracks.txt
function Music:stop(track)
  tracks[track]:stop()
end

return Music
