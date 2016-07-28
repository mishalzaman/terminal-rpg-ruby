class Load
	def initialize
		@files = Dir.entries("assets/save").select {|f| !File.directory? f}
	end

	def can_load
		if @files.count > 0
			return true
		end

		return false
	end

	def load
		return "save.json"
	end
end