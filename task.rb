class Task
	attr_reader :id
	attr_accessor :description
	attr_accessor :column
	def initialize(id,description)
		@id=id
		@description=description
		@column="toDo"
	end

	def update(description)
		@description=description
	end
end