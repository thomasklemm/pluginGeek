namespace :git do
  desc 'Remove assets that have been deleted from Git.'
  task :rm do
    puts 'Adding files...'
    system "git add ."
    puts 'Git status...'
    system "git status"
    puts 'Removing deleted files...'
    system "for i in `git status | grep deleted | awk '{print $3}'`; do git rm $i; done"
    puts 'Deleted files have been removed.'
  end
end
