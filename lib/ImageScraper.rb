require "ImageScraper/version"
require "nokogiri"
require "open-uri"
module ImageScraper

	
	#The constructor
	def self.initialize(url, folder = "Images")
		if url[url.length] != "/"
			url += "/"
		end
		@url = url
		@folder = folder
	end

	#A function to get HTML of page at a url
	def self.getPage()
		@page = Nokogiri::HTML(open(@url).read)
	end

	#a method to get image links
	def self.getImgLinks()
		img = @page.css('img')
		@imgLinks = Array.new

		img.each do |i|
			@imgLinks.push(@url+i["src"])
		end
	end

	#A method to download images
	def self.download()
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

	#A method to download all images
	def self.getImgNames()
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

	#A method to download all files at a given url
	def self.Scrape()
		self.getPage
		self.getImgNames
		self.getImgLinks
		self.download
	end

end
