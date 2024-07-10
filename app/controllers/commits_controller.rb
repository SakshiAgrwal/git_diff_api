# app/controllers/commits_controller.rb
class CommitsController < ApplicationController
    require 'octokit'
  
    def show
      client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
      commit = client.commit("#{params[:owner]}/#{params[:repository]}", params[:oid])
      
      render json: {
        oid: commit.sha,
        message: commit.commit.message,
        author: commit.commit.author,
        committer: commit.commit.committer,
        parents: commit.parents.map(&:sha)
      }
    rescue Octokit::NotFound
      render json: { error: 'Commit not found' }, status: :not_found
    end
  
    def diff
        client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
        commits = client.commits("#{params[:owner]}/#{params[:repository]}")
        current_commit = commits.find { |c| c.sha == params[:oid] }
        previous_commit = commits[commits.index(current_commit) + 1]
        comparison = client.compare("#{params[:owner]}/#{params[:repository]}", previous_commit.sha, current_commit.sha)
        diffs = comparison.files.map do |file|
          {
            changeKind: file.status.upcase,
            headFile: file.filename,
            baseFile: file.previous_filename || file.filename,
            hunks: file.patch
          }
        end
        render json: diffs
      rescue Octokit::NotFound
        render json: { error: 'Commit or comparison not found' }, status: :not_found
      end
  end
  