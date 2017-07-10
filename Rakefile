namespace :zsh do
  task :install do
    sh 'cp zsh/zshrc ~/.zshrc'
    sh 'cp zsh/zshrc.alias ~/.zshrc.alias'
  end
end

namespace :vim do
  task :install do
    sh 'cp vim/vimrc.before ~/.vimrc.before'
    sh 'cp vim/vimrc.after ~/.vimrc.after'
    sh 'cp vim/gvimrc.before ~/.gvimrc.before'
    sh 'cp vim/gvimrc.after ~/.gvimrc.after'
  end
end

namespace :atom do
  task :install do
    sh 'cp atom/keymap.cson ~/.atom/keymap.cson'
    sh 'cp atom/styles.less ~/.atom/styles.less'
  end
end

namespace :vscode do
  task :install do
    sh 'cp vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json'
  end
end

task :install => ['zsh:install', 'vim:install', 'atom:install', 'vscode:install']
