Rails.application.routes.draw do
  get 'games/settings', to: 'games#settings'
  get 'games/score'
  get 'scores/result', to: 'scores#result', as: 'scores_result'
  post 'games/score', to: 'games#score'
  post 'scores/score', to: 'games#score'
end
