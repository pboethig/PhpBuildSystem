require_relative '../util/settings'
require_relative '../services/security'

module GitlabWebHook
  class ProcessDeleteCommit
    include Settings

    def with(details, projects)

      return ["branch #{details.branch} is deleted, but automatic branch projects creation is not active, skipping processing"] unless settings.automatic_project_creation?
      return ["branch #{details.branch} is deleted, but relates to master project so will not delete, skipping processing"] if details.branch == settings.master_branch

      messages = []
      projects.select do |project|
        project.matches?(details, details.branch, true)
      end.each do |project|
        messages << "project #{project} matches deleted branch but is not automatically created by the plugin, skipping" and next unless project.description.match /#{settings.description}/
        Security.impersonate(ACL::SYSTEM) do
            project.delete
        end
        messages << "deleted #{project} project"
      end
      messages << "no project matches the #{details.branch} branch" if messages.empty?

      messages
    end
  end
end
