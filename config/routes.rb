Rails.application.routes.draw do
  get 'repositories/:owner/:repository/commits/:oid', to: 'commits#show'
  get 'repositories/:owner/:repository/commits/:oid/diff', to: 'commits#diff'
end
