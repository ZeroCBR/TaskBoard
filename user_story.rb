class UserStory
	$COLUMN=["toDo", "inProgress", "toVerify", "done"]
	attr_reader :id
	attr_accessor :description
	attr_reader :tasks
	attr_reader :toDo
	attr_reader :inProgress
	attr_reader :toVerify
	attr_reader :done
	attr_accessor :completed
	def initialize(id,description)
		@id=id
		@description=description
		@tasks=[]
		@toDo=[]
		@inProgress=[]
		@toVerify=[]
		@done=[]
		@completed=false
	end

	def createTask(taskID,description)
		task=Task.new(taskID,description)
		@tasks.push(task)
		@toDo.push(task)
	end

	def checkTaskID(taskID)
		@tasks.each do |task|
			if task.id==taskID
				return true
			end
		end
		return false
	end

	def findTask(taskID)
		@tasks.each do |task|
			if task.id==taskID
				return task
			end
		end
	end

	def moveTask(taskID,column)
		task=findTask(taskID)
		tmp=task.dup
		removeTask(task)
		case column
		when "toDo"	
			tmp.column="toDo"
			@tasks.push(tmp)
			@toDo.push(tmp)
		when "inProgress"
			tmp.column="inProgress"
			@tasks.push(tmp)
			@inProgress.push(tmp)			
		when "toVerify"			
			tmp.column="toVerify"
			@tasks.push(tmp)
			@toVerify.push(tmp)
		when "done"
			tmp.column="done"
			@tasks.push(tmp)
			@done.push(tmp)			
		end
	end

	def findTaskIndex(ptask)
		@tasks.each_with_index do |task,index|
			if ptask==task
				return index
			end
		end
	end

	def removeTask(task)
		if @toDo.include?(task)
			@toDo.delete(task)
			@tasks.delete(task)
		end
		if @inProgress.include?(task)
			@inProgress.delete(task)
			@tasks.delete(task)
		end
		if @toVerify.include?(task)
			@toVerify.delete(task)
			@tasks.delete(task)
		end
	end

	def listTask
		@tasks.each do |task|
			puts "Task #{task.id}: #{task.description} column: #{task.column}"
		end
	end		
end