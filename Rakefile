namespace :zsh do
  task :copy do
    sh 'cp ~/.zshrc zsh/.zshrc'
  end
end

namespace :vim do
  task :copy do
    sh 'cp ~/.vimrc.before vim/.vimrc.before'
    sh 'cp ~/.vimrc.after vim/.vimrc.after'
    sh 'cp ~/.gvimrc.after vim/.gvimrc.after'
  end
end

namespace :bash do
  task :copy do
    sh 'cp ~/.bash_profile bash/.bash_profile'
  end
end

task :update => ['zsh:copy', 'vim:copy', 'bash:copy']
