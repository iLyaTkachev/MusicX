import Foundation

class ApiConstants {
    
    static let appName = "MusicX"
    
    class PlaymusApi {
        static let baseUrl = "http://playmus.cc/"
        static let search = "search"
        static let devider = "%20"
    }
    
    class LastFmApi {
        static let example = "http://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&api_key=YOUR_API_KEY&format=json"
        static let baseUrl = "https://ws.audioscrobbler.com"
        static let version = "2.0"
        static let method = "method"
        static let apiKey = "api_key"
        static let format = "format"
        static let json = "json"
        static let page = "page"
        
        class Auth {
            static let auth = "auth"
            static let getMobileSession = "getMobileSession"
            static let getSession = "getSession"
            static let getToken = "getToken"
        }
        
        class Album {
            static let album = "album"
            static let addTags = "addTags"
            static let getInfo = "getInfo"
            static let getTags = "getTags"
            static let getTopTags = "getTopTags"
            static let removeTag = "removeTag"
            static let search = "search"
        }
        
        class Artist {
            static let artist = "artist"
            static let addTags = "addTags"
            static let getCorrection = "getCorrection"
            static let getInfo = "getInfo"
            static let getSimilar = "getSimilar"
            static let getTags = "getTags"
            static let getTopAlbums = "getTopAlbums"
            static let getTopTags = "getTopTags"
            static let getTopTracks = "getTopTracks"
            static let removeTag = "removeTag"
            static let search = "search"
        }
        
        class Chart {
            static let chart = "chart"
            static let getTopTracks = "getTopTracks"
            static let getTopArtists = "getTopArtists"
            static let getTopTags = "getTopTags"
        }
        
        class  Geo {
            static let geo = "geo"
            static let getTopArtists = "getTopArtists"
            static let getTopTracks = "getTopTracks"
        }
        
        class Library {
            static let library = "library"
            static let getArtists = "getArtists"
        }
        
        class Tag {
            static let tag = "tag"
            static let getInfo = "getInfo"
            static let getSimilar = "getSimilar"
            static let getTopAlbums = "getTopAlbums"
            static let getTopArtists = "getTopArtists"
            static let getTopTags = "getTopTags"
            static let getTopTracks = "getTopTracks"
            static let getWeeklyChartList = "getWeeklyChartList"
            
        }
        
        class Track {
            static let track = "track"
            static let addTags = "addTags"
            static let getCorrection = "getCorrection"
            static let getInfo = "getInfo"
            static let getSimilar = "getSimilar"
            static let getTags = "getTags"
            static let getTopTags = "getTopTags"
            static let love = "love"
            static let removeTag = "removeTag"
            static let scrobble = "scrobble"
            static let search = "search"
            static let unlove = "unlove"
            static let updateNowPlaying = "updateNowPlaying"
        }
        
        class User {
            static let user = "user"
            static let getArtistTracks = "getArtistTracks"
            static let getFriends = "getFriends"
            static let getInfo = "getInfo"
            static let getLovedTracks = "getLovedTracks"
            static let getPersonalTags = "getPersonalTags"
            static let getRecentTracks = "getRecentTracks"
            static let getTopAlbums = "getTopAlbums"
            static let getTopArtists = "getTopArtists"
            static let getTopTags = "getTopTags"
            static let getTopTracks = "getTopTracks"
            static let getWeeklyAlbumChart = "getWeeklyAlbumChart"
            static let getWeeklyArtistChart = "getWeeklyArtistChart"
            static let getWeeklyChartList = "getWeeklyChartList"
            static let getWeeklyTrackChart = "getWeeklyTrackChart"
        }
    }
}
