class TaskBoard
  def initialize
    @userStories=[]
  end

  def listStory
    @userStories.each do |userStory|
      puts "User Story #{userStory.id}: #{userStory.description}"
    end
  end

  def removeStory(id)
    @userStories.each do |userStory|
      if userStory.id==id
        @userStories.delete(userStory)
      end
    end
  end

  def findStory(id)
    @userStories.each do |userStory|
      if userStory.id==id
        return userStory
      end
    end
  end

  def checkStory(id)
    @userStories.each do |userStory|
      if userStory.id==id
        return true
      end
    end
    return false
  end

  def completeStory(id)
    @userStories.each do |userStory|
      if userStory.id==id and tasks.size==done.size
        userStory.completed=true
      end
    end
  end

  def readInput
    puts "Welcome to Task Board: "
    while true do
      input=gets.split(' ')
      # input.chomp!
      case input[0]
        when "create"
          if input[1].eql?("story") and input.size==4 and input[2].to_i.to_s==input[2] and !checkStory(input[2])
            story=UserStory.new(input[2], input[3])
            @userStories.push(story)
            $stdout.puts("0")
          elsif input[1].eql?("task") and input.size==5 and input[2].to_i.to_s==input[2] and checkStory(input[2]) and input[3].to_i.to_s==input[3] and !findStory(input[2]).checkTaskID(input[3])
            findStory(input[2]).createTask(input[3], input[4])
            $stdout.puts("0")
          else
            $stderr.puts("1")
          end
        when "list"
          if input[1].eql?("stories") and input.size==2
            listStory
            $stdout.puts("0")
          elsif input[1].eql?("tasks") and input.size==3 and input[2].to_i.to_s==input[2] and checkStory(input[2])
            findStory(input[2]).listTask
            $stdout.puts("0")
          else
            $stderr.puts("1")
          end
        when "delete"
          if input[1].eql?("story") and input.size==3 and input[2].to_i.to_s==input[2] and checkStory(input[2])
            removeStory(input[2])
            $stdout.puts("0")
          elsif input[1].eql?("task") and input.size==4 and input[2].to_i.to_s==input[2] and checkStory(input[2]) and input[3].to_i.to_s==input[3] and findStory(input[2]).checkTaskID(input[3])
            findStory(input[2]).removeTask(findStory(input[2]).findTask(input[3]))
            $stdout.puts("0")
          else
            $stderr.puts("1")
          end
        when "complete"
          if input[1].eql?("story") and input.size==3 and input[2].to_i.to_s==input[2] and checkStory(input[2]) and findStory(input[2]).tasks.size==findStory(input[2]).done.size
            findStory(input[2]).completed=true
            $stdout.puts("0")
          else
            $stderr.puts("1")
          end
        when "move"
          if input[1].eql?("task") and input.size==5 and input[2].to_i.to_s==input[2] and checkStory(input[2]) and input[3].to_i.to_s==input[3] and findStory(input[2]).checkTaskID(input[3]) and $COLUMN.include?(input[4]) and findStory(input[2]).findTask(input[3]).column!=input[4] and findStory(input[2]).findTask(input[3]).column!="done"
            findStory(input[2]).moveTask(input[3], input[4])
            $stdout.puts("0")
          else
            $stderr.puts("1")
          end
        when "update"
          if input[1].eql?("task") and input.size==5 and input[2].to_i.to_s==input[2] and checkStory(input[2]) and input[3].to_i.to_s==input[3] and findStory(input[2]).checkTaskID(input[3])
            if findStory(input[2]).tasks.include?(findStory(input[2]).findTask(input[3]))
              findStory(input[2]).findTask(input[3]).update(input[4])
              $stdout.puts("0")
            else
              $stderr.puts("1")
            end
          end
        when "exit"
          exit(0)
      end
    end
  end
end