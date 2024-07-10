# spec/requests/commits_spec.rb
require 'rails_helper'
require 'webmock/rspec'

RSpec.describe "Commits API", type: :request do
  before do
    @client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
    allow(Octokit::Client).to receive(:new).and_return(@client)
  end

  describe "GET /repositories/:owner/:repository/commits/:oid" do
    it "returns the commit details" do
      commit_sha = "a1bf367b3af680b1182cc52bb77ba095764a11f9"
      owner = "golemfactory"
      repo = "clay"

      stub_request(:get, "https://api.github.com/repos/#{owner}/#{repo}/commits/#{commit_sha}")
        .to_return(status: 200, body: '{"sha": "a1bf367b3af680b1182cc52bb77ba095764a11f9", "commit": {"message": "repo-updater: Use config value repoListUpdateInterval (#14983)", "author": {}, "committer": {}}, "parents": []}', headers: {})

      get "/repositories/#{owner}/#{repo}/commits/#{commit_sha}"
      
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["oid"]).to eq(commit_sha)
    end
  end

  describe "GET /repositories/:owner/:repository/commits/:oid/diff" do
    it "returns the diff of the commit" do
      commit_sha = "a1bf367b3af680b1182cc52bb77ba095764a11f9"
      previous_commit_sha = "previous_commit_sha"
      owner = "golemfactory"
      repo = "clay"

      stub_request(:get, "https://api.github.com/repos/#{owner}/#{repo}/commits")
        .to_return(status: 200, body: '[{"sha": "previous_commit_sha"}, {"sha": "a1bf367b3af680b1182cc52bb77ba095764a11f9"}]', headers: {})

      stub_request(:get, "https://api.github.com/repos/#{owner}/#{repo}/compare/#{previous_commit_sha}...#{commit_sha}")
        .to_return(status: 200, body: '{"files": [{"filename": "file1.txt", "status": "modified", "patch": "diff --git a/file1.txt b/file1.txt\nindex abcdef..123456 100644\n--- a/file1.txt\n+++ b/file1.txt\n@@ -1,1 +1,1 @@\n-Hello World\n+Hello Ruby"}]}', headers: {})

      get "/repositories/#{owner}/#{repo}/commits/#{commit_sha}/diff"
      
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).first["headFile"]).to eq("file1.txt")
    end
  end
end
