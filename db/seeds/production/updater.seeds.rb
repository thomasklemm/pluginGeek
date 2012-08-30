# encoding: UTF-8
# production/updater.seeds.rb

Rails.logger.info 'Processing KnightUpdater.update_knight_serial...'
# Update Knight in Serial
KnightUpdater.update_knight_serial
Rails.logger.info 'Finished processing KnightUpdater.update_knight_serial'
