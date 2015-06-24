require "ImageScraper/version"
require "nokogiri"
require "open-uri"

module ImageScraper


	class Scraper
		#The constructor
		def initialize(url, folder = "Images")
			@url = url
			@folder = folder
		end

		#A function to get HTML of page at a url
		def getPage()
			@page = Nokogiri::HTML(open(@url).read)
		end


		def getNewUrl()
			new_url = /([a-z0-9]|_)+.(html)|(php)$/.match(@url)
			puts new_url.to_s
			n = new_url.to_s
			return @url.slice! n
		end

		#A method to get image links
		def getImgLinks()
			img = @page.css('img')
			@imgLinks = Array.new

			new_url = self.getNewUrl()
		
			if @url[@url.length-1] != '/'
				@url += "/"
			end
			print new_url

			img.each do |i|
				@imgLinks.push(@url+i["src"])
			end
		end

		#A method to download images
		def download()
			getPage
			puts "Page Found"
			getImgNames
			getImgLinks
			len = @imgLinks.length
			a = @imgLinks
			files = @files
			len.times do |f|
				puts "#{a[f]} found"
				File.open(files[f], "w") do |fo|	
					fo.write open(a[f]).read
				end
				puts "#{files[f]} downloaded"
			end
		end

		#A method to get all image names
		def getImgNames()
			if not File.exists?(@folder)
				Dir.mkdir(@folder)
				puts "#{@folder} Directory Created"
			end
			@files = Array.new
			img = @page.css('img')
			img.each do |i|
				nodes = i["src"].split("/")
				@files.push(@folder + "/" + nodes[nodes.length - 1])
			end
		end
	end

	#A method to download all files at a given url
	def self.getAllImages(url)
		s = Scraper.new(url)
		s.download()
	end
end
