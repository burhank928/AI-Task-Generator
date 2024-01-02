class AiTaskGeneratorService
  def initialize(user, goal)
    @user = user
    @goal = goal
  end

  def generate_task
    begin
      description = ChatgptService.new.generate(@goal).join("\n")
      @user.tasks.build(title: @goal, description: description)
    rescue StandardError => e
      Rails.logger.error("Failed to generate task: #{e.message}")
      nil
    end
  end
end
