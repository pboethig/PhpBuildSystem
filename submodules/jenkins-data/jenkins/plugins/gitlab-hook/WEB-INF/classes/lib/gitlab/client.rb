require 'net/http'
require 'json'

module Gitlab
  class Client

    attr_reader :gitlab_url, :id, :namespace, :name, :code, :msg

    def initialize(descriptor, repo_name=nil)
      @gitlab_url = descriptor.gitlab_url
      @token = descriptor.token
      self.name = repo_name if repo_name
    end

    def name=(repo_namespace)
      @namespace = repo_namespace.split('/')[-2]
      if @name = repo_namespace.split('/').last
        @name.slice!(/.git$/)
        @id = repo_id
      end
    end

    def merge_request(project)

      src = project.matching_scms.first.branches.first.name.split '/'
      [ '*' , 'origin'].include?(src[0]) ? src.delete_at(0) : nil
      source = src.join '/'

      if target = project.merge_target
        do_request("projects/#{id}/merge_requests?state=opened").each do |mr|
          return mr['id'] if mr['source_branch'] == source && mr['target_branch'] == target
        end
      end
      return -1
    end

    def details(project_id)
      do_request("projects/#{project_id}")
    end

    def post_status(commit, status, ci_url, mr_id=nil)
      if mr_id.nil?
        status = case status.to_s
          when 'UNSTABLE', 'FAILURE', 'NOT_BUILT'
            'failed'
          when 'ABORTED'
            'canceled'
          else
            status.to_s.downcase
          end
        post_commit_status(commit, status, ci_url)
      elsif mr_id == -1
        post_commit_note(commit, status, ci_url)
      else
        post_mr_note(mr_id, status, ci_url)
      end
    end

    private

    attr_accessor :token

    def post_commit_status(commit, status, ci_url)
      url = "projects/#{id}/statuses/#{commit}"
      do_request url, :state => status, :target_url => ci_url
    end

    def post_commit_note(commit, status, ci_url)
      url = "projects/#{id}/repository/commits/#{commit}/comments"
      do_request url, :note => comment(status, ci_url)
    end

    def post_mr_note(mr_id, status, ci_url)
      url = "projects/#{id}/merge_request/#{mr_id}/comments"
      do_request url, :note => comment(status, ci_url)
    end

    def comment(status, ci_url)
      "[Jenkins CI result #{status}](#{ci_url})"
    end

    def me
      do_request("user")['id']
    end

    def repo_id
      matches = do_request("projects/search/#{name}")
      if matches.is_a? Array
        matches.each do |repo|
          return repo['id'] if "#{namespace}/#{name}" == repo['path_with_namespace']
        end
        @msg = "No gitlab project matches #{name}"
      else
        @msg = matches['message']
        logger.severe("Cannot contact GitLab server : #{msg}")
      end
      return
    end

    def do_request(url, data=nil)

      uri = URI "#{gitlab_url}/api/v3/#{url}"

      if data
        req = Net::HTTP::Post.new uri.request_uri
        req.set_form_data data
      else
        req = Net::HTTP::Get.new uri.request_uri
      end

      req['PRIVATE-TOKEN'] = token

      http = Net::HTTP.new uri.host, uri.port
      if uri.scheme == 'https'
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      res = http.request req

      begin
        JSON.parse(res.body).tap do |out|
          unless [ "200" , "201" ].include? res.code
            logger.severe "Bad Request '#{url}' : #{res.code} - #{res.msg}"
            logger.severe "Server response : #{JSON.pretty_generate(out)}"
          end
          @code = res.code
        end
      rescue JSON::ParserError
        logger.severe( "GitLab response is not JSON" )
        @msg = "GitLab response is not JSON"
      end
    end

    def logger
      @logger ||= Java.java.util.logging.Logger.getLogger(Gitlab::Client.class.name)
    end
  end
end
