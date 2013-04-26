Rake::Task["assets:precompile:primary"].prerequisites.delete "tmp:cache:clear"
Rake::Task["assets:precompile:nondigest"].prerequisites.delete "tmp:cache:clear"