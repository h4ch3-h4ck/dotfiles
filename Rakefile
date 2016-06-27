namespace :zsh do
  task :install do
    sh 'cp zsh/zshrc ~/.zshrc'
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

namespace :bash do
  task :install do
    sh 'cp bash/bash_profile ~/.bash_profile'
  end
end

namespace :atom do
  task :install do
    sh 'cp atom/keymap.cson ~/.atom/keymap.cson'
    sh 'cp atom/styles.less ~/.atom/styles.less'
  end
end

task :install => ['zsh:install', 'vim:install', 'bash:install', 'atom:install']
