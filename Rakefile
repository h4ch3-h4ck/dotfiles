namespace :zsh do
  task :copy do
    sh 'cp ~/.zshrc zsh/.zshrc'
  end

  task :install do
    sh 'cp zsh/.zshrc ~/.zshrc'
  end
end

namespace :vim do
  task :copy do
    sh 'cp ~/.vimrc.before vim/.vimrc.before'
    sh 'cp ~/.vimrc.after vim/.vimrc.after'
    sh 'cp ~/.gvimrc.after vim/.gvimrc.after'
  end

  task :install do
    sh 'cp vim/.vimrc.before ~/.vimrc.before'
    sh 'cp vim/.vimrc.after ~/.vimrc.after'
    sh 'cp vim/.gvimrc.before ~/.gvimrc.before'
    sh 'cp vim/.gvimrc.after ~/.gvimrc.after'
  end
end

namespace :bash do
  task :copy do
    sh 'cp ~/.bash_profile bash/.bash_profile'
  end

  task :install do
    sh 'cp bash/.bash_profile ~/.bash_profile'
  end
end

task :update => ['zsh:copy', 'vim:copy', 'bash:copy']

task :install => ['zsh:install', 'vim:install', 'bash:install']
