vim-nox:
  pkg.installed

# /home/vagrant/.vim:
#   file.recurse:
#    - source: salt://edit/vim
#    - user: vagrant
#    - group: vagrant
#    - dir_mode: 2775
#    - file_mode: '0644'
#    - include_empty: True
#
# /home/vagrant/.vimrc:
#   file.managed:
#     - source: salt://edit/vimrc
#    - mode: 644
#    - user: vagrant
#    - group: vagrant
